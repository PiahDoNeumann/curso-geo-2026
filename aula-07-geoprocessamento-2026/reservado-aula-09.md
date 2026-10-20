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
