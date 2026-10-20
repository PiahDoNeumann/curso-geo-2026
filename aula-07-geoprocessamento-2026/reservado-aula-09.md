# Slide reservado para a aula 9: Reprojete antes de medir

Retirado da aula 07 em 2026-10-21 a pedido do Piah. Para reusar: colar a section no deck da aula 9 e a função `animSelo` no script, chamando `animSelo('st-NN')` em `ligar()` com o id do svg ajustado.

## HTML

```html
    <!-- ============ SLIDE 7: CTA ============ -->
    <section class="min-h-screen flex flex-col items-center justify-center px-6 py-16">
        <div class="glass-card w-full max-w-5xl p-8 md:p-10 relative" data-aos="zoom-in">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
                <div>
                    <div class="slide-title-row flex items-center gap-4 mb-4">
                        <div class="icon-hero"><i data-lucide="move-right" class="primary-color w-6 h-6"></i></div>
                        <h2 class="text-3xl md:text-4xl font-black">Reprojete <span class="primary-color">antes</span> de medir</h2>
                    </div>
                    <p class="text-soft text-lg mb-6">Um passo antes de qualquer buffer ou cálculo de área.</p>
                    <ol class="space-y-3 text-lg">
                        <li><span class="primary-color font-black">1.</span> Botão direito na camada</li>
                        <li><span class="primary-color font-black">2.</span> Exportar &gt; Salvar feições como</li>
                        <li><span class="primary-color font-black">3.</span> SRC: <span class="primary-color font-bold">EPSG:31982</span></li>
                    </ol>
                </div>
                <div class="anim-stage relative" style="height: clamp(220px, 32vh, 300px);">
                    <button class="replay-btn" onclick="window.miraReplay('st-07')">↻ replay</button>
                    <svg id="st-07" preserveAspectRatio="xMidYMid meet"></svg>
                </div>
            </div>
        </div>
    </section>

```

## JS

```js
    /* ---------- 7: o selo do SRC troca de 4674 para 31982 ---------- */
    function animSelo(id) {
        var p = palco(id); if (!p) return;
        var F = p.F, g = p.svg.append('g');
        var selo = g.append('g');
        var caixa = selo.append('rect').attr('rx', 36).attr('stroke-width', 6);
        var cod = texto(selo, 110, 900, COR.tinta);
        var uni = texto(selo, 44, 700, COR.tinta);
        var seta = texto(g, 36, 700, COR.tinta).attr('opacity', .7).text('antes de medir, troque o SRC');
        reger(id, function (ms) {
            var t = ms / 1000, cx = F.W / 2, cy = F.H * .48, w = F.W * .78, h = F.H * .56;
            var e = eio(seg(t, 0, .8)), s = ciclo(t, 1, 5), q = s < 0 ? 0 : s * 5;
            var k = q < 2.5 ? seg(q, 1.8, 2.3) : 1 + seg(q, 4.3, 4.8);
            var metros = k > .5 && k < 1.5;
            var sy = Math.max(Math.abs(Math.cos(Math.PI * k)), .02);
            selo.attr('transform', 'translate(' + cx + ',' + cy + ') scale(' + e + ',' + (e * sy) + ')');
            caixa.attr('x', -w / 2).attr('y', -h / 2).attr('width', w).attr('height', h)
                .attr('fill', metros ? COR.marca : 'none').attr('fill-opacity', .15)
                .attr('stroke', metros ? COR.marca : COR.tinta).attr('stroke-opacity', metros ? 1 : .4);
            cod.attr('x', 0).attr('y', 18).attr('fill', metros ? COR.marca : COR.tinta).text(metros ? 'EPSG:31982' : 'EPSG:4674');
            uni.attr('x', 0).attr('y', 90).attr('opacity', .8).text(metros ? 'metros' : 'graus');
            seta.attr('x', cx).attr('y', F.H - 20).attr('opacity', .7 * e);
        });
    }

```

---

# Slide reservado para a aula 9: 500 graus dá a volta na Terra

Retirado da aula 07 em 2026-10-21 a pedido do Piah. Mesmo procedimento: colar a section, a função `animGraus` e chamar `animGraus('st-NN')` em `ligar()`. Usa os utilitários `ciclo`, `onda` e `seg` do script da aula 07.

## HTML

```html
    <!-- ============ SLIDE 6 ============ -->
    <section class="min-h-screen flex flex-col items-center justify-center px-6 py-16">
        <div class="text-center mb-8" data-aos="fade-up">
            <div class="slide-title-row justify-center flex items-center gap-4">
                <div class="icon-hero"><i data-lucide="triangle-alert" class="primary-color w-6 h-6"></i></div>
                <h2 class="text-4xl md:text-5xl font-black"><span class="primary-color">500 graus</span> dá a volta na Terra</h2>
            </div>
            <p class="text-soft text-lg mt-3">Medir em graus não dá erro: dá número errado</p>
        </div>
        <div class="glass-card w-full max-w-5xl p-4 md:p-6 relative" data-aos="fade-up">
            <button class="replay-btn" onclick="window.miraReplay('st-06')">↻ replay</button>
            <div class="anim-stage" style="height: clamp(320px, 50vh, 480px);"><svg id="st-06" preserveAspectRatio="xMidYMid meet"></svg></div>
        </div>
        <div class="flex flex-wrap justify-center gap-3 mt-8" data-aos="fade-up">
            <span class="attribute-pill px-5 py-2 text-sm">EPSG:4674 guarda (graus)</span>
            <span class="attribute-pill px-5 py-2 text-sm">EPSG:31982 mede (metros)</span>
        </div>
    </section>

```

