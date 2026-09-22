-- =====================================================================
--  AULA QGIS + PostGIS: erros silenciosos
--  Roteiro de demonstração. Rodar bloco a bloco (psql, DBeaver ou DB Manager).
--  Pré-requisito: bairros_sujo.shp importado como public.bairros_sujo
--  (DB Manager → Importar camada, CRS 31982, codificação ISO-8859-1,
--   "Converter nomes para minúsculas" MARCADO, "Promover para multipartes" MARCADO).
--  Para mostrar o cenário ruim, importe uma 2ª vez DESMARCANDO as duas opções,
--  como public."BAIRROS_SUJO".
-- =====================================================================

CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS unaccent;

-- ---------------------------------------------------------------------
-- 0. O que chegou?  (gabarito: 8 linhas, tipos text, geom MultiPolygon)
-- ---------------------------------------------------------------------
\d bairros_sujo
SELECT count(*) FROM bairros_sujo;
SELECT DISTINCT GeometryType(geom), ST_SRID(geom) FROM bairros_sujo;
-- Se aparecer POLYGON e MULTIPOLYGON juntos: faltou "Promover para multipartes".
-- Se aparecer SRID 0: faltou definir o CRS antes do import.

-- ---------------------------------------------------------------------
-- 1. IDENTIFICADORES: maiúsculas e palavras reservadas
-- ---------------------------------------------------------------------
-- Campo ORDER importado sem converter para minúsculas:
SELECT ORDER FROM "BAIRROS_SUJO";       -- ERRO de sintaxe: ORDER é palavra reservada
SELECT "ORDER" FROM "BAIRROS_SUJO";     -- funciona, mas exige aspas para sempre
SELECT nome FROM "BAIRROS_SUJO";        -- ERRO: column "nome" does not exist (é "NOME")
SELECT * FROM bairros_sujo;             -- ERRO se só existir a versão com aspas
-- Mesmo com a versão minúscula, a coluna "order" ainda precisa de aspas:
SELECT "order", nome FROM bairros_sujo ORDER BY "order";

-- Limite de 63 bytes: só NOTICE, nunca erro
CREATE TABLE teste_nome_longo (
  nome_completo_do_bairro_com_descricao_detalhada_e_observacoes_1 int,   -- 64 chars
  nome_completo_do_bairro_com_descricao_detalhada_e_observacoes_2 int    -- trunca igual → ERRO "already exists"
);
-- NOTICE: identifier "..." will be truncated to "..."
DROP TABLE IF EXISTS teste_nome_longo;

-- Aspas simples × duplas
SELECT * FROM bairros_sujo WHERE nome = "Centro";   -- ERRO: column "Centro" does not exist
SELECT * FROM bairros_sujo WHERE nome = 'Centro';   -- 1 linha

-- ---------------------------------------------------------------------
-- 2. DADOS: acento, caixa, espaço, vazio  (PERGUNTA 1: quantos "São José"?)
-- ---------------------------------------------------------------------
SELECT count(*) FROM bairros_sujo WHERE nome = 'São José';    -- gabarito ingênuo: 1  (esperado: 2)
SELECT count(*) FROM bairros_sujo WHERE nome = 'Sao Jose';    -- 0
SELECT count(*) FROM bairros_sujo WHERE nome = 'SÃO JOSÉ';    -- 0

-- Por quê? Olhe o comprimento:
SELECT "order", nome, length(nome) AS tam, nome = trim(nome) AS sem_espaco_comum,
       encode(convert_to(nome, 'UTF8'), 'hex') AS bytes
FROM bairros_sujo ORDER BY "order";
-- O 2º "São José" tem 9 caracteres: termina com espaço NÃO-QUEBRÁVEL (c2a0 em UTF-8),
-- invisível na tabela de atributos. trim() comum NÃO remove:
SELECT nome, length(trim(nome)) FROM bairros_sujo WHERE "order" = 3;   -- ainda 9

-- Solução: normalizar tudo. \s NÃO pega o NBSP em todo locale; incluir \u00a0 explicitamente.
SELECT count(*) FROM bairros_sujo
WHERE unaccent(lower(regexp_replace(nome, '[[:space:]\u00a0]+$', ''))) = 'sao jose';   -- 2 ✔

