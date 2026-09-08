# Prompt pronto para o `/mira-new`

Fonte: `apresentacao.md` (19 slides extraídos de `CURSO - GEOPROCESSAMENTO APLICADO À ADMINISTRAÇÃO PÚBLICA MUNICIPAL.pptx`), imagens em `images/`.

---

## 1. Prompt para colar

Copie o bloco abaixo inteiro e cole no chat depois de digitar `/mira-new`.

```
Novo deck sobre o curso "Geoprocessamento Aplicado à Administração Pública Municipal", da Escola de Governo do Município de Toledo-PR.

Slug: curso-geo-toledo-2026
Template: aula-capitulo
Tema base: mira-dark
Cor principal: usar a do tema (laranja padrão)

Descrição do tema:
Apresentação de abertura de um curso de 32 horas que capacita servidores municipais em geoprocessamento com QGIS. Vai do conceito de geoprocessamento e SIG até o caso real de Toledo, a migração do AutoCAD para o QGIS, o cadastro imobiliário georreferenciado e o banco PostGIS como base do GeoPortal. Público: servidores das secretarias municipais, sem exigência de conhecimento prévio em SIG. Objetivo: mostrar por que a prefeitura precisa de geoprocessamento e o que o servidor vai saber fazer ao final do curso.

Referências: copie para as referências do deck todo o conteúdo da pasta D:\CursoGeo\Docs\Curso2026v2, ou seja, o arquivo apresentacao.md e a pasta images/ com as 13 imagens de conteúdo.
```

---

## 2. Respostas às perguntas do `/mira-new`

Se o agente perguntar item a item, use estas respostas.

| Pergunta | Resposta |
|---|---|
| Nome do tema | Geoprocessamento Aplicado à Administração Pública Municipal |
| Slug | `curso-geo-toledo-2026` (livre, não colide com os 4 decks já existentes) |
| Template do deck | `aula-capitulo` |
| Tema base | `mira-dark` |
| Cor principal | a do tema, sem override |
| Descrição | ver bloco acima |
| Referências | `Docs/Curso2026v2/apresentacao.md` + `Docs/Curso2026v2/images/` |

---

## 3. Estrutura sugerida de slides

Mapeamento do PPT original para o deck do Mira. Serve de insumo para o `/mira-planner` depois do setup.

### Bloco 1: abertura e contrato do curso

| # | Slide sugerido | Origem |
|---|---|---|
| 1 | Capa: título do curso, Escola de Governo, Toledo-PR | slide 1 |
| 2 | Cronograma: 8 encontros, 4h cada, 32h no total, de 25/04 a 27/06 | slide 2, tabela completa |

### Bloco 2: fundamentos

| # | Slide sugerido | Origem |
|---|---|---|
| 3 | O que é geoprocessamento: as 4 etapas, coletar, tratar, analisar, representar | slide 3 |
| 4 | John Snow, Londres 1854: o primeiro mapa que salvou vidas, 578 óbitos, bomba de Broad Street | slide 4 + imagem `slide04_img01.png` |
| 5 | SIG, os 5 componentes: pessoas, metodologias, aplicativos, hardware, banco de dados | slide 5 + imagem `slide05_img02.png` |
| 6 | Glossário visual: dado espacial, dado georreferenciado, SIG, geoprocessamento, geoinformação | slide 6, cadeia de 5 termos |
| 7 | Vetor versus raster: objetos discretos versus fenômenos contínuos, vetorização e rasterização | imagem `slide18_img12.png` (slide 18) |
| 8 | Geometria mais atributo: ponto, linha e polígono ligados por ID único à tabela | imagem `slide19_img13.png` (slide 19) |

### Bloco 3: a ferramenta

