# Plano refinado: Aula 04, Simbologia graduada e rotulação

Deck: 16 slides, ~25 min de teoria antes da prática no QGIS. Tema mira-dark. Template aula-capitulo.
Vídeo header: 7.mp4 (globo com malha wireframe: território, mapa).
Imagens: nenhuma; todo visual é animação D3/CSS com loop interno (Regra Zero).
Regras: pt-BR com acentuação correta, sem travessão, títulos com no máximo 6 palavras.
Fora do deck (decisão da Piah): densidade, estatística e métodos de classificação (aula 6).

## Slide 1: Capa
- Template: header (vídeo 7)
- Kicker: Aula 04 · Geoprocessamento na Gestão Municipal
- Título: O mapa que diz quanto e quem
- Subtítulo: Simbologia graduada e rotulação no QGIS, com os dados de Toledo
- Nota: a cor do mapa já existe desde a aula 2; hoje o mapa aprende a responder "quanto" (graduado) e "quem" (rótulo).

## Slide 2: SRC → Antes de tudo: 31982
- Template: card_destaques
- Subtítulo: Padrão do curso: SIRGAS 2000 / UTM zona 22S, em metros
- Coluna A "Projeto": canto inferior direito do QGIS mostra o SRC do projeto. Clique e escolha EPSG:31982.
- Coluna B "Camada": Propriedades > Fonte mostra o SRC da camada. Todas as camadas da prática já estão em 31982.
- Rodapé: SRC terá aula própria. Por enquanto a regra é uma só: tudo em 31982.
- Ícone: globe-2
- Animação: duas camadas desalinhadas (grade de quadras e pontos) deslizam e se encaixam quando o selo "EPSG:31982" acende; loop: selo pulsa, camadas respiram levemente alinhadas.

## Slide 3: Renderizadores → O quê ou quanto?
- Template: card_grid (4 itens)
- Subtítulo: A pergunta que escolhe a simbologia certa
- Itens:
  - Símbolo único: tudo igual. Visto na aula 2.
  - Categorizado: o campo diz O QUÊ. Tipo de acidente.
  - Graduado: o campo diz QUANTO. População, vítimas.
  - Baseado em regras: só o que atende a uma condição.
- Ícone: palette
- Animação: quatro mini-mapas de 9 pontos; cada um recolore no seu estilo (igual, cores distintas, rampa de cor/tamanho, só 2 acesos) em sequência, loop.

## Slide 4: Categorizado → Uma cor para cada tipo
- Template: card_d3
- Subtítulo: Revisão rápida com os 402 acidentes de 2025
- Conteúdo: TIPO_ACID_ vira legenda: COLISÃO, ATROPELAMENTO, CAPOTAMENTO. "Saída de pista" escrito diferente vira categoria própria (lembra a aula 3). Vazio cai em "todos os outros valores".
- Pílulas: Qualidade · Cores distintas · Confira a legenda
- Ícone: tags
- Animação D3: nuvem de pontos cinza recebe cor por tipo; a legenda monta item a item; um ponto "Saída de pista" pisca com alerta de grafia diferente (loop).

## Slide 5: Graduado por cor → Mais escuro, mais gente
- Template: card_progresso
- Subtítulo: Bairros de Toledo pela população do Censo 2022
- Barras (populacao, cor da rampa sequencial):
  - Vila Pioneiro 18.782
  - Jardim Coopagro 14.074
  - Jardim Europa/América 13.260
  - Centro 13.058
  - Jardim Independência 432
- Rodapé: 22 bairros, 131.938 habitantes. Sadia vem sem dado (sigilo do IBGE). Use o método padrão do QGIS; comparar métodos fica para a aula 6.
- Ícone: users
- Animação: barras crescem e a cor escurece conforme o valor; loop: brilho percorre as barras.

## Slide 6: Graduado por tamanho → Círculo maior, mais vítimas
- Template: card_d3
- Subtítulo: 724 vítimas em 402 acidentes, de 0 a 8 por ocorrência
- Conteúdo: em Graduado, troque "Cor" por "Tamanho": o QGIS aumenta o símbolo conforme VITIMAS. Quantidade de coisa se lê melhor em tamanho do que em cor.
- Pílulas: Quantidade · Tamanho · Legenda em círculos
- Ícone: circle-dot
- Animação D3: pontos iguais inflam para círculos proporcionais (0 a 8); legenda de círculos aninhados; loop: um círculo grande pulsa.

## Slide 7: Regras → Acenda só o que importa
- Template: card_code
- Subtítulo: 47 de 402 acidentes: graves e com 2 ou mais vítimas
- Código:
```
-- Regra 1: destaque
"GRAVIDADE" = 'Grave' AND "VITIMAS" >= 2

-- Regra 2: todo o resto, discreto
ELSE
```
- Pílulas: Texto entre aspas simples · Campo entre aspas duplas · ELSE pega o resto
- Ícone: filter
- Nota: aspas retomam a aula 3 (aspas simples = texto; duplas = campo).

