# Briefing: Aula 03, QGIS + PostGIS: erros silenciosos

**Fonte:** references/ (pdf + texto), cópia de SegundoGrupo/Aula03
- apostila_qgis_postgis_erros_silenciosos.pdf (10 páginas)
- kit/demo.sql e kit/LEIA-ME.txt (gabarito do exercício)
- _tema.md (estrutura de 12 slides aprovada pela Piah)

**Data da extração:** 22/09/2026

## Essência em uma frase

Terceira aula do curso de geoprocessamento de Toledo-PR para servidores municipais: os problemas mais caros em QGIS + PostGIS não geram mensagem de erro, geram resultado errado (zero linhas, join que não casa, mapa 60 m deslocado, ordenação estranha), e quase sempre a causa é um detalhe pequeno: acento, espaço, maiúscula, caminho longo.

Formato: 20 minutos, só slides, 12 slides (~1,5 min cada).

## Conceitos-chave (candidatos a slide)

1. **Capa** — QGIS + PostGIS: erros silenciosos que ninguém avisa — visual: vídeo de fundo + título
2. **O erro que não grita** — o problema não aparece como erro, aparece como filtro vazio, join que não casa, mapa deslocado, ordenação "errada". Regra que resolve 80%: minúsculas, sem acento, sem espaço, snake_case, caminho curto `C:\gis\projeto\` — visual: comparação "erro que grita × erro silencioso"
3. **Limites do shapefile (DBF, 1998)** — nome de campo 10 caracteres (`nome_completo` vira `nome_compl`; dois campos viram `nome_com_1`, `nome_com_2`), texto 254 caracteres (corta), sem NULL (texto vazio vira ''), sem booleano, sem data+hora, 2 GB por arquivo, 3+ arquivos obrigatórios. Alternativa: GeoPackage — visual: grade/tabela de limites
4. **.cpg e .prj ausentes** — sem .cpg o QGIS adivinha a codificação: `São José` vira `SÃ£o JosÃ©`; teste: `length(nome)` (8 caracteres correto, 10+ corrompido). Sem .prj o QGIS assume CRS; SAD69 (29192) assumido como SIRGAS 2000 / UTM 22S (31982) desloca ~60 m e o QGIS desenha "no lugar"; SIRGAS × WGS84 difere < 1 m — visual: mapa com camada deslocada
5. **Nomes no PostGIS** — sem aspas duplas tudo vira minúsculo; com aspas, preserva e exige aspas para sempre. Aspas simples = texto, duplas = coluna (`WHERE nome = "Centro"` → column "Centro" does not exist). Palavras reservadas (order, desc, user, group, table, type). Limite 63 bytes: só NOTICE, trunca; acento ocupa 2 bytes. Nome começando com número. Opção "Converter nomes de campo para minúsculas" do QGIS: deixar marcada — visual: código SQL
6. **Dados de texto** — caixa (`'TOLEDO' <> 'Toledo'`, usar ILIKE/lower), acento (`unaccent`), espaço no fim (`trim`), espaço NÃO-QUEBRÁVEL (NBSP, c2a0, trim não remove), vazio × NULL (DBF não tem NULL: `nullif(nome,'')`) — visual: comparação de strings "iguais" que não são
7. **Número como texto** — `ORDER BY area_ha` como texto: '95' > '180' > '100,5'; `'100,5'::numeric` falha → `replace(',', '.')`; collation C ordena "Água" depois de "Zumbi"; criar banco com pt_BR.UTF-8 — visual: ranking que se reordena
8. **Geometria inválida** — gravata-borboleta (auto-interseção): `ST_Area` = 0 porque os dois triângulos se anulam; `ST_Intersects/ST_Touches/ST_Within` retornam resultado imprevisível sem avisar; só `ST_Union` estoura com TopologyException. Corrigir: `ST_IsValid`, `ST_IsValidReason`, `ST_MakeValid` — visual: D3 polígono que se cruza
9. **QGIS e o banco** — sem chave primária inteira o QGIS abre só leitura ou usa ctid (edição some após VACUUM); metadados estimados sem ANALYZE fazem o zoom ir para o lugar errado; view sem tipo declarado vira GEOMETRY/SRID 0 → declarar `geom::geometry(MultiPolygon, 31982)`; Polygon e MultiPolygon misturados: QGIS mostra só um tipo — visual: lista de 3 cartões
10. **Windows** — MAX_PATH 260 (shapefile salvo pela metade), acento/espaço no caminho quebra GRASS, SAGA e plugins Python (saída vazia), OneDrive sincronizando (.lock, projeto corrompido), Windows ignora maiúsculas e Linux não (quebra no GeoServer), ZIP com acento, caminho absoluto no projeto, temporários em %TEMP%. Regra: `C:\gis\projeto\`, nunca `C:\Users\João Silva\OneDrive - Prefeitura\Documentos\...` — visual: caminho longo encolhendo
11. **Exercício: o shapefile sujo** — bairros_sujo.shp (8 bairros fictícios perto de Toledo), sem .cpg e sem .prj, com todas as armadilhas. 3 perguntas — visual: 3 cartões pergunta/ingênuo/correto
12. **Checklist e fecho** — 12 sintomas → causa → verificação; mensagem: "o que esse resultado silencioso pode estar escondendo?" antes de aceitar zero linhas, um mapa bonito ou uma ordenação estranha — visual: checklist + CTA

## Dados e números

- DBF: campo 10 caracteres, texto 254, arquivo 2 GB, formato de 1998
- PostgreSQL: identificador 63 bytes (acento UTF-8 = 2 bytes)
- Windows MAX_PATH: 260 caracteres
- SAD69 × SIRGAS 2000: ~60 m de deslocamento; SIRGAS × WGS84: < 1 m
- EPSG 31982 (SIRGAS 2000 / UTM 22S), EPSG 29192 (SAD69 / UTM 22S)
- NBSP em UTF-8: bytes c2 a0
- "São José": 8 caracteres; versão corrompida: 10+; versão com NBSP: 9
- Regra geral resolve 80% dos casos

### Gabarito do exercício
| Pergunta | Resposta ingênua | Correta | Armadilha |
|---|---|---|---|
| Quantos bairros se chamam "São José"? | 1 | 2 | espaço não-quebrável no fim |
| Qual bairro tem a maior área? | Jardim Coopagro, 95 | Vila Industrial, 180 ha | número como texto + vírgula decimal |
| Quem faz fronteira com o Centro? | resultado imprevisível | 6 vizinhos, garantido após ST_MakeValid | geometria inválida |

## Trechos de código emblemáticos

```sql
-- Busca tolerante
SELECT count(*) FROM bairros
WHERE unaccent(lower(regexp_replace(nome, '[[:space:]\u00a0]+$', ''))) = 'sao jose';  -- 2
```

```sql
-- Número como texto
SELECT nome, replace(area_ha, ',', '.')::numeric AS area_ha
FROM bairros_sujo ORDER BY 2 DESC LIMIT 1;   -- Vila Industrial, 180
```

```sql
-- Geometria inválida
SELECT nome, ST_IsValidReason(geom) FROM bairros WHERE NOT ST_IsValid(geom);
UPDATE bairros SET geom = ST_Multi(ST_MakeValid(geom)) WHERE NOT ST_IsValid(geom);
```

```sql
-- View tipada
CREATE VIEW v_bairros AS
SELECT id, nome, geom::geometry(MultiPolygon, 31982) AS geom FROM bairros;
```

## Narrativa sugerida

Problema (erro que não grita) → onde ele nasce: shapefile → nomes no PostGIS → dados no PostGIS → geometria → QGIS → Windows → prática (exercício com 3 perguntas) → checklist e hábito ("desconfie do silêncio").

## Lacunas

- Sem imagens na fonte; visuais serão animações D3.
- O .docx não foi usado (parece resumo da apostila).
- A apostila tem autor "@Someone"; não há crédito a colocar.
