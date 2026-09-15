# Tema do deck

**Título:** Aula 02, Shapefiles, Simbologia e Coleta de Dados

**Instituição:** Escola de Governo, Município de Toledo-PR

**Curso:** Geoprocessamento Aplicado à Administração Pública Municipal (continuação da aula 1, `decks/curso-geo-toledo-2026`)

**Data:** 15/09/2026, aula 2 de 10, professores Romano e Valdecir

## Do que trata

Segunda aula do curso. Depois da aula 1 (o que é geoprocessamento, SIG, John Snow, QGIS contra AutoCAD), esta aula desce para o dado vetorial na prática: como um shapefile é estruturado por dentro, como cada tipo de geometria é simbolizado, quais são as formas de coletar dado espacial em campo, e um caso prático de mapeamento web (OpenLayers) integrado ao QGIS.

## Para quem

Mesmo público da aula 1: servidores municipais das secretarias, sem conhecimento prévio em SIG.

## Duração alvo

Deck para aproximadamente 30 minutos de apresentação (a aula em si tem 3h, mas inclui prática que não entra no deck).

## Conceitos-chave (candidatos a slide)

**Bloco 1, estrutura de shapefiles (professor Romano)**
1. O que é um shapefile: não é um arquivo único, é um conjunto de arquivos que precisam viajar juntos (.shp geometria, .shx índice, .dbf tabela de atributos, .prj sistema de referência, opcionais .cpg, .sbn, .qmd). Perder um arquivo do conjunto quebra a camada.
2. Os três tipos de geometria vetorial: ponto, linha e polígono. Cada shapefile guarda um tipo só (não mistura).
3. Simbologia por tipo de geometria: pontos (marcadores, ícones, tamanho, cor), linhas (espessura, estilo, padrão tracejado), polígonos (preenchimento, contorno, transparência, hachura). A simbologia certa comunica a informação antes do usuário abrir a tabela de atributos.
4. Formas de coletar dado espacial: GPS de navegação, GPS/GNSS de precisão (RTK), digitalização em tela sobre imagem de satélite ou ortofoto, importação de dados de terceiros (IBGE, prefeitura, órgãos ambientais), coleta em campo com aplicativo móvel (ex. QField, Mergin, Survey123), drone/VANT para ortomosaico e depois digitalização.

**Bloco 2, mapa web com OpenLayers e integração QGIS (Valdecir)**
5. OpenLayers como biblioteca JavaScript para mapas na web: por que usar (mapa interativo no navegador, sem instalar nada no cliente) contra QGIS (desktop, análise pesada).
6. Caso prático: lançar polígonos de área queimada no mapa OpenLayers. Fluxo: desenhar/editar o polígono na interface web, salvar a geometria (ex. GeoJSON ou direto num banco), depois abrir o mesmo dado no QGIS para checar, corrigir ou analisar junto com outras camadas.
7. Integração QGIS-web: o ponto de encontro é o formato ou o banco compartilhado (GeoJSON, PostGIS, WFS). O que é desenhado na web tem que ser um shapefile/geometria válida para o QGIS entender, reforça o bloco 1.

## Narrativa sugerida

**Arco em três tempos:**
1. **Ponte com a aula 1** (1 painel): recapitula rápido, agora que o servidor sabe que geometria mais atributo é o coração do SIG, hora de abrir o shapefile e ver isso na prática.
2. **O dado vetorial por dentro** (bloco Romano, ~6 a 7 painéis): anatomia do shapefile, os três tipos de geometria, simbologia de cada um, formas de coletar dado.
3. **Do desenho no navegador ao QGIS** (bloco Valdecir, ~3 a 4 painéis): OpenLayers como ferramenta de lançamento rápido, caso prático de polígono de queimada, o caminho de volta para o QGIS.

Fechar com painel de transição para a prática (a aula continua com mão na massa, fora do deck).

## Trechos técnicos

- Extensões do conjunto shapefile: `.shp`, `.shx`, `.dbf`, `.prj` (obrigatórios), `.cpg`, `.sbn`, `.sbx`, `.qmd` (opcionais).
- Formatos de troca mencionados: GeoJSON, PostGIS, WFS (retoma o que a aula 1 já citou sobre serviços OGC, previsto só para a aula 10, então aqui é só menção, não aprofundar).

## Fonte

Não há PDF ou PPTX de origem para esta aula especificamente (a pasta `Docs/aula-02` só tem um PDF de Azimute e Rumo, de topografia, sem relação com o conteúdo desta aula, não usar). Conteúdo vem de relato direto do usuário sobre o que os dois professores vão dar amanhã. Este arquivo é a fonte primária para o `/mira-extract`.

## Lacunas

- Sem exemplos numéricos de Toledo para este bloco (a aula 1 tinha o lote real, esta é mais conceitual e técnica). Se o usuário tiver um shapefile real do projeto QGIS de Toledo para ilustrar, pode enriquecer os slides de estrutura e simbologia.
- Sem detalhe de qual ferramenta o Valdecir vai usar para editar o GeoJSON antes de levar ao QGIS (assumido fluxo GeoJSON ou banco compartilhado, ajustar se o fluxo real for outro).
