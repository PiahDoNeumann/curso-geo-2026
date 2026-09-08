# Briefing: Geoprocessamento Aplicado à Administração Pública Municipal

**Fonte:** referências locais do deck (texto) — `decks/curso-geo-toledo-2026/references/`
**Origem primária:** `CURSO - GEOPROCESSAMENTO APLICADO À ADMINISTRAÇÃO PÚBLICA MUNICIPAL.pptx`, 19 slides, extraído em `Docs/Curso2026v2/`
**Data da extração:** 08/09/2026

## Essência em uma frase

Aula de abertura de um curso de 30 horas da Escola de Governo de Toledo-PR que convence servidores municipais, sem conhecimento prévio em SIG, de que geoprocessamento não é desenho técnico e sim gestão de dados territoriais, usando a própria prefeitura como estudo de caso.

## Conceitos-chave (candidatos a slide)

1. **Cronograma do curso** — contrato de expectativa com a turma: 10 aulas de 3 horas, sempre às terças, de 08/09 a 10/11/2026, do QGIS básico ao PostGIS e serviços OGC — visual: timeline
2. **As 4 etapas do geoprocessamento** — coletar, tratar, analisar e representar: define o campo antes de qualquer ferramenta — visual: d3-fluxo
3. **John Snow, Londres 1854** — o mapa que derrubou a teoria do miasma: 578 óbitos plotados, a bomba de Broad Street no epicentro, interdição e queda dos casos. É a prova histórica de que o mapa gera conhecimento, não só ilustra — visual: d3-fluxo com revelação progressiva
4. **Os 5 componentes do SIG** — pessoas, metodologias, aplicativos, hardware e banco de dados: SIG é ambiente, não programa — visual: comparacao radial
5. **Cadeia conceitual** — dado espacial vira dado georreferenciado, entra no SIG, passa pelo geoprocessamento e sai como geoinformação para decisão. Resolve a confusão entre os cinco termos — visual: d3-fluxo linear
6. **Vetor contra raster** — objetos discretos com zoom infinito contra fenômenos contínuos com efeito escadinha, mais vetorização e rasterização como pontes — visual: comparacao
7. **Geometria mais atributo** — o conceito central do SIG: cada ponto, linha ou polígono tem ID único que o liga a uma linha de tabela. É o que o AutoCAD não faz — visual: d3-fluxo com destaque sincronizado
8. **Arquitetura do QGIS** — interface que ramifica em entrada de dados, análise espacial e visualização, todas apoiadas no banco geográfico — visual: d3-fluxo
9. **Panorama de softwares SIG** — proprietários (ArcGIS, ENVI, ERDAS), livre (QGIS) e a linha brasileira do INPE (SPRING, TerraLib, TerraView, TerraMA², TerraHidro, GeoDMA, TerraBrasilis) — visual: comparacao em grade
10. **Vantagens do QGIS na prefeitura** — 8 itens, da centralização dos dados ao GeoPortal e ao compartilhamento entre secretarias — visual: metricas ou grade de pílulas
11. **QGIS contra AutoCAD** — comparação em 10 critérios, do foco principal à automação e ao acesso multiusuário — visual: comparacao em tabela
12. **O mesmo território, duas ferramentas** — no AutoCAD, layers nomeadas por desenho sem atributo; no QGIS, camadas temáticas com tabela consultável. Comprovação prática do slide anterior — visual: comparacao lado a lado
13. **Linha do tempo de Toledo** — setor criado nos anos 2000, extinto em 2005/2006, retomada em 2018 com a migração do AutoCAD, GeoPortal em 2019, empresa especializada em 2022. O hiato de 12 anos é o ponto dramático — visual: timeline
14. **Do croqui ao cadastro** — o lote de 540 m² na Rua Primavera vira ficha com 47 características e 11 equipamentos urbanos: mostra o dado saindo do desenho e virando registro — visual: d3-fluxo croqui para formulário
15. **Uma geometria, muitos registros** — duas edificações geminadas no mesmo lote, de 2001 e 2006, cada uma com sua ficha de 19 atributos. Mata a ideia de que um lote é uma linha — visual: comparacao
16. **PostGIS no centro** — planejamento urbano, monitoramento ambiental, coleta em campo e gestão operacional alimentando e consultando um banco só, com +35% de eficiência — visual: d3-fluxo radial
17. **Objetivos do curso** — autonomia técnica, QGIS como ferramenta de gestão territorial, dados estruturados para consulta e relatório — visual: metricas
18. **Estratégias de implantação** — capacitação, manutenção dos dados DRZ, fim dos controles manuais, grupo de governança, implantação gradual em fases — visual: timeline ou d3-fluxo

