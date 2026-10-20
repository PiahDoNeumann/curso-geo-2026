# Briefing: Aula 07, ferramentas de geoprocessamento do QGIS
**Fonte:** references/ do deck (texto + print), derivado de `Docs/Curso2026-02/curso-plano-de-aula-foco-qgis.md` (seção Aula 8, dados de trabalho, convenção de SRC)
**Data da extração:** 2026-10-20

## Essência em uma frase
Para servidores da Prefeitura de Toledo: as 9 ferramentas do menu Vetor > Ferramentas de Geoprocessamento, mais Poligonizar e Junção espacial, cada uma como resposta a uma pergunta de território, e a regra que impede o erro mais caro do curso: medir em metros (EPSG:31982), nunca em graus.

## Ponte com a aula 06
A aula 06 ensinou a lógica de conjuntos sem abrir o QGIS: E (∩), OU (∪), MAS NÃO (−), UM OU OUTRO (△). Quatro ferramentas do menu são exatamente essas operações. A aula 07 começa por elas ("vocês já sabem isso, agora é só achar o botão") e depois avança para as que **criam geometria nova** (buffer, envoltória, poligonizar) ou **reorganizam** (dissolver, eliminar, junção espacial).

## Conceitos-chave (candidatos a slide)

### Bloco A: retomada, conjunto vira ferramenta
1. **Interseção** — "o que está em A e em B". Ex.: cobertura das escolas ∩ micropolos = onde há sobreposição de atendimento. Ordem não importa. — d3-comparacao (Venn → camadas reais)
2. **União** — junta as duas camadas, preserva atributos dos dois lados, recorta onde sobrepõem. Ordem não importa. — d3-comparacao
3. **Diferença** — "o que é de A e não de B". Ex.: área do bairro fora de toda cobertura. A ordem muda tudo (camada de entrada vs camada de sobreposição). — d3-comparacao
4. **Diferença simétrica** — "um ou outro, nunca os dois". Uso: comparar duas versões de um limite e achar o que mudou. — d3-comparacao

### Bloco B: criam ou cortam geometria
5. **Buffer** — área de influência a uma distância fixa. Raio de cobertura, faixa não edificável, distância mínima. Ponto vira círculo, linha vira faixa, polígono engorda. Opção "Dissolver resultado" funde os círculos sobrepostos. — d3-fluxo (ponto → círculo crescendo)
6. **Regra de ouro (slide próprio)** — buffer de 500 em EPSG:4674 é 500 **graus**, cobre o planeta. Reprojetar para EPSG:31982 antes de qualquer buffer ou área. "Medir em graus não dá erro: dá número errado." — d3-comparacao (graus × metros)
7. **Recortar (clip)** — "cortar com tesoura de forma": limita uma camada ao contorno de outra; atributos só da camada de entrada. Ex.: `logradouro` dentro de um bairro. Diferente da interseção, que traz atributos das duas. — d3-fluxo (molde caindo sobre a camada)
8. **Envoltória convexa (convex hull)** — o menor polígono convexo que contém todas as feições, o "elástico esticado em volta dos pregos". Uso: área de abrangência aproximada de um conjunto de ocorrências ou de alunos. Limitação: exagera em formas côncavas. — d3-fluxo (elástico se fechando em pontos)
9. **Poligonizar** (Vetor > Ferramentas de Geometria) — linhas fechadas viram polígonos. Uso: quadras a partir de eixos ou meio-fios digitalizados como linha, CAD importado (DWG/DXF da aula 3). Exige linhas que realmente se encontram (snapping). — d3-fluxo (linhas fechando → preenchimento)

