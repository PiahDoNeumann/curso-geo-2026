# Aula 04: Simbologia graduada e rotulação no QGIS

Quarta aula do curso de geoprocessamento de Toledo-PR (segundo grupo, servidores municipais), terça 29/09/2026.
Deck da parte teórica (~25 min, ~12 a 15 slides); depois a turma vai para a prática no QGIS.
Tema padrão mira-dark, template aula-capitulo (mesmo padrão das aulas 1 a 3).

## Pedido da Piah (textual)

- "Amanhã vou ensinar sobre rotulação no QGIS" → rotulação é o tema principal.
- "Graduação acabei não falando semana passada" → resgatar simbologia graduada no começo.
- "O SRC também vai ter uma aula específica, mas pode falar pra padronizar sempre na zona 22S, SRC 31982" → só um lembrete curto, sem teoria de projeção.
- Densidade, estatística e comparação de métodos de classificação (intervalo igual, quantil, quebras naturais) FICAM DE FORA: vão para a aula 6 (tabela de atributos). No graduado, usar o método padrão do QGIS e a leitura intuitiva "mais escuro = mais", "maior = mais".

## O que a turma já viu

- Aula 1: geoprocessamento, SIG, John Snow, QGIS x AutoCAD, geometria + atributo.
- Aula 2: anatomia do shapefile, ponto/linha/polígono, simbologia de símbolo único (cor, tamanho, contorno, transparência), coleta de dados, OpenLayers → QGIS.
- Aula 3: erros silenciosos QGIS + PostGIS (.cpg/.prj, texto x número, maiúsculas e acentos, geometria inválida, caminho no Windows).

## Estrutura sugerida

1. Capa.
2. Lembrete SRC: padronizar tudo em SIRGAS 2000 / UTM zona 22S, EPSG:31982 (metros). Onde conferir: Propriedades da camada > Fonte; canto inferior direito do QGIS (SRC do projeto). Aula específica de SRC virá depois.
3. Mapa dos renderizadores: símbolo único (visto na aula 2), categorizado (qualidade: tipo), graduado (quantidade: quanto), baseado em regras (condição). Hoje: graduado e regras, com revisão rápida do categorizado.
4. Categorizado, revisão rápida com ACIDENTES_TRANSITO por TIPO_ACID_: COLISÃO, ATROPELAMENTO, CAPOTAMENTO, "Saída de pista" (caixa diferente, ponte com aula 3) e valores nulos (caem em "todos os outros valores").
5. Graduado por cor: bairros_ibge_2022 por populacao (Censo 2022). Rampa sequencial, mais escuro = mais gente. Vila Pioneiro 18.782 hab. no topo; Cerâmica Prata 14; Sadia sem dado (sigilo do IBGE, fica NULL).
6. Graduado por tamanho: ACIDENTES_TRANSITO por VITIMAS (0 a 8 vítimas por ocorrência, 724 no total em 2025). Círculo maior = mais vítimas.
7. Baseado em regras: destacar só o que importa. "GRAVIDADE" = 'Grave' AND "VITIMAS" >= 2 → 47 de 402 acidentes. Gravidade: Leve, Moderada, Grave, Fatal.
8. Salvar e reaproveitar estilo: .qml (Estilo > Salvar estilo / Carregar estilo).
9. Rotulação: onde fica (Propriedades > Rótulos), rótulo único x baseado em regras, valor = campo ou expressão.
10. Posição por geometria: ponto (ao redor/deslocado), linha (paralelo ou curvo, ex.: estradas rurais OT-322, OT-107), polígono (horizontal no centroide, ex.: nome do bairro).
11. Legibilidade: fonte, tamanho, halo (buffer) para ler sobre ortofoto, sombra/fundo com parcimônia.
12. Conflito e prioridade: o QGIS esconde rótulo que colide; prioridade decide quem sobrevive; "mostrar todos os rótulos" polui.
13. Visibilidade por escala: rótulo só aparece a partir de certa escala (ex.: nome de estrada só abaixo de 1:50.000). Principal remédio contra mapa ilegível.
14. Expressões no rótulo: "nome" || ' (' || "tipo" || ')' nas estradas; "nome" || '\n' || format_number("populacao", 0) nos bairros → "Vila Pioneiro / 18.782". Rótulo por regras: fonte maior para RODOVIA ESTADUAL.
15. Exercício / mini-desafio: mapa dos bairros com simbologia graduada por população + rótulo nome e população com separador de milhar, legível em duas escalas; acidentes graves destacados por regra.
16. Fecho: camada simbolizada e rotulada é a base do mapa final (compositor de impressão, próximas aulas).

## Dados da prática (todos já em EPSG:31982)

Pasta SegundoGrupo/Aula03/AULA 03/:
- ACIDENTES_TRANSITO.shp: 402 pontos, 2025. Campos ID, DATA, HORA, TIPO_ACID_ (COLISÃO, ATROPELAMENTO, CAPOTAMENTO, Saída de pista, nulo), GRAVIDADE (Leve, Moderada, Grave, Fatal, nulo), VITIMAS (0 a 8), GRAU_GRAV. (1 a 4).
- ESTRADAS_RURAIS_NOVO_SARANDI.shp: 90 linhas. Campos tipo (ACESSO 42, RODOVIA MUNICIPAL 46, RODOVIA ESTADUAL 2), nome (OT-110 B, OT-322, OT-107, OT-405...), compriment (m).
- DELIMITACAO_QUADRAS_E_VIAS.shp: 2.677 polígonos de quadra, campos perímetro e área_m².
- BAIRROS.shp: 25 bairros da prefeitura, só id e nome (em maiúsculas).

Pasta SegundoGrupo/Aula04/:
- populacao_toledo_ibge2022.gpkg, camada bairros_ibge_2022: 22 bairros urbanos do IBGE, Censo 2022, campos nome, populacao, domicilios, moradores_por_dom, area_km2 (131.938 hab. no total urbano; município 150.470). A camada setores_ibge_2022 e o campo densidade_hab_km2 ficam para a aula 6, não usar neste deck.