## Slide 8: Exercício → Sua vez: simbolize os acidentes
- Template: card_cta
- Subtítulo: 10 minutos no QGIS, depois salve o estilo
- Tarefas:
  1. Categorizado por TIPO_ACID_
  2. Graduado por tamanho em VITIMAS
  3. Regra: graves com 2 ou mais vítimas
- Instrução: Estilo > Salvar estilo gera um .qml. Carregue em outro projeto e o estilo volta igual.
- Botão: Abrir o QGIS
- Ícone: mouse-pointer-click

## Slide 9: Rótulo → Onde mora o rótulo
- Template: card_lista
- Subtítulo: Propriedades da camada > Rótulos
- Lista:
  1. Rótulos simples: um texto para todas as feições
  2. Baseado em regras: texto e estilo diferentes por condição
  3. Valor: um campo ("nome") ou uma expressão (ε)
  4. Abas que importam hoje: Texto, Buffer, Posicionamento, Renderização
- Ícone: tag

## Slide 10: Posição → Cada geometria, uma posição
- Template: card_d3
- Subtítulo: Ponto, linha e polígono pedem colocação diferente
- Conteúdo: Ponto: ao redor ou deslocado do símbolo. Linha: paralelo ou curvo, seguindo o traçado (OT-322). Polígono: horizontal, no centro do bairro.
- Ícone: move
- Animação D3: três painéis; o rótulo "Escola" orbita o ponto e para; "OT-322" desliza ao longo de uma estrada curva; "Centro" desce e se centraliza no polígono (loop).

## Slide 11: Halo e prioridade → Legível e sem briga
- Template: card_destaques
- Subtítulo: Contraste para ler; prioridade para decidir quem aparece
- Coluna A "Halo (Buffer)": texto sobre a ortofoto some. Um contorno claro de 1 mm devolve a leitura.
- Coluna B "Prioridade": rótulos que colidem são escondidos. Em Renderização, a prioridade decide quem fica.
- Rodapé: Evite "mostrar todos os rótulos": o mapa fica ilegível.
- Ícone: layers
- Animação: à esquerda, texto aparece/desaparece sobre textura manchada até o halo acender; à direita, dois rótulos se empurram e o de menor prioridade apaga (loop).

## Slide 12: Escala → Cada escala, seus rótulos
- Template: card_timeline
- Subtítulo: Visibilidade por escala: o maior remédio contra mapa poluído
- Etapas (zoom de longe para perto):
  1. 1:100.000: mostrar só o nome dos bairros
  2. 1:50.000: acrescentar as estradas rurais
  3. 1:10.000: acrescentar os acidentes
  4. 1:2.000: acrescentar as quadras
- Rodapé: Em Renderização, marque "Visibilidade dependente da escala".
- Ícone: zoom-in

## Slide 13: Expressões → Rótulo que junta campos
- Template: card_code
- Subtítulo: O construtor de expressões monta o texto para você
- Código:
```
-- Estradas: nome e tipo
"nome" || ' (' || "tipo" || ')'
-- OT-322 (RODOVIA MUNICIPAL)

-- Bairros: nome e população com milhar
"nome" || '\n' || format_number("populacao", 0)
-- Vila Pioneiro
-- 18.782
```
- Pílulas: || junta textos · \n quebra linha · format_number põe o ponto
- Ícone: braces

## Slide 14: Mini-desafio → Seu mapa de bairros
- Template: card_cta
- Subtítulo: Graduado e rotulado, legível de longe e de perto
- Tarefas:
  1. bairros_ibge_2022 graduado por população
  2. Rótulo: nome e população com separador de milhar
  3. Halo nos rótulos e visibilidade por escala
  4. Acidentes graves destacados por regra
- Botão: Começar o desafio
- Ícone: map

## Slide 15: Resumo → Qual ferramenta para cada pergunta
- Template: card_tabela
- Subtítulo: Guarde esta tabela para a prática
- Tabela (Pergunta | Ferramenta | Exemplo de hoje):
  - O que é? | Categorizado | Tipo de acidente
  - Quanto tem? | Graduado (cor ou tamanho) | População, vítimas
  - Só alguns? | Baseado em regras | Graves com 2 ou mais vítimas
  - Quem é? | Rótulo | Nome do bairro
  - Muito texto? | Halo, prioridade, escala | Rótulo por zoom
- Ícone: table

## Slide 16: Fecho → Um mapa que não grita
- Template: card_citacao
- Frase: "Um bom mapa não mostra tudo. Mostra o que importa, na escala certa."
- Rodapé: A camada simbolizada e rotulada de hoje é a base do mapa final no compositor de impressão.
- Ícone: quote
