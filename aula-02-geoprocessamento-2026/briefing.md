# Briefing: Aula 02, Shapefiles, Simbologia e Coleta de Dados

**Fonte:** decks/curso-geo-toledo-2026-aula-02/references/_tema.md (texto, relato direto do usuário sobre a aula de amanhã)
**Data da extração:** 14/09/2026

## Essência em uma frase

Segunda aula do curso de geoprocessamento de Toledo-PR, que desce da teoria da aula 1 para o dado vetorial na prática: como o shapefile é estruturado, como cada geometria é simbolizada, como se coleta dado em campo, e como um polígono desenhado num mapa web em OpenLayers chega até o QGIS.

## Conceitos-chave (candidatos a slide)

1. **Ponte com a aula 1** — retoma "geometria mais atributo" da aula anterior, agora vamos abrir o shapefile e ver isso por dentro — visual: transição simples
2. **Anatomia do shapefile** — não é um arquivo, é um conjunto: .shp (geometria), .shx (índice), .dbf (tabela de atributos), .prj (referência espacial), mais opcionais .cpg/.sbn/.qmd. Perder um arquivo do conjunto quebra a camada — visual: d3-fluxo ou diagrama de peças
3. **Os três tipos de geometria vetorial** — ponto, linha, polígono, um shapefile guarda um tipo só — visual: comparacao radial ou grade de 3
4. **Simbologia de pontos** — marcador, ícone, tamanho, cor — visual: exemplos lado a lado
5. **Simbologia de linhas** — espessura, estilo, tracejado — visual: exemplos lado a lado
6. **Simbologia de polígonos** — preenchimento, contorno, transparência, hachura — visual: exemplos lado a lado
7. **Formas de coletar dado espacial** — GPS de navegação, GNSS/RTK de precisão, digitalização sobre imagem, dados de terceiros (IBGE, prefeitura), coleta em campo com app móvel (QField, Mergin, Survey123), drone com ortomosaico — visual: grade de pílulas ou metricas
8. **OpenLayers, mapa na web** — biblioteca JavaScript para mapa interativo no navegador, sem instalar nada no cliente, contra o QGIS desktop para análise pesada — visual: comparacao
9. **Caso prático, polígono de queimada** — desenhar/editar o polígono no mapa OpenLayers, salvar a geometria (GeoJSON ou banco), depois abrir no QGIS para checar, corrigir e cruzar com outras camadas — visual: d3-fluxo linear
10. **O elo de volta ao QGIS** — o que liga o desenho na web ao QGIS é o formato ou o banco compartilhado (GeoJSON, PostGIS, WFS), e para o QGIS entender precisa ser geometria válida, reforça o conceito do shapefile do início — visual: d3-fluxo com destaque sincronizado
11. **Transição para a prática** — a aula continua com mão na massa fora do deck — visual: painel de fechamento

## Dados e números

- Extensões obrigatórias do shapefile: `.shp`, `.shx`, `.dbf`, `.prj`
- Extensões opcionais: `.cpg`, `.sbn`, `.sbx`, `.qmd`
- Três tipos de geometria vetorial: ponto, linha, polígono
- Formatos de troca web-QGIS citados: GeoJSON, PostGIS, WFS
- Curso: aula 2 de 10, 15/09/2026, professores Romano (bloco shapefile/simbologia/coleta) e Valdecir (bloco OpenLayers/QGIS)

## Trechos de código emblemáticos

Não há código-fonte a mostrar (a aula é conceitual, a parte prática de OpenLayers acontece ao vivo, fora do deck). Se quiser, dá para adicionar um trecho ilustrativo de GeoJSON de um polígono como exemplo visual no bloco 9.

## Narrativa sugerida

**Arco em três tempos:**
1. **Ponte** (1 painel): retomada rápida da aula 1.
2. **O dado vetorial por dentro** (6 a 7 painéis, bloco Romano): anatomia do shapefile, os três tipos de geometria, simbologia de cada um, formas de coletar dado.
3. **Do navegador ao QGIS** (3 a 4 painéis, bloco Valdecir): OpenLayers, caso prático da queimada, o elo de volta ao QGIS.

Fecha com painel de transição para a prática.

## Lacunas

- Sem shapefile real de Toledo para ilustrar (a aula 1 tinha o lote da Rua Primavera como exemplo concreto, esta aula é mais técnica e genérica). Se surgir um exemplo real depois, dá pra enriquecer o slide de anatomia do shapefile.
- Sem detalhe da ferramenta exata que o Valdecir vai usar para editar/salvar o GeoJSON antes do QGIS (assumido fluxo GeoJSON ou banco compartilhado).
- PDF em `Docs/aula-02` (Azimute e Rumo) é de topografia, sem relação com o conteúdo desta aula, não foi usado.
