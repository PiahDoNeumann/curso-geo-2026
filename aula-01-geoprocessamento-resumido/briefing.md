# Briefing: Geoprocessamento Aplicado à Administração Pública Municipal
**Fonte:** segundo-grupo (texto): SegundoGrupo/docs/apresentacao.md (19 slides extraídos do PowerPoint) + imagens/
**Data da extração:** 2026-09-06

## Essência em uma frase
Aula de abertura de um curso da Escola de Governo de Toledo-PR que ensina servidores municipais o que é geoprocessamento, por que a prefeitura está saindo do AutoCAD para o QGIS com PostGIS, e os conceitos base (SIG, vetor, raster, atributos) que sustentam o resto do curso.

## Conceitos-chave (candidatos a slide)
1. Capa e contexto institucional: Escola de Governo, Município de Toledo-PR, docentes, regras de presença e nota, estrutura UTFPR. Visual: capa com brasão.
2. Cronograma do curso: 8 encontros de 4h (25/04 a 27/06), de introdução até serviços OGC. Visual: timeline.
3. O que é geoprocessamento: 4 etapas, coletar, tratar, analisar e representar dados espaciais. Visual: d3-fluxo em 4 estágios.
4. Caso John Snow (Londres, 1854): 578 mortes por cólera mapeadas em pontos, poço contaminado identificado, interdição reduz mortes. Visual: mapa de pontos animado com poço no centro.
5. SIG: integração de programas, equipamentos, metodologias, dados e pessoas para produzir geoinformação que apoia decisões. Visual: 5 engrenagens/nós convergindo.
6. Glossário da cadeia: dados espaciais (matéria-prima), dados georreferenciados (coordenadas), SIG (ambiente), geoprocessamento (técnicas), geoinformação (resultado). Visual: staircase/pipeline.
7. Fluxo QGIS + banco geográfico: interface QGIS insere, integra, consulta, analisa e visualiza; tudo centralizado no banco. Visual: d3-fluxo hub-and-spoke.
8. Vantagens do banco geográfico: centralização, base para geoportais, apoio à decisão, compartilhamento entre secretarias, integração, múltiplos usuários, ferramenta intuitiva, principal ou auxiliar. Visual: lista de pílulas com check.
9. Exemplo real: cadastro imobiliário (BCI) x croqui CAD x QGIS para o lote 550 da Rua Primavera (540 m², 15 x 36 m, zona ZR4). Visual: comparacao lado a lado com imagens.
10. Contextualização histórica em Toledo: setor de geo criado ~2000, extinto 2005-2006, migração AutoCAD para QGIS em 2018, GeoPortal em 2019, empresa contratada em 2022. Visual: timeline.
11. AutoCAD x QGIS: 10 critérios (foco, estrutura, banco, consultas, análise, georreferenciamento, integração, uso típico, automação, múltiplos usuários). Visual: comparacao em tabela/flip cards.
12. Prática AutoCAD x QGIS: prints dos dois ambientes com camadas e tabela de atributos. Visual: imagem.
13. Objetivos do curso: capacitar servidores, implantar QGIS como ferramenta de gestão territorial, estruturar dados para consultas e relatórios. Visual: 3 cards.
14. Estratégias: capacitação, manutenção de dados existentes (DRZ), substituir controles manuais por registros geográficos, grupo de técnicos para governança, implementação gradual (incorporação, consolidação, expansão). Visual: staircase 3 fases.
15. PostGIS como núcleo: planejamento urbano, monitoramento ambiental, coleta em campo, gestão operacional, dados em tempo real, decisões baseadas em dados. Visual: hub central com 6 satélites.
16. Vetor x raster: vetor = objetos discretos, zoom sem perda, limites e infraestrutura; raster = células com valores, fenômenos contínuos, cobertura do solo, elevação, clima; vetorização/rasterização. Visual: comparacao animada (grid pixelando x polígono nítido).
17. Geometria + tabela de atributos: cada ponto, linha, polígono tem ID único ligado a uma linha da tabela; exemplos de escola, avenida, bairro. Visual: d3 ligando mapa e tabela.

## Dados e números
- 8 encontros, 4h cada, 32h totais (25/04 a 27/06)
- 578 mortes por cólera no mapa de John Snow (1854)
- Lote 550, Rua Primavera: 540 m², frente 15 m, laterais 36 m, zona ZR4
- Linha do tempo Toledo: ~2000, 2005-2006, 2018, 2019, 2022
- Tabela de atributos exemplo: Av. Central 5,2 km, Rio Azul 12,8 km, Bairro Centro 245 ha, Área Rural 1250 ha
- Ilustração PostGIS: "+35% eficiência", "124 pontos coletados hoje" (números ilustrativos)

## Trechos de código emblemáticos
Nenhum na fonte. Possível acrescentar um SELECT PostGIS simples no slide de tabela de atributos, se o planner julgar útil.

## Imagens disponíveis (references/imagens/)
brasao_toledo.png, slide04_img2 (mapa John Snow), slide05_img2 (SIG), slide07_img2 e slide08_img2 (fluxo QGIS + banco), slide10_img1/img2 (BCI e croqui), slide11_img1 (quadra no QGIS), slide14_img1 (AutoCAD x QGIS), slide17_img1 (PostGIS hub), slide18_img1 (vetor x raster), slide19_img1 (geometria + atributos).

## Narrativa sugerida
Capa e regras do curso → cronograma → o que é geoprocessamento (4 etapas) → prova histórica (John Snow) → SIG e glossário → como funciona o fluxo QGIS + banco → vantagens → exemplo real em Toledo (lote 550) → história do geo em Toledo → AutoCAD x QGIS (por que migrar) → objetivos e estratégias do curso → PostGIS como núcleo → fundamentos técnicos (vetor x raster, atributos) → encerramento.

## Lacunas
- Nomes dos docentes (nota do slide 1 diz "NOME DOS DOCENTES").
- Regras de presença e nota da Escola de Governo, só citadas nas notas.
- Slide 8 é só figura; conteúdo inferido do slide 7.
