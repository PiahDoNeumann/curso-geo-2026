"""Gera o kit da aula: shapefile 'sujo' + GeoJSON de origem limpo.
Coordenadas em SIRGAS 2000 / UTM 22S (EPSG:31982), proximas de Toledo-PR.
"""
import json, os, shapefile

OUT = os.path.dirname(os.path.abspath(__file__))

def box(x0, y0, x1, y1):
    # anel externo em sentido horario (padrao shapefile)
    return [(x0, y0), (x0, y1), (x1, y1), (x1, y0), (x0, y0)]

# (ORDER, NOME, AREA_HA, POP, DESCRICAO, partes)
feicoes = [
    (1, "Centro",              "100",   "9000", "Bairro central",                 [box(222000, 7263000, 223000, 7264000)]),
    (2, "São José",            "100",   "1200", "Norte do Centro",                [box(222000, 7264000, 223000, 7265000)]),
    # o DBF e de largura fixa e descarta espaco comum no fim; usamos espaco NAO-quebravel (U+00A0),
    # invisivel na tabela, que sobrevive ao import e que trim() nao remove (caso real: copiado do Word/web)
    (3, "São José ",      "100",   "850",  "Sul do Centro (espaco no fim)",  [box(222000, 7262000, 223000, 7263000)]),
    (4, "Vila Industrial",     "180",   "400",  "Duas partes (multipolygon)",     [box(221000, 7263000, 221900, 7264000), box(220000, 7263000, 220900, 7264000)]),
    # gravata-borboleta: anel com auto-intersecao, encostado no Centro
    (5, "Jardim Coopagro",     "95",    "2100", "Poligono invalido",              [[(223000, 7263000), (224000, 7264000), (224000, 7263000), (223000, 7264000), (223000, 7263000)]]),
    (6, "",                    "100,5", "",     "Nome vazio, area com virgula",   [box(221000, 7264000, 222000, 7265000)]),
    (7, "JARDIM PORTO ALEGRE", "100",   "3300", "Tudo em maiusculas",             [box(223000, 7264000, 224000, 7265000)]),
    (8, "Santa Clara",         "90",    "700",  "Bairro normal",                  [box(221000, 7262000, 222000, 7263000)]),
]

# ---------- shapefile sujo (Latin-1, sem .cpg, sem .prj) ----------
shp = os.path.join(OUT, "bairros_sujo")
with shapefile.Writer(shp, shapeType=shapefile.POLYGON, encoding="latin-1") as w:
    w.field("ORDER", "N", 4, 0)
    w.field("NOME", "C", 40)
    w.field("AREA_HA", "C", 10)     # numero guardado como texto
    w.field("POP", "C", 10)         # idem
    w.field("DESCRICAO", "C", 60)
    for ordem, nome, area, pop, desc, partes in feicoes:
        w.poly(partes)
        w.record(ordem, nome, area, pop, desc)

for ext in (".cpg", ".prj"):
    p = shp + ext
    if os.path.exists(p):
        os.remove(p)

# ---------- GeoJSON de origem (limpo, UTF-8, com CRS) ----------
desc_longa = ("Descrição detalhada do bairro para o exercício de exportação: " * 6).strip()
assert len(desc_longa) > 254
feats = []
for ordem, nome, area, pop, desc, partes in feicoes:
    if not nome.strip():
        nome_limpo = "Sem nome"
    else:
        nome_limpo = nome.strip()
    geom = {"type": "MultiPolygon", "coordinates": [[[list(c) for c in anel]] for anel in partes]}
    feats.append({
        "type": "Feature",
        "properties": {
            "codigo_bairro": ordem,
            "nome_completo_do_bairro": nome_limpo,        # > 10 chars → truncado no shape
            "nome_abreviado_do_bairro": nome_limpo[:8],   # mesmo prefixo de 10 chars → nome_abre_1
            "area_hectares": float(area.replace(",", ".")),
            "populacao_estimada": int(pop) if pop else None,
            "descricao_detalhada": desc_longa,           # > 254 chars → cortada
            "ativo": True,                                # booleano → some
            "atualizado_em": "2026-09-22T07:30:00",       # data+hora → so data
        },
        "geometry": geom,
    })
gj = {
    "type": "FeatureCollection",
    "crs": {"type": "name", "properties": {"name": "urn:ogc:def:crs:EPSG::31982"}},
    "features": feats,
}
with open(os.path.join(OUT, "bairros_fonte.geojson"), "w", encoding="utf-8") as f:
    json.dump(gj, f, ensure_ascii=False, indent=1)

print("ok:", sorted(os.listdir(OUT)))