-- Caixa:
SELECT nome FROM bairros_sujo WHERE nome = 'Jardim Porto Alegre';     -- 0
SELECT nome FROM bairros_sujo WHERE nome ILIKE 'jardim porto alegre'; -- 1

-- Vazio × NULL: o DBF não tem NULL.
SELECT count(*) FROM bairros_sujo WHERE nome IS NULL;          -- 0
SELECT count(*) FROM bairros_sujo WHERE nome = '';             -- 1
SELECT count(*) FROM bairros_sujo WHERE nullif(nome, '') IS NULL;  -- 1 ✔

-- Espaço comum no fim (o que vem do Excel): simular e mostrar trim()
UPDATE bairros_sujo SET nome = nome || '  ' WHERE "order" = 8;
SELECT count(*) FROM bairros_sujo WHERE nome = 'Santa Clara';        -- 0
SELECT count(*) FROM bairros_sujo WHERE trim(nome) = 'Santa Clara';  -- 1
UPDATE bairros_sujo SET nome = trim(nome) WHERE "order" = 8;

-- ---------------------------------------------------------------------
-- 3. NÚMERO COMO TEXTO  (PERGUNTA 2: qual bairro tem a maior área?)
-- ---------------------------------------------------------------------
SELECT nome, area_ha FROM bairros_sujo ORDER BY area_ha DESC LIMIT 1;
-- Responde "Jardim Coopagro, 95"  ← ERRADO: ordenação de texto ('95' > '180' > '100,5' > '100')
SELECT nome, area_ha FROM bairros_sujo ORDER BY area_ha::numeric DESC;
-- ERRO: invalid input syntax for type numeric: "100,5"  ← pelo menos avisa
SELECT nome, replace(area_ha, ',', '.')::numeric AS area_ha
FROM bairros_sujo ORDER BY 2 DESC LIMIT 1;
-- "Vila Industrial, 180" ✔

-- Conferindo com a geometria (1 km² = 100 ha):
SELECT nome, area_ha, round((ST_Area(geom) / 10000)::numeric, 1) AS area_geom_ha
FROM bairros_sujo ORDER BY "order";
-- Jardim Coopagro: área calculada = 0,0 ha. Nenhum erro — é a gravata-borboleta (seção 4):
-- os dois triângulos têm sinais opostos e se anulam. Um relatório de áreas sairia errado em silêncio.

-- Corrigir de vez o tipo da coluna:
ALTER TABLE bairros_sujo
  ALTER COLUMN area_ha TYPE numeric(10,2) USING replace(area_ha, ',', '.')::numeric,
  ALTER COLUMN pop     TYPE integer       USING nullif(pop, '')::integer;

-- Collation: depende de como o banco foi criado
SELECT datname, datcollate FROM pg_database WHERE datname = current_database();
SELECT nome FROM bairros_sujo WHERE nome <> '' ORDER BY nome;                    -- ordem do banco
SELECT nome FROM bairros_sujo WHERE nome <> '' ORDER BY nome COLLATE "C";        -- maiúsculas primeiro, acento por último
SELECT collname FROM pg_collation WHERE collname ILIKE 'pt%';                  -- quais collations pt existem?
SELECT nome FROM bairros_sujo WHERE nome <> '' ORDER BY nome COLLATE "pt_BR.utf8"; -- ERRO se não existir: crie o banco com pt_BR.UTF-8

-- ---------------------------------------------------------------------
-- 4. GEOMETRIA INVÁLIDA  (PERGUNTA 3: quem faz fronteira com o Centro?)
-- ---------------------------------------------------------------------
SELECT "order", nome, ST_IsValid(geom), ST_IsValidReason(geom)
FROM bairros_sujo WHERE NOT ST_IsValid(geom);
-- order 5, Jardim Coopagro: Self-intersection

-- Vizinhos do Centro: o resultado com geometria inválida é imprevisível.
SELECT b.nome
FROM bairros_sujo c JOIN bairros_sujo b ON ST_Touches(c.geom, b.geom)
WHERE c.nome = 'Centro' ORDER BY 1;
-- Esperado (6 vizinhos): '', JARDIM PORTO ALEGRE, Jardim Coopagro, Santa Clara, São José, São José[nbsp]
-- Jardim Coopagro pode faltar, ou a consulta pode até funcionar por acaso — esse é o ponto:
-- com geometria inválida o PostGIS NÃO garante o resultado dos predicados.

