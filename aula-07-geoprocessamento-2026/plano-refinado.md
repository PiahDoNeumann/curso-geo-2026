# Plano Refinado: Aula 07, ferramentas de geoprocessamento do QGIS

Template `escola-governo`. 16 slides. Sem imagens a gerar. Texto visível sem travessão.

## Mudanças principais
- Capa vira pergunta-gancho: o QGIS não faz pergunta, quem faz é o servidor.
- Bloco de conjuntos ganha o mote "vocês já sabem, falta achar o botão".
- Regra de ouro com número que choca: 500 graus dá a volta na Terra.
- Cada ferramenta abre com a pergunta de território que ela responde.
- Fechamento retoma a frase da capa.

| # | Título original | Título refinado | Tipo |
|---|---|---|---|
| 1 | Capa | Qual é a sua pergunta? | capa |
| 2 | Vocês já conhecem 4 delas | 4 de 9 vocês já sabem usar | d3 |
| 3 | E e OU viram botão | E e OU agora têm botão | d3 |
| 4 | MAS NÃO e UM OU OUTRO | MAS NÃO: a ordem decide | d3 |
| 5 | Buffer | Buffer: até onde chega? | d3 |
| 6 | 500 graus não é 500 metros | 500 graus dá a volta na Terra | d3 |
| 7 | Reprojete antes de medir | Reprojete antes de medir | cta |
| 8 | Recortar não é interseção | Recortar: a tesoura com molde | d3 |
| 9 | Envoltória convexa | Envoltória: o elástico nos pregos | d3 |
| 10 | Poligonizar | Poligonizar: linha fechada vira área | d3 |
| 11 | Dissolver | Dissolver: some a fronteira de dentro | d3 |
| 12 | Eliminar | Eliminar: a lasca vai para o vizinho | d3 |
| 13 | Junção espacial | Junção espacial: quantos caem em cada? | d3 |
| 14 | Do português para a ferramenta | Da pergunta para o botão | tabela |
| 15 | Mini-desafio | Quem fica sem escola? | timeline |
| 16 | Encerramento | Obrigado | citação |

---

## Slide 1: Capa
- **Pílula:** Escola de Governo · Toledo-PR
- **Título:** Qual é a sua **pergunta**?
- **Subtítulo:** Aula 7 de 10. Onze ferramentas do QGIS, cada uma responde a uma pergunta sobre o território.
- **Números:** `7ª` de 10 aulas · `11` ferramentas · `4` já vistas na aula 6 · `500 m` de buffer na prática
- **Rodapé:** Romano e Valdecir · 20/10/2026
- **Nota:** pergunta direta engaja; a resposta vem ao longo da aula.

## Slide 2: 4 de 9 vocês já sabem usar
- **Ícone:** `list-checks`
- **Subtítulo:** Vetor > Ferramentas de Geoprocessamento, item por item
- **Animação:** menu do QGIS desenhado como lista de 9 itens (Buffer, Recortar, Envoltória convexa, Diferença, Dissolver, Interseção, Diferença simétrica, União, Eliminar polígonos selecionados). Os 4 de conjunto ganham etiqueta ∩ ∪ − △. Loop: destaque percorre os 4, depois os 5 novos piscam como "hoje".
- **Pílulas:** Interseção ∩ · União ∪ · Diferença − · Diferença simétrica △

## Slide 3: E e OU agora têm botão
- **Ícone:** `combine`
- **Subtítulo:** Cobertura das escolas cruzada com os micropolos
- **Animação:** duas camadas (círculos de cobertura e polígono de micropolo). Alterna Interseção (só o comum, com etiqueta "atributos das duas") e União (tudo, recortado onde sobrepõe). Loop alternando.
- **Pílulas:** Interseção: onde há atendimento duplo · União: tudo, em pedaços · A ordem não importa

## Slide 4: MAS NÃO: a ordem decide
- **Ícone:** `git-compare`
- **Subtítulo:** Diferença tira, diferença simétrica mostra o que mudou
- **Animação:** à esquerda, bairro menos cobertura = área sem atendimento (entrada × sobreposição). À direita, limite antigo × limite novo, sobra só o que mudou. Loop.
- **Pílulas:** Diferença: entrada menos sobreposição · Simétrica: o que mudou entre versões

## Slide 5: Buffer: até onde chega?
- **Ícone:** `circle-dot`
- **Subtítulo:** Ponto vira círculo, linha vira faixa, polígono engorda
- **Animação:** três colunas: ponto, linha, polígono, cada um ganhando sua zona de 500 m. Depois dois círculos se tocam e "Dissolver resultado" funde. Loop: as zonas pulsam.
- **Pílulas:** Raio de cobertura · Faixa não edificável · Distância mínima

## Slide 6: 500 graus dá a volta na Terra
- **Ícone:** `triangle-alert`
- **Subtítulo:** Medir em graus não dá erro: dá número errado
- **Animação:** lado a lado. EPSG:4674: o buffer de "500" cresce, engole Toledo, o Paraná, sai do quadro. EPSG:31982: círculo de 500 m certinho em volta da escola. Loop.
- **Pílulas:** EPSG:4674 guarda (graus) · EPSG:31982 mede (metros)

