# Aula 03: QGIS + PostGIS, erros silenciosos

Terceira aula do curso de geoprocessamento de Toledo-PR (segundo grupo, servidores municipais).
Apresentação de ~20 minutos, SÓ slides (sem demo ao vivo), 12 slides.
Fonte principal: apostila_qgis_postgis_erros_silenciosos.pdf. Kit do exercício em kit/ (bairros_sujo.shp, demo.sql com gabarito).

Estrutura aprovada pela Piah:
1. Capa: QGIS + PostGIS, erros silenciosos
2. O erro que não grita: zero linhas, mapa 60 m deslocado; regra snake_case e caminho curto
3. Limites do shapefile: campo 10 caracteres, texto 254, sem NULL, sem booleano
4. .cpg e .prj ausentes: codificação adivinhada e CRS assumido (SAD69 x SIRGAS = 60 m)
5. Nomes no PostGIS: aspas, maiúsculas, palavras reservadas, 63 bytes
6. Dados de texto: acento, caixa, espaço invisível (NBSP), vazio x NULL
7. Número como texto, vírgula decimal, collation
8. Geometria inválida: gravata-borboleta, área 0, vizinhos imprevisíveis
9. QGIS: chave primária, ANALYZE, view com tipo declarado
10. Windows: acento no caminho, OneDrive, MAX_PATH 260
11. Exercício: shapefile sujo e as 3 perguntas (São José 1 vs 2; maior área Coopagro 95 vs Vila Industrial 180; vizinhos do Centro só garantidos após ST_MakeValid)
12. Checklist e fecho: "o que esse resultado silencioso esconde?"