## JS

```js
    /* ---------- 6: 500 graus contra 500 metros ---------- */
    function animGraus(id) {
        var p = palco(id); if (!p) return;
        var F = p.F, svg = p.svg, defs = svg.append('defs'), g = svg.append('g');
        var clipE = defs.append('clipPath').attr('id', id + '-e').append('rect').attr('rx', 12);
        var clipD = defs.append('clipPath').attr('id', id + '-d').append('rect').attr('rx', 12);
        var gE = g.append('g').attr('clip-path', 'url(#' + id + '-e)');
        var gDi = g.append('g').attr('clip-path', 'url(#' + id + '-d)');
        function malha(pai) {
            return d3.range(14).map(function () { return pai.append('line').attr('stroke', COR.tinta).attr('stroke-opacity', .12).attr('stroke-width', 1.5); });
        }
        var mE = malha(gE), mD = malha(gDi);
        var cE = gE.append('circle').attr('fill', COR.marca).attr('fill-opacity', .3).attr('stroke', COR.marca).attr('stroke-width', 3);
        var cD = gDi.append('circle').attr('fill', COR.marca).attr('fill-opacity', .3).attr('stroke', COR.marca).attr('stroke-width', 3);
        var aD = gDi.append('circle').attr('fill', 'none').attr('stroke', COR.marca).attr('stroke-width', 2);
        var pE = gE.append('circle').attr('r', 6).attr('fill', COR.tinta);
        var pD = gDi.append('circle').attr('r', 6).attr('fill', COR.tinta);
        var bE = g.append('rect').attr('rx', 12).attr('fill', 'none').attr('stroke', COR.tinta).attr('stroke-opacity', .3);
        var bD = g.append('rect').attr('rx', 12).attr('fill', 'none').attr('stroke', COR.marca).attr('stroke-opacity', .6);
        var tE = texto(g, 20, 800, COR.tinta).text('EPSG:4674 · graus');
        var tD = texto(g, 20, 800, COR.marca).text('EPSG:31982 · metros');
        var kmE = texto(g, 26, 900, COR.marca);
        var aviso = texto(g, 17, 700, COR.tinta).text('o círculo saiu do mapa');
        var capE = texto(g, 15, 600, COR.tinta).attr('opacity', .8).text('buffer 500 = 500 graus ≈ 55.500 km de raio');
        var capD = texto(g, 15, 600, COR.tinta).attr('opacity', .8).text('buffer 500 = 500 metros em volta da escola');
        reger(id, function (ms) {
            var t = ms / 1000, top = 46, bot = F.H - 36, h = bot - top;
            var wP = F.W / 2 - 45, xE = 30, xD = F.W / 2 + 15;
            [[clipE, bE, xE], [clipD, bD, xD]].forEach(function (a) {
                a[0].attr('x', a[2]).attr('y', top).attr('width', wP).attr('height', h);
                a[1].attr('x', a[2]).attr('y', top).attr('width', wP).attr('height', h);
            });
            [[mE, xE], [mD, xD]].forEach(function (a) {
                a[0].forEach(function (l, i) {
                    if (i < 7) { var x = a[1] + wP * (i + .5) / 7; l.attr('x1', x).attr('x2', x + 12).attr('y1', top).attr('y2', bot); }
                    else { var y = top + h * (i - 6.5) / 7; l.attr('x1', a[1]).attr('x2', a[1] + wP).attr('y1', y).attr('y2', y - 8); }
                });
            });
            var e = eio(seg(t, 0, .8)), cyM = top + h / 2;
            var u = ciclo(t, .8, 5.5), k = u < 0 ? 0 : d3.easeCubicIn(seg(u, 0, .65)), fade = u < 0 ? 1 : 1 - seg(u, .88, 1);
            cE.attr('cx', xE + wP / 2).attr('cy', cyM).attr('r', 8 + wP * 2 * k).attr('opacity', fade);
            pE.attr('cx', xE + wP / 2).attr('cy', cyM).attr('opacity', e);
            kmE.attr('x', xE + wP / 2).attr('y', bot - 18).attr('opacity', e * fade)
                .text('raio: ' + Math.round(55500 * k).toLocaleString('pt-BR') + ' km');
            aviso.attr('x', xE + wP / 2).attr('y', top + 28).attr('opacity', u < 0 ? 0 : seg(u, .6, .7) * fade * (.6 + .4 * onda(t, .8)));
            var rD = Math.min(h * .2, 55) * eio(seg(t, .8, 1.8)), uD = ciclo(t, 2, 2.4);
            cD.attr('cx', xD + wP / 2).attr('cy', cyM).attr('r', rD);
            aD.attr('cx', xD + wP / 2).attr('cy', cyM).attr('r', rD + 20 * Math.max(uD, 0)).attr('opacity', uD < 0 ? 0 : 1 - uD);
            pD.attr('cx', xD + wP / 2).attr('cy', cyM).attr('opacity', e);
            tE.attr('x', xE + wP / 2).attr('y', 30).attr('opacity', e); tD.attr('x', xD + wP / 2).attr('y', 30).attr('opacity', e);
            capE.attr('x', xE + wP / 2).attr('y', F.H - 10).attr('opacity', .8 * e); capD.attr('x', xD + wP / 2).attr('y', F.H - 10).attr('opacity', .8 * e);
        });
    }

```