## Dados e números

**Curso (cronograma vigente, confirmado pelo usuário em 08/09/2026)**
- 30 horas totais, 10 aulas de 3 horas
- Sempre às terças-feiras, de 08/09/2026 a 10/11/2026
- Datas: 08/09, 15/09, 22/09, 29/09, 06/10, 13/10, 20/10, 27/10, 03/11, 10/11
- A aula 1 é hoje, 08/09/2026

**Ementa redistribuída (SUGESTÃO do agente, precisa de validação)**
O PPT de origem trazia 8 tópicos para 8 encontros de 4 horas. Com 10 encontros de 3 horas, os tópicos foram desmembrados assim:
1. 08/09: apresentação do curso e introdução ao geoprocessamento, conceitos, demonstração prática e estudos de caso
2. 15/09: QGIS, apresentação, interface e criação de projetos
3. 22/09: arquivos de entrada e saída, ferramentas básicas
4. 29/09: introdução a shapefiles, pontos, linhas e polígonos
5. 06/10: simbologia e rotulação
6. 13/10: compositor de impressão e elaboração de mapas
7. 20/10: mapas categorizados, graduados e temáticos
8. 27/10: análise espacial, buffer, dissolve, separação e união de feições, recorte e intersecção
9. 03/11: banco de dados geográficos, PostgreSQL, PostGIS, PgAdmin e integração QGIS com PostGIS
10. 10/11: geoprocessamento e internet, serviços OGC (WMS e WFS), mapas base e encerramento

**Cronograma do PPT original (SUPERADO, não usar nos slides)**
- 32 horas, 8 encontros de 4 horas, de 25/04 a 27/06

**John Snow, 1854**
- 578 mortes por cólera mapeadas
- Bomba contaminada de Broad Street identificada pela concentração dos óbitos

**Cadastro imobiliário de Toledo (exemplo real do lote 550, Rua Primavera)**
- Área total do terreno: 540,00 m²
- Frente e fundos: 15,00 m; laterais: 36,00 m
- 47 características cadastradas no terreno
- 11 equipamentos urbanos marcados: água, esgoto, galerias, iluminação, lixo, meio-fio, passeio, pavimentação, sarjeta, telefone, urbanismo
- Zoneamento: código 35, sigla ZR4
- Edificação 1: 114,55 m², alvará 243, construída em 2001, habite-se em 11/05/2001, isolada, conservação ótima, 1 banheiro
- Edificação 2: 111,73 m², alvará 558, construída em 2006, habite-se em 22/03/2010, geminada, conservação boa, sem banheiro e sem cozinha registrados
- 19 atributos construtivos por edificação

**Linha do tempo institucional**
- Início dos anos 2000: criação do setor de geoprocessamento
- 2005 a 2006: extinção do setor
- 2018: migração dos dados imobiliários do AutoCAD para o QGIS
- 2019: publicação do GeoPortal
- 2022: contratação de empresa especializada em geotecnologias
- Hiato de aproximadamente 12 anos entre a extinção e a retomada

**Ganhos declarados (infográfico PostGIS)**
- +35% de eficiência, economia de tempo
- 124 novos pontos coletados em campo por dia
- 12,3% de áreas verdes, 3 obras em andamento (indicadores de exemplo)

