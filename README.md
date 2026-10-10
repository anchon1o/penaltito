# PENALTITO

Reto diario de penaltis. Web estática (index.html) + Supabase (proxecto "xogos") para o ranking e o xogo en liña.

## Arquivos
- `index.html` — o xogo.
- `config.js` — URL e clave pública de Supabase (énchea ti).
- `supabase-penaltito.sql` — crea a táboa `pt_reto` e as vistas `pt_ranking` e `ranking_xogos`.
- `ranking.html` — ranking compacto para incrustar noutras webs.

## Ranking dentro de "cagando"
Engade un iframe:

    <iframe src="https://penaltito.vercel.app/ranking.html?p=hoxe&lang=gl&n=10"
            style="width:100%;height:420px;border:0;border-radius:12px"></iframe>

Parámetros:
- `p`: hoxe · semana · mes · sempre
- `lang`: gl · es · ca · eu
- `n`: cantas persoas amosar (máx. 50)
- `theme=light` para fondo branco
- `tabs=0` para ocultar as pestanas