-- Operação de sobreposição estoura (esta pelo menos avisa):
SELECT ST_Union(geom) FROM bairros_sujo;
-- ERROR: TopologyException / GEOSUnaryUnion ... (dependendo da versão pode passar)

-- Corrigir:
UPDATE bairros_sujo SET geom = ST_Multi(ST_MakeValid(geom)) WHERE NOT ST_IsValid(geom);
SELECT nome, GeometryType(geom), ST_NumGeometries(geom) FROM bairros_sujo WHERE "order" = 5;
-- A gravata virou MULTIPOLYGON com 2 triângulos. Repetir a consulta de vizinhos: agora é determinística.

-- ---------------------------------------------------------------------
-- 5. QGIS: chave primária, metadados, view
-- ---------------------------------------------------------------------
-- Sem PK o QGIS abre somente leitura ou usa ctid. Ver a chave:
SELECT conname, pg_get_constraintdef(oid) FROM pg_constraint
WHERE conrelid = 'bairros_sujo'::regclass;
-- O import do QGIS normalmente cria "id serial PRIMARY KEY". Se não criou:
-- ALTER TABLE bairros_sujo ADD COLUMN id serial PRIMARY KEY;

-- Metadados estimados: extensão vem das estatísticas. Sem ANALYZE, o "zoom para camada" erra.
SELECT relname, n_live_tup, last_analyze FROM pg_stat_user_tables WHERE relname = 'bairros_sujo';
ANALYZE bairros_sujo;

-- View sem tipo de geometria explícito: o QGIS varre tudo para descobrir o tipo.
-- (uma coluna tipada é herdada pela view; o problema aparece quando a view calcula a geometria)
CREATE OR REPLACE VIEW v_bairros_ruim AS
  SELECT id, nome, ST_Simplify(geom, 1) AS geom FROM bairros_sujo;
-- Ver o que o QGIS "enxerga":
SELECT f_table_name, type, srid FROM geometry_columns WHERE f_table_name LIKE 'v_bairros%';
-- v_bairros_ruim → type GEOMETRY, srid 0 (o QGIS terá que adivinhar)

CREATE OR REPLACE VIEW v_bairros_bom AS
  SELECT id, nome, geom::geometry(MultiPolygon, 31982) AS geom FROM bairros_sujo;
-- v_bairros_bom → MULTIPOLYGON, 31982 ✔   (e no QGIS, escolher "id" como chave da view)

-- ---------------------------------------------------------------------
-- 6. ENCODING no import (mostrar com shp2pgsql, se disponível)
-- ---------------------------------------------------------------------
-- shp2pgsql -s 31982 -W latin1 -I bairros_sujo.shp public.bairros_ok | psql -d aula
-- Sem -W latin1:  ERROR: invalid byte sequence for encoding "UTF8": 0xe3 0x6f 0x20
--                 (esse grita — o mojibake silencioso acontece quando o QGIS adivinha errado
--                  e converte "S\xe3o" como se fosse outra codificação)

-- ---------------------------------------------------------------------
-- 7. Tabela final limpa (o que o aluno deveria entregar)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS bairros;
CREATE TABLE bairros AS
SELECT id,
       "order"                                                 AS ordem,
       nullif(regexp_replace(nome, '[[:space:]\u00a0]+$', ''), '')           AS nome,
       area_ha,
       pop                                                     AS populacao,
       descricao,
       ST_Multi(ST_MakeValid(geom))::geometry(MultiPolygon, 31982) AS geom
FROM bairros_sujo;
ALTER TABLE bairros ADD PRIMARY KEY (id);
CREATE INDEX bairros_geom_idx ON bairros USING gist (geom);
ANALYZE bairros;

SELECT ordem, nome, area_ha, populacao, ST_IsValid(geom) FROM bairros ORDER BY ordem;
SELECT count(*) FROM bairros WHERE unaccent(lower(nome)) = 'sao jose';   -- 2