| # | Slide sugerido | Origem |
|---|---|---|
| 9 | Arquitetura do QGIS: interface, entrada de dados, análise, visualização, tudo sobre o banco geográfico | slide 7 + imagem `slide07_img03.png` |
| 10 | Panorama de softwares SIG: proprietários, livres e a linha brasileira do INPE | imagem `slide08_img04.png` (slide 8) |
| 11 | Vantagens do QGIS na prefeitura: 8 itens, da centralização dos dados ao GeoPortal | slide 9 |
| 12 | QGIS versus AutoCAD: comparação em 10 critérios | slide 13, tabela completa |
| 13 | O mesmo território, duas ferramentas: layers gráficas no AutoCAD contra camadas temáticas com atributos no QGIS | imagem `slide14_img10.png` (slide 14) |

### Bloco 4: o caso de Toledo

| # | Slide sugerido | Origem |
|---|---|---|
| 14 | Linha do tempo: setor criado nos anos 2000, extinto em 2005/2006, retomada em 2018, GeoPortal em 2019, empresa especializada em 2022 | slide 12 |
| 15 | Do croqui ao cadastro: lote de 540 m² na Rua Primavera vira ficha com 47 características e 11 equipamentos urbanos | slide 10 + imagens `slide10_img05.png`, `slide10_img06.png` |
| 16 | Uma geometria, muitos registros: duas edificações geminadas no mesmo lote, 2001 e 2006, cada uma com sua ficha | slide 11 + imagens `slide11_img07.png`, `slide11_img08.png`, `slide11_img09.png` |
| 17 | PostGIS no centro: planejamento urbano, monitoramento ambiental, coleta em campo e gestão operacional alimentando um banco só | imagem `slide17_img11.png` (slide 17) |

### Bloco 5: fechamento

| # | Slide sugerido | Origem |
|---|---|---|
| 18 | Objetivos do curso: 3 metas, autonomia técnica, QGIS como ferramenta de gestão, dados estruturados para consulta | slide 15 |
| 19 | Estratégias de implantação: capacitação, manutenção dos dados DRZ, fim dos controles manuais, grupo de governança, implantação gradual | slide 16 |

Total: 19 painéis, mesma contagem do original, com os slides 17, 18 e 19 (que eram só imagem) realocados para onde o assunto pede.

---

## 4. Ganchos para o `/mira-animator`

Conteúdos do PPT que pedem animação com loop interno, na ordem de maior retorno visual:

1. **John Snow (slide 4)**: pontos de óbito surgindo um a um sobre o mapa, a bomba de Broad Street pulsando no centro da mancha, depois a bomba se apaga e a mancha esvazia. Loop.
2. **Cadeia de conceitos (slide 6)**: dado espacial que vira georreferenciado, entra no SIG, passa pelo geoprocessamento e sai como geoinformação. Fluxo em loop contínuo.
3. **Vetor versus raster (slide 18)**: zoom no vetor mantendo a borda lisa contra zoom no raster revelando a escadinha de pixels. Alternância em loop.
4. **Geometria mais atributo (slide 19)**: linha da tabela acende, a geometria correspondente acende junto no mapa, percorrendo os registros em loop.
5. **Linha do tempo de Toledo (slide 12)**: 2000, 2005, 2018, 2019, 2022 avançando num trilho, com o hiato de 12 anos marcado visualmente.
6. **AutoCAD versus QGIS (slide 14)**: camada gráfica sem atributo contra camada que abre a tabela ao ser clicada. Alternância em loop.
7. **PostGIS central (slide 17)**: quatro frentes bombeando dados para o cilindro central e devolvendo consultas. Pulso em loop.

---

## 5. Observações da extração

- O logo da Escola de Governo (`images/_logo.png`) e o rodapé "ESCOLA DE GOVERNO / MUNICÍPIO DE TOLEDO-PR" repetiam nos 19 slides. Foram tratados como identidade do template, não como conteúdo.
- Só o slide 1 tem notas do apresentador, registradas no `apresentacao.md`.
- Os slides 8, 14, 17, 18 e 19 eram apenas imagem, sem nenhum texto. O conteúdo deles foi lido das imagens e transcrito no `apresentacao.md` sob "Conteúdo da imagem".
- 3 mídias do arquivo original ficaram de fora por serem fundo do slide master e dos layouts, não conteúdo.
