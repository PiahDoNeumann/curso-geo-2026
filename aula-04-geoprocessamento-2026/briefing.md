# Briefing: Aula 04, Simbologia graduada e rotulação no QGIS
**Fonte:** referências locais do deck (texto) — `decks/2026-09-28 curso-geo-toledo-2026-aula-04/references/_tema.md`, mais consulta direta às camadas da prática (`SegundoGrupo/Aula03/AULA 03/`, `SegundoGrupo/Aula04/populacao_toledo_ibge2022.gpkg`)
**Data da extração:** 28/09/2026

## Essência em uma frase

Quarta aula do curso de Toledo-PR (segundo grupo, servidores municipais): fecha a simbologia com o graduado e as regras, e ensina a rotular sem poluir, usando dados reais do município (acidentes de trânsito de 2025, estradas rurais de Novo Sarandi e população do Censo 2022 por bairro).

## Conceitos-chave (candidatos a slide)

1. **Lembrete de SRC: tudo em 31982** — padronizar em SIRGAS 2000 / UTM 22S (metros) antes de simbolizar e rotular; onde conferir no QGIS. Aula específica de SRC virá depois — visual: metricas (pílulas com o código)
2. **Os quatro renderizadores** — único (aula 2), categorizado (qualidade), graduado (quantidade), regras (condição). Pergunta que decide: "o campo diz O QUÊ ou QUANTO?" — visual: comparacao em grade 2x2
3. **Categorizado, revisão** — acidentes por tipo; "Saída de pista" com caixa diferente vira uma categoria à parte, nulos caem em "todos os outros valores" — visual: d3 com pontos coloridos por categoria
4. **Graduado por cor** — bairros do IBGE por população: rampa sequencial, mais escuro = mais gente; Vila Pioneiro no topo — visual: d3 coroplético estilizado
5. **Graduado por tamanho** — acidentes por número de vítimas: círculo maior = mais vítimas — visual: d3 círculos proporcionais
6. **Baseado em regras** — só os acidentes graves com 2+ vítimas acendem: 47 de 402 — visual: d3 campo de pontos com filtro
7. **Estilo reaproveitável (.qml)** — salvar uma vez, carregar em outra camada ou outro projeto — visual: fluxo simples
8. **Rotulação: onde e o quê** — Propriedades > Rótulos; valor vem de um campo ou de uma expressão — visual: card_lista
9. **Posição por geometria** — ponto ao redor, linha acompanhando o traçado, polígono no centro — visual: d3 três geometrias com rótulo
10. **Halo e legibilidade** — texto sobre ortofoto some; halo (buffer) devolve o contraste — visual: d3 antes/depois
11. **Conflito e prioridade** — o QGIS esconde rótulo que colide; prioridade decide quem fica — visual: d3 rótulos se empurrando
12. **Visibilidade por escala** — rótulo aparece só a partir de certa escala; principal remédio contra mapa ilegível — visual: d3 zoom com rótulos surgindo
13. **Expressões no rótulo** — concatenar campos e formatar número com separador de milhar; rótulo por regras (fonte maior para rodovia estadual) — visual: codigo
14. **Mini-desafio** — bairros graduados por população + rótulo com nome e população, legível em duas escalas; acidentes graves por regra — visual: cta
15. **Fecho** — camada simbolizada e rotulada é a base do mapa final no compositor — visual: citacao

## Dados e números

**SRC do curso (padrão da prática)**
- SIRGAS 2000 / UTM zona 22S, **EPSG:31982**, unidade metro. Todas as camadas da prática já estão nele.

**ACIDENTES_TRANSITO.shp** (pontos, ano 2025)
- 402 ocorrências, de 01/01/2025 a 01/12/2025
- TIPO_ACID_: COLISÃO, ATROPELAMENTO, CAPOTAMENTO, "Saída de pista" (grafia diferente das demais), nulo
- GRAVIDADE: Leve, Moderada, Grave, Fatal, nulo; GRAU_GRAV. de 1 a 4
- VITIMAS: 0 a 8 por ocorrência, 724 vítimas no total
- 100 acidentes graves; 47 graves com 2 ou mais vítimas

**ESTRADAS_RURAIS_NOVO_SARANDI.shp** (linhas)
- 90 trechos: ACESSO 42 (21,7 km), RODOVIA MUNICIPAL 46 (105,5 km), RODOVIA ESTADUAL 2 (27,5 km)
- Nomes: OT-110 B, OT-322, OT-107, OT-405, OT-201, OT-426, OT-320, OT-322A

**bairros_ibge_2022** (populacao_toledo_ibge2022.gpkg, Censo 2022)
- 22 bairros urbanos, 131.938 habitantes (município inteiro: 150.470)
- Maiores: Vila Pioneiro 18.782; Jardim Coopagro 14.074; Jardim Europa/América 13.260; Centro 13.058; São Francisco 10.074
- Menores: Jardim Independência 432; Cerâmica Prata 14; Sadia sem dado (sigilo do IBGE, NULL)

**BAIRROS.shp** (prefeitura): 25 bairros, só nome, em maiúsculas.
**DELIMITACAO_QUADRAS_E_VIAS.shp**: 2.677 quadras.

## Trechos de código emblemáticos

Expressões do QGIS (construtor de expressões):

```
"GRAVIDADE" = 'Grave' AND "VITIMAS" >= 2
```

```
"nome" || ' (' || "tipo" || ')'
```
→ `OT-322 (RODOVIA MUNICIPAL)`

```
"nome" || '\n' || format_number("populacao", 0)
```
→ `Vila Pioneiro` / `18.782`

## Narrativa sugerida

1. **Abertura** (capa + lembrete de SRC).
2. **Fechar a simbologia** (4 a 5 painéis): mapa dos renderizadores → categorizado rápido → graduado por cor → graduado por tamanho → regras → .qml.
3. **Rotular sem poluir** (5 a 6 painéis): onde fica → posição por geometria → halo → conflito → escala → expressões.
4. **Mão na massa** (desafio) e fecho.

Arco: o mapa já tem cor, agora precisa dizer "quanto" e "quem". Graduado responde quanto; rótulo responde quem; escala e prioridade impedem que o mapa grite tudo ao mesmo tempo.

## Lacunas

- Métodos de classificação, densidade e estatística ficam de fora por decisão da Piah (aula 6). No graduado, usar o método padrão sem discutir.
- Sem prints reais do QGIS; os visuais serão animações D3 estilizadas, não capturas de tela.
- Anotações (texto livre e seta) e rótulo com fundo/sombra: mencionar de passagem, sem slide próprio.
