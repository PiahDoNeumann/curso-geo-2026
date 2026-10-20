# Plano de Slides: Aula 07, ferramentas de geoprocessamento do QGIS

**Fonte:** `briefing.md` (derivado de `references/`)
**Template do deck:** `escola-governo` (capa com vídeo, glass-card com animação D3 em loop, encerramento com logo)
**Vídeo header:** `header-bg.mp4` (identidade da Escola de Governo, mantido)
**Vídeos internos:** nenhum
**Imagens:** só `logo.png`. Sem prints: tudo animado.
**Capa:** 20/10/2026 · Romano e Valdecir
**Total de slides:** 16

| # | Título (rascunho) | Tipo | Conteúdo resumido |
|---|---|---|---|
| 1 | Capa: Cada ferramenta responde a uma pergunta | capa grid | Aula 7 de 10. Números: 7ª aula, 11 ferramentas, 4 já conhecidas, 500 m de buffer. |
| 2 | Vocês já conhecem 4 delas | d3-menu | O menu Vetor > Ferramentas de Geoprocessamento desenhado item a item; Interseção, União, Diferença e Diferença simétrica acendem com o símbolo da aula 06 (∩ ∪ − △). Loop: o destaque percorre os 4. |
| 3 | E e OU viram botão | d3-comparacao | Interseção e União com camadas reais: cobertura das escolas × micropolos. Interseção traz atributos das duas; União mantém tudo e recorta onde sobrepõe. Pílulas: ordem não importa. |
| 4 | MAS NÃO e UM OU OUTRO | d3-comparacao | Diferença: bairro menos cobertura = o que ficou de fora; camada de entrada × sobreposição, ordem muda. Diferença simétrica: duas versões de um limite, o que mudou. |
| 5 | Buffer: até onde chega? | d3-fluxo | Ponto vira círculo, linha vira faixa, polígono engorda. Círculos sobrepostos; opção "Dissolver resultado" funde. Usos: raio de cobertura, faixa não edificável. |
| 6 | 500 graus não é 500 metros | d3-destaques | Regra de ouro. Lado a lado: buffer de 500 em EPSG:4674 explode e cobre o planeta; em EPSG:31982 vira o círculo certo em volta da escola. "Medir em graus não dá erro: dá número errado." |
| 7 | Reprojete antes de medir | cta | Chamada para a prática: Exportar > Salvar como, EPSG:31982, antes de qualquer buffer ou área. Card leve, ícone e passo único. |
| 8 | Recortar não é interseção | d3-destaques | Tesoura de forma: o limite do bairro cai sobre `logradouro` e só o que está dentro fica. Comparação: recorte leva atributos só da entrada; interseção leva das duas. |
| 9 | Envoltória convexa: o elástico | d3-fluxo | Pontos de `ocorrencia` como pregos; um elástico se fecha em volta. Área de abrangência aproximada. Limite: em forma côncava, exagera (área vazia sombreada). |
| 10 | Poligonizar: linha fechada vira área | d3-fluxo | Linhas desenhadas se encontram e cada anel fechado ganha preenchimento: quadras a partir de eixos ou de CAD. Linha que não fecha (falha de snapping) não vira nada. Caminho: Vetor > Ferramentas de Geometria. |
| 11 | Dissolver: some a fronteira de dentro | d3-fluxo | Bairros coloridos por região administrativa; as divisas internas apagam e sobram as regiões. Sem campo, vira um polígono só. Atributo que não é o agrupador some. |
| 12 | Eliminar: a lasca vai para o vizinho | d3-fluxo | Depois de uma interseção, sobram lascas finas. Seleciona a lasca, ela é absorvida pelo vizinho de maior área ou maior fronteira comum. Ponte para seleções (aula 8). |
| 13 | Junção espacial: quantos caem em cada? | d3-metricas | Pontos de `ocorrencia` caem sobre os bairros; contador sobe em cada um e o mapa vira graduado. "Unir atributos por localização (resumo)". Ligação pela posição, não pelo código. |
| 14 | Do português para a ferramenta | tabela animada | Dicionário: "até onde chega?" → Buffer; "só dentro do bairro" → Recortar; "juntar por região" → Dissolver; "que área esses pontos ocupam?" → Envoltória; "quantos em cada?" → Junção espacial; "o que ficou de fora?" → Diferença. Linhas acendem em loop. |
| 15 | Mini-desafio: quem fica sem escola? | timeline | Cadeia: reprojetar → buffer 500 m (dissolvido) → diferença ou junção espacial com `bairro` → mapa. Pergunta: quais bairros nenhum buffer alcança? |
| 16 | Encerramento | citação | "Toda ferramenta responde a uma pergunta. Comece pela pergunta." Pílulas: Buffer, Recortar, Dissolver, Junção espacial acendendo em sequência. Logo. |

## Ritmo
Abertura com números (1) → retomada leve (2) → bloco de conjuntos (3, 4) → criar forma com a armadilha no meio (5, 6, 7 CTA) → cortar e criar (8, 9, 10) → reorganizar (11, 12, 13) → síntese (14, 15) → fechamento (16).

## Regra zero
Toda animação entra com coreografia e depois segue em loop interno (destaque percorrendo, pulso, contador reiniciando). Cores só via `var(--mira-*)`.

## Imagens a gerar
Nenhuma.
