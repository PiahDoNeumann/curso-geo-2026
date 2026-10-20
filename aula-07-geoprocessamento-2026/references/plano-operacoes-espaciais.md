## Aula 8 — Geoprocessamento II: operações espaciais

**Objetivo:** as ferramentas que respondem perguntas de território.

**Teoria (25 min)**

- **Buffer:** área de influência. Raio de cobertura, faixa não edificável, distância mínima.
- **Recorte (*clip*):** limitar uma camada ao contorno de outra.
- **Dissolver:** fundir feições por atributo comum.
- **União, interseção e diferença:** o que sobrepõe, o que é comum, o que resta.
- **Junção espacial:** trazer atributo de uma camada para outra pela posição; contar pontos por polígono.
- Regra de ouro: reprojetar para EPSG:31982 antes de qualquer buffer ou cálculo de área. Retomada da aula 2.

**Prática (1h50)**

- Buffer de 500 m em `escola` e `posto_saude`, sobre camada reprojetada.
- Recortar `logradouro` pelo limite de um bairro.
- Dissolver `bairro` por região administrativa.
- Interseção entre a cobertura das escolas e os micropolos: onde há sobreposição de atendimento.
- Diferença: o que fica fora de toda cobertura.
- Junção espacial contando `ocorrencia` por bairro, com mapa graduado do resultado.
- Caixa de ferramentas de processamento: como encontrar um algoritmo pelo nome.

**Mini-desafio:** identificar quais bairros não são alcançados por nenhum buffer de 500 m e mapear o resultado.

