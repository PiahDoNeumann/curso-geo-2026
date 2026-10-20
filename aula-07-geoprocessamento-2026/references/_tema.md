# Aula 07: Geoprocessamento II, operações espaciais

Curso de QGIS para servidores da Prefeitura de Toledo (2026). Continuação da aula 06, que cobriu as operações de conjunto (união, interseção, diferença, diferença simétrica e por que a ordem importa na diferença).

Foco definido pelo Piah: revisitar os itens do menu **Vetor > Ferramentas de Geoprocessamento** do QGIS (print em `menu-ferramentas-geoprocessamento.jpg`): Buffer, Recortar, Envoltória convexa, Diferença, Dissolver, Interseção, Diferença simétrica, União, Eliminar polígonos selecionados. Diferença, interseção, diferença simétrica e união já foram vistas como teoria de conjuntos na aula 06; aqui viram ferramenta do QGIS.

Incluídos também, fora desse menu: **Poligonizar** (Vetor > Ferramentas de Geometria) e **Junção espacial** (Caixa de ferramentas de processamento: "Unir atributos por localização" e "Unir atributos por localização (resumo)" para contar pontos por polígono).

Conteúdo desta aula, por decisão da turma (diverge do plano original, onde isso era a aula 8):

- **Buffer:** área de influência. Raio de cobertura, faixa não edificável, distância mínima.
- **Dissolver:** fundir feições por atributo comum.
- **Recorte (clip):** limitar uma camada ao contorno de outra.
- **Envoltório convexo (convex hull):** o menor polígono convexo que contém um conjunto de feições.
- **Poligonizar:** transformar linhas fechadas em polígonos.
- **Junção espacial:** trazer atributo pela posição; contar pontos por polígono.
- Regra de ouro: reprojetar para EPSG:31982 (SIRGAS 2000 / UTM 22S, metros) antes de qualquer buffer ou cálculo de área.

Seleções, atributos, calculadora de campo e junção por atributo ficam para a aula 8.

Prática sugerida: buffer de 500 m em `escola` e `posto_saude`; recortar `logradouro` pelo limite de um bairro; dissolver `bairro` por região administrativa; junção espacial contando `ocorrencia` por bairro.

Mini-desafio: identificar quais bairros não são alcançados por nenhum buffer de 500 m e mapear o resultado.

Fonte: `Docs/Curso2026-02/curso-plano-de-aula-foco-qgis.md`, seção Aula 8 (cópia em `plano-operacoes-espaciais.md`).