## Slide 7: Reprojete antes de medir (CTA)
- **Ícone:** `move-right`
- **Subtítulo:** Um passo antes de qualquer buffer ou cálculo de área
- **Conteúdo:** passo único em destaque: botão direito na camada > Exportar > Salvar feições como > SRC **EPSG:31982**. Animação: o selo do SRC trocando de 4674 para 31982 em loop.
- **Nota:** card leve entre dois blocos densos.

## Slide 8: Recortar: a tesoura com molde
- **Ícone:** `scissors`
- **Subtítulo:** Só fica o que está dentro, com os atributos de quem entrou
- **Animação:** malha de `logradouro`; o contorno de um bairro desce como molde e as ruas de fora somem. Comparação final: recortar leva atributos de 1 camada, interseção de 2. Loop.
- **Pílulas:** Recortar: atributos só da entrada · Interseção: atributos das duas

## Slide 9: Envoltória: o elástico nos pregos
- **Ícone:** `pentagon`
- **Subtítulo:** O menor polígono convexo que abraça todos os pontos
- **Animação:** pontos de ocorrência como pregos; elástico se fecha em volta (convex hull real calculado por d3.polygonHull). Depois a área vazia dentro do elástico pisca. Loop: novos pontos, novo elástico.
- **Pílulas:** Área de abrangência aproximada · Em forma côncava, exagera

## Slide 10: Poligonizar: linha fechada vira área
- **Ícone:** `square-dashed`
- **Subtítulo:** Vetor > Ferramentas de Geometria > Poligonizar
- **Animação:** linhas de eixo são desenhadas; cada anel fechado ganha preenchimento (quadra). Uma linha que não encosta fica sem preencher, com aviso "não fechou". Loop.
- **Pílulas:** Quadras a partir de eixos · DWG/DXF do acervo · Sem snapping, não fecha

## Slide 11: Dissolver: some a fronteira de dentro
- **Ícone:** `layers`
- **Subtítulo:** Bairros agrupados pela região administrativa
- **Animação:** grade de bairros coloridos por região; as divisas internas apagam e sobram as regiões. Depois, sem campo: tudo vira um polígono só. Loop.
- **Pílulas:** Com campo: um polígono por valor · Sem campo: um polígono só · Outros atributos se perdem

## Slide 12: Eliminar: a lasca vai para o vizinho
- **Ícone:** `eraser`
- **Subtítulo:** Limpa o resto fino que sobra de interseção e união
- **Animação:** dois polígonos com lasca fina entre eles; a lasca é selecionada (destaque) e é absorvida pelo vizinho de maior fronteira comum. Loop.
- **Pílulas:** Precisa de seleção antes · Maior área · Maior fronteira comum

## Slide 13: Junção espacial: quantos caem em cada?
- **Ícone:** `map-pin`
- **Subtítulo:** Une pela posição, não pelo código
- **Animação:** pontos de ocorrência caem sobre bairros; contador de cada bairro sobe e a cor gradua pelo total. Loop: nova chuva de pontos.
- **Pílulas:** Unir atributos por localização (resumo) · Intersecta, contém, está dentro

## Slide 14: Da pergunta para o botão
- **Ícone:** `languages`
- **Subtítulo:** Seis perguntas que a prefeitura faz toda semana
- **Animação:** tabela de duas colunas; cada linha acende em sequência, pergunta à esquerda, ferramenta à direita, em loop:
  - Até onde a escola atende? → Buffer
  - Só o que está dentro do bairro? → Recortar
  - Como fica por região? → Dissolver
  - Que área esses pontos ocupam? → Envoltória convexa
  - Quantas ocorrências por bairro? → Junção espacial
  - O que ficou sem cobertura? → Diferença

## Slide 15: Quem fica sem escola?
- **Ícone:** `flag`
- **Subtítulo:** Mini-desafio: quatro passos, uma resposta no mapa
- **Animação:** cadeia em 4 etapas que acendem em sequência: Reprojetar para 31982 → Buffer de 500 m, dissolvido → Diferença com os bairros → Mapa dos bairros descobertos. Loop.

## Slide 16: Encerramento
- **Título:** Obrigado
- **Citação:** "Toda ferramenta responde a uma **pergunta**. Comece por ela."
- **Pílulas (acendem em sequência):** Buffer · Recortar · Dissolver · Junção espacial
- **Logo**

> **2026-10-21:** slide 7 (Reprojete antes de medir) retirado da aula 07; guardado em `reservado-aula-09.md` para a aula 9. Deck com 15 slides.
> **2026-10-21:** slide 6 (500 graus dá a volta na Terra) também retirado e guardado em `reservado-aula-09.md`. Deck com 14 slides.
> **2026-10-21:** slide 12 (Eliminar) retirado e guardado em `reservado-aula-09.md`. No slide 2 o item Eliminar fica apagado, sem selo HOJE; capa passa a 10 ferramentas. Deck com 13 slides.