### Bloco C: reorganizam
10. **Dissolver** — funde feições que têm o mesmo valor num campo; sem campo, funde tudo numa só. Ex.: `bairro` → regiões administrativas. Some a fronteira interna, somem os atributos que não são o campo de agrupamento. — d3-fluxo (fronteiras internas sumindo)
11. **Eliminar polígonos selecionados** — junta polígonos selecionados (geralmente lascas, *slivers*) ao vizinho com maior área, maior fronteira comum ou menor área. Depende de seleção prévia (ponte para a aula 8, seleções). Uso: limpar resto de interseção/união. — d3-fluxo (lasca absorvida pelo vizinho)
12. **Junção espacial** (Caixa de processamento: "Unir atributos por localização" e "... (resumo)") — trazer atributo pela posição, não pelo código. Contar `ocorrencia` por `bairro` e fazer mapa graduado. Predicados: intersecta, contém, está dentro. — d3-metricas (pontos caindo e contador por polígono)

### Fechamento
13. **Do português para a ferramenta** — tabela-dicionário: pergunta de território → ferramenta. "Até onde chega?" → buffer; "Só dentro do bairro" → recortar; "Juntar por região" → dissolver; "Qual a área que esses pontos ocupam?" → envoltória; "Quantos caem em cada?" → junção espacial; "O que ficou de fora?" → diferença. — d3-comparacao (dicionário, como no slide 10 da aula 06)
14. **Caixa de ferramentas de processamento** — achar qualquer algoritmo pelo nome; tudo do menu também está lá, com execução em lote. — codigo/print
15. **Mini-desafio** — quais bairros não são alcançados por nenhum buffer de 500 m de escola? Encadeia: reprojetar → buffer (dissolvido) → diferença ou junção espacial → mapa. — d3-fluxo (cadeia)

## Dados e números
- 9 ferramentas no menu Vetor > Ferramentas de Geoprocessamento + 2 de fora = **11 ferramentas**.
- 4 delas já vistas como conjunto na aula 06.
- Buffer de prática: **500 m** em `escola` e `posto_saude`.
- SRC: **EPSG:4674** (SIRGAS 2000 geográfico, graus) para guardar; **EPSG:31982** (SIRGAS 2000 / UTM 22S, metros) para medir.
- Camadas do conjunto de Toledo: `bairro`, `municipio`, `micropolo` (polígono); `escola`, `posto_saude`, `ocorrencia` (ponto); `logradouro` (linha).
- Encontro de 3h: 10 retomada, 20–30 teoria, 45 demonstração, 15 intervalo, 60 exercício guiado, 20 mini-desafio, 10 fechamento.

## Trechos de código emblemáticos
Não se aplica (aula de interface QGIS). Possível card de "caminho no menu":
- `Vetor > Ferramentas de Geoprocessamento > Buffer...`
- `Vetor > Ferramentas de Geometria > Poligonizar...`
- `Processamento > Caixa de Ferramentas > Unir atributos por localização (resumo)`

## Narrativa sugerida
1. **Retomada**: "na aula passada vocês resolveram geometria sem clicar em nada". Print do menu: 4 dos 9 itens já são conhecidos.
2. **Conjunto vira botão**: interseção, união, diferença, diferença simétrica, com camadas reais de Toledo.
3. **Problema**: a prefeitura pergunta "até onde a escola atende?". Entra o buffer, e com ele a armadilha dos graus. Regra de ouro.
4. **Cortar e criar forma**: recortar, envoltória convexa, poligonizar.
5. **Reorganizar**: dissolver, eliminar polígonos, junção espacial (contar por bairro).
6. **Dicionário**: pergunta → ferramenta.
7. **Mini-desafio** e fechamento com a frase-âncora.

Sugestão de frase-âncora de encerramento: "Toda ferramenta responde a uma pergunta. Comece pela pergunta."

## Lacunas
- Data e horário da aula 07 (capa usa DD/MM/AAAA; supor 20/10/2026?).
- Instrutores: manter "Romano e Valdecir"?
- Existe camada de regiões administrativas ou campo de região em `bairro` para o dissolver?
- Há prints reais do QGIS (janelas de cada ferramenta) para usar nos slides, ou tudo vira animação?
- Exemplo concreto para Poligonizar: há um DWG/DXF ou camada de linhas fechadas no projeto de Toledo?
- Quantidade de slides desejada (aula 06 teve 14).
