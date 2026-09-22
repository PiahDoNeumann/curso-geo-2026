# Plano refinado: Aula 03, QGIS + PostGIS: erros silenciosos

Deck: 12 slides, ~20 min, só slides. Tema mira-dark. Template aula-capitulo.
Vídeo header: 13.mp4 (pessoa observando parede de dados: desconfiar do que se vê).
Imagens: nenhuma; todo visual é animação D3/CSS com loop interno (Regra Zero).
Regras: pt-BR com acentuação correta, sem travessão, títulos com no máximo 6 palavras.

## Slide 1: Capa
- Template: header (vídeo 13)
- Kicker: Aula 03 · Geoprocessamento na Gestão Municipal
- Título: O erro que não avisa
- Subtítulo: QGIS + PostGIS: as armadilhas que devolvem resultado errado sem nenhuma mensagem
- Nota: gancho de medo. O público já viu "zero linhas" e culpou o dado.

## Slide 2: O erro que não grita → Erro bom é erro que grita
- Template: card_destaques
- Subtítulo: O perigo é o resultado que parece certo
- Coluna A "Erro que grita": `ERROR: column "Centro" does not exist`, TopologyException, invalid byte sequence. Você para e corrige.
- Coluna B "Erro silencioso": filtro com zero linhas, join que não casa, mapa 60 m deslocado, ordenação estranha. Você segue e publica.
- Rodapé: Regra que resolve 80%: minúsculas, sem acento, sem espaço, snake_case, caminho curto `C:\gis\projeto\`
- Ícone: volume-x
- Animação: à esquerda, alarme pulsando em vermelho; à direita, resultado "0 linhas" que parece calmo e um pontinho de alerta que só aparece de perto (loop).

## Slide 3: Limites do shapefile → O shapefile corta calado
- Template: card_tabela
- Subtítulo: Formato de 1998: cada limite do DBF vira perda sem aviso
- Tabela (Limite | O que acontece | Como perceber):
  - Campo: 10 caracteres | `nome_completo` vira `nome_compl` | join por nome não casa
  - Texto: 254 caracteres | endereço e observação cortados | `length()` depois do import
  - Sem NULL | vazio vira `''` | `IS NULL` não acha nada
  - Sem booleano, sem data+hora | true vira 1, hora descartada | campo chega só com a data
  - 3+ arquivos obrigatórios | só o .shp = camada sem atributos | .shp + .shx + .dbf + .prj + .cpg juntos
- Destaque: GeoPackage (.gpkg) não tem nenhum desses limites e é um arquivo só.
- Ícone: scissors
- Animação: palavra `nome_completo` sendo "cortada" por uma tesoura no 10º caractere, em loop.

## Slide 4: .cpg e .prj ausentes → Sem .prj, o mapa mente
- Template: card_d3
- Subtítulo: Dois arquivos pequenos, dois erros invisíveis
- Esquerda (.cpg): `São José` → `SÃ£o JosÃ©`. Teste: `length(nome)`: 8 é certo, 10+ é corrompido.
- Direita (.prj): SAD69 (29192) assumido como SIRGAS 2000 (31982) desloca cerca de 60 m, e o QGIS desenha tudo "no lugar". SIRGAS × WGS84: menos de 1 m.
- Ícone: map-pin-off
- Animação D3: dois contornos de quadra; um desliza ~60 m e volta, régua mostra "≈ 60 m" (loop).

## Slide 5: Nomes no PostGIS → Aspas duplas são para sempre
- Template: card_code
- Subtítulo: Sem aspas vira minúsculo; com aspas, você carrega o erro
- Código:
```sql
CREATE TABLE Bairros ("Nome Bairro" text);  -- cria bairros... ou "Bairros"?
SELECT * FROM bairros WHERE nome = "Centro";
-- ERRO: column "Centro" does not exist  (texto é 'aspas simples')
SELECT ORDER FROM bairros;   -- ERRO: ORDER é palavra reservada
-- 63 bytes: nome longo é truncado só com NOTICE
```
- Pílulas: Minúsculas no import · Sem palavra reservada · Máx. 63 bytes
- Ícone: quote

## Slide 6: Dados de texto → Parece igual, não é
- Template: card_grid (4 itens)
- Subtítulo: Nenhum destes gera erro, só resultado diferente
- Caixa: `'TOLEDO' <> 'Toledo'` → `ILIKE`, `lower()`
- Acento: `'Sao Jose' <> 'São José'` → `unaccent()`
- Espaço invisível: NBSP no fim, `trim()` não remove → `regexp_replace` com `\u00a0`
- Vazio × NULL: DBF não tem NULL → `nullif(nome, '')`
- Ícone: equal-not
- Animação: duas etiquetas "São José" lado a lado; uma lupa passa e revela o espaço invisível (· destacado) na segunda (loop).

## Slide 7: Número como texto → 95 ganhou de 180
- Template: card_progresso
- Subtítulo: Área guardada como texto ordena pela primeira letra
- Barras (ORDER BY como texto → como número):
  - Jardim Coopagro 95 (1º como texto)
  - Vila Industrial 180 (1º como número)
  - Sem nome 100,5 (quebra o `::numeric`)
  - Santa Clara 100
- Correção: `replace(area_ha, ',', '.')::numeric`. Collation C põe "Água" depois de "Zumbi": crie o banco em pt_BR.UTF-8.
- Ícone: arrow-down-wide-narrow
- Animação: barras ordenadas por texto, depois se reordenam pelo valor real (loop).

## Slide 8: Geometria inválida → A gravata que zera a área
- Template: card_d3
- Subtítulo: Polígono que se cruza: área 0 e vizinhos imprevisíveis
- Conteúdo: auto-interseção faz os dois triângulos se anularem: `ST_Area = 0`. `ST_Intersects`, `ST_Touches`, `ST_Within` erram sem avisar; só `ST_Union` estoura.
- Código curto: `WHERE NOT ST_IsValid(geom)` → `ST_MakeValid(geom)`
- Ícone: triangle-alert
- Animação D3: quadrado cujo vértice se cruza e vira gravata-borboleta, os dois triângulos com sinais + e −, contador de área cai a 0; ST_MakeValid separa em 2 triângulos válidos (loop).

## Slide 9: QGIS e o banco → Três ajustes que o QGIS cobra
- Template: card_lista
- Subtítulo: Sem eles, a camada abre, mas mente
- 1. Chave primária inteira: sem ela o QGIS usa ctid e a edição some após um VACUUM
- 2. ANALYZE depois do import: sem ele o "zoom para a camada" vai para o lugar errado
- 3. View com tipo declarado: `geom::geometry(MultiPolygon, 31982)`, senão vira GEOMETRY com SRID 0
- Ícone: key-round

## Slide 10: Windows → Seu caminho quebra o GRASS
- Template: card_destaques
- Subtítulo: GDAL aguenta; GRASS, SAGA e plugins não
- Ruim: `C:\Users\João Silva\OneDrive - Prefeitura\Documentos\Secretaria\Geoprocessamento\2026\...` → acento, espaço, sincronização, limite de 260 caracteres
- Bom: `C:\gis\projeto\` → curto, minúsculo, fora do OneDrive, caminhos relativos no projeto
- Extra: Windows ignora maiúsculas, Linux não: `Bairros.shp` + `bairros.dbf` quebra no GeoServer
- Ícone: folder-x
- Animação: o caminho longo encolhe letra a letra até `C:\gis\projeto\` (loop).

## Slide 11: Exercício → Seu turno: o shapefile sujo
- Template: card_cta
- Subtítulo: 8 bairros, todas as armadilhas, 3 perguntas
- Perguntas:
  1. Quantos bairros se chamam "São José"?
  2. Qual bairro tem a maior área?
  3. Quem faz fronteira com o Centro?
- Instrução: descompacte o kit numa pasta com acento, importe pelo DB Manager e rode o demo.sql bloco a bloco.
- Botão: Abrir o kit
- Nota: NÃO revelar respostas (a apostila pede não contar antes).
- Ícone: flask-conical

## Slide 12: Checklist → Desconfie do silêncio
- Template: card_citacao
- Frase: "Antes de aceitar zero linhas, um mapa bonito ou uma ordenação estranha, pergunte: o que esse silêncio está escondendo?"
- Checklist em pílulas: `length()` · `trim()` · `ST_IsValid()` · `ST_SRID()` · `ANALYZE` · `C:\gis\`
- Ícone: ear
