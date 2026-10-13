# Aula 6: Regra de conjuntos aplicada a geometrias

**Curso:** curso-geo-toledo-2026
**Duração:** 20 min (somente teoria, sem execução no QGIS e sem buffer)
**Público:** gestão municipal
**Objetivo:** o aluno lê uma pergunta do dia a dia e diz qual operação de conjuntos a responde, antes de aprender a ferramenta.

**Contexto:** a tabela de atributos já foi fechada em outra aula. As ferramentas de geoprocessamento (interseção, união, diferença, buffer) serão ensinadas por um colega, em aula própria. Esta aula entrega o raciocínio que torna essas ferramentas óbvias.

## Decisões fechadas

- Template `mira-default`, tema `mira-dark`.
- Exemplos com formas abstratas (A, B, círculos, polígonos), sem dados reais de Toledo.
- De Morgan e distributiva fora da aula. O tempo vai para o exercício do bloco 4.
- Sem bloco de ponte para as ferramentas do QGIS: o colega cobre isso na aula dele.
- Exercício 3 testa a ordem da diferença (B mas não A), para não repetir o slide 5.

## Esboço

| # | Bloco | Tempo | Ideia central |
|---|-------|-------|---------------|
| 1 | Conjuntos com formas | 4 min | A e B em Venn. Quatro resultados: A∩B, A∪B, A−B, A△B. Cada um responde uma pergunta diferente. |
| 2 | Conjunto vira geometria | 3 min | Um polígono é um conjunto de pontos. Casos de borda: só se tocam, não se sobrepõem (resultado vazio), complemento. |
| 3 | Regras | 3 min | Interseção e união são comutativas (A∩B = B∩A). A diferença não é: A−B ≠ B−A. |
| 4 | Pergunta vira operação | 10 min | "E" é interseção, "OU" é união, "MAS NÃO" é diferença. Exercício: ler a frase e escolher a operação. |

## Ressalvas

- Sem demonstração no QGIS, salvo combinação com o colega para não duplicar conteúdo.
- Buffer, dissolver e junção espacial ficam fora desta aula.
- Os blocos 1 a 3 pedem animação (Venn se sobrepondo, recortando, subtraindo).