**Comparação QGIS contra AutoCAD (10 critérios)**
Foco principal, estrutura dos dados, banco de dados, consultas e filtros, análise espacial, georreferenciamento, integração com outros dados, uso típico, automação e análise, múltiplos usuários. Em todos, o QGIS ganha em gestão de dados; o AutoCAD permanece melhor apenas em precisão de desenho técnico.

## Trechos de código emblemáticos

Não há código na fonte. É uma aula conceitual e institucional, sem SQL ou script. Se o `/mira-planner` quiser um slide técnico, o material disponível é a lista de camadas do projeto QGIS de Toledo (nomes como `IMOVEIS_URBANOS_RURAIS_OFICIAL`, `EDIFICACOES_ATUAIS_OFICIAL`, `VALORES_M2_TERRENO_2025`, `PERIMETRO_URBANO_DE_TOLEDO_OFICIAL`) e as colunas da tabela de atributos (cadastro, zona, setor, quadra, lote).

## Narrativa sugerida

**Arco em cinco tempos:**

1. **Contrato** (2 painéis): quem somos, o que você vai receber em 30 horas e em que datas.
2. **Problema e fundamento** (6 painéis): geoprocessamento não é desenho. John Snow prova que o mapa produz conhecimento. Definir SIG, a cadeia de conceitos, vetor contra raster e a ligação geometria mais atributo. Aqui o servidor entende o campo.
3. **Solução** (5 painéis): o QGIS como ambiente, seu lugar no panorama de softwares, as vantagens concretas na prefeitura e o veredito contra o AutoCAD, encerrado pela comprovação visual sobre a mesma área de Toledo.
4. **Prova em casa** (4 painéis): a história do setor em Toledo com seu hiato de 12 anos, o lote real virando ficha cadastral, as duas edificações num mesmo lote e o PostGIS centralizando as quatro frentes de trabalho. O servidor se reconhece no exemplo.
5. **Chamada** (2 painéis): os três objetivos do curso e as cinco estratégias de implantação, que é onde o servidor descobre o próprio papel.

**Tensão central a explorar:** a prefeitura já tinha geoprocessamento nos anos 2000 e perdeu. A pergunta implícita do deck é o que muda desta vez, e a resposta é o banco de dados mais a governança compartilhada, não a ferramenta em si.

**Momento de virada:** o slide 12 do original (QGIS contra AutoCAD) seguido da comprovação visual. É onde o servidor que usa AutoCAD entende que não está sendo pedido para trocar de programa, e sim para trocar de modelo de dado.

## Lacunas

- ~~**Nomes dos docentes**~~ RESOLVIDO em 08/09/2026: **Romano e Valdecir**. Consta na capa.
- **Regras de presença e nota:** as notas mencionam que a Escola de Governo tem regras de presença e nota, sem detalhar. Se for para constar no painel de contrato, o usuário precisa fornecer.
- **Local e estrutura:** as notas citam "estrutura UTFPR" e intervalo, sem endereço nem horário. Falta para um painel de logística.
- ~~**Ano do curso**~~ RESOLVIDO em 08/09/2026: curso de 2026, 10 aulas de 3 horas às terças, de 08/09 a 10/11. O cronograma do PPT estava desatualizado.
- **Origem dos indicadores do infográfico PostGIS:** +35% de eficiência e 124 pontos por dia aparecem como exemplo ilustrativo. Confirmar se são números reais de Toledo ou genéricos, para não apresentar dado ilustrativo como resultado medido.
- **DRZ:** citada nas estratégias como detentora de dados geográficos já existentes, sem explicação da sigla. Se o público não conhecer, precisa de uma linha de contexto.
- **Ementa das 10 aulas:** a redistribuição dos 8 tópicos originais em 10 encontros é sugestão do agente, não veio da fonte. Romano e Valdecir precisam validar antes de a turma ver.
- **Sem CTA final:** o material termina nas estratégias, sem um painel de encerramento com próximo passo concreto para o servidor. O `/mira-copywriter` pode precisar criar um.
