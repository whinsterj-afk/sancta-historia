<!-- BEGIN:nextjs-agent-rules -->
# This is NOT the Next.js you know

This version has breaking changes — APIs, conventions, and file structure may all differ from your training data. Read the relevant guide in `node_modules/next/dist/docs/` before writing any code. Heed deprecation notices.
<!-- END:nextjs-agent-rules -->

# Sancta Historia

Plataforma interativa de página única: mapa mundial (MapLibre + MapTiler)
sincronizado com uma linha do tempo, exibindo santos, papas e eventos
históricos por ano a partir de dados no Supabase.

## Estrutura do projeto

```
app/
  layout.tsx           # fontes (Cinzel/Cormorant Garamond) e shell HTML
  page.tsx              # composição principal: busca, painéis, mapa, timeline
  page.module.css        # posicionamento absoluto e responsividade da tela do mapa
  globals.css            # identidade visual (paleta ink/gold), painéis, marcadores do mapa
  saints/[id]/page.tsx    # página dedicada de um santo

components/
  TopBar.tsx             # cabeçalho: brasão, busca com sugestões, "Sobre" e "Legenda do mapa"
  Timeline.tsx           # slider de ano, eras nomeadas, pontífice vigente
  FactsPanel.tsx          # painel esquerdo: fatos históricos do período
  SaintsPanel.tsx         # painel direito: santos vivos no período, favoritos
  MapContextPanel.tsx     # painel de contexto ao selecionar um santo/evento (trajetória, eventos relacionados)
  SaintsMap.tsx           # mapa MapLibre: marcadores, zoom/fitBounds, estilo MapTiler
  AboutModal.tsx          # modal "Sobre o projeto" (acionado pelo TopBar)
  MapLegend.tsx           # legenda dos símbolos do mapa (acionada pelo TopBar)
  BottomNav.tsx           # navegação inferior por ícones — construída, ainda não usada em app/
  icons.tsx               # ícones SVG inline usados em todo o app

lib/
  supabase.ts             # cliente Supabase (usa NEXT_PUBLIC_SUPABASE_URL/ANON_KEY)
  catholicEditorial.ts     # normaliza/revisa textos de santos, eventos e locais vindos do banco
  historicalYear.ts        # formata anos como "d.C."/"a.C." e intervalos de vida

scripts/
  copy-maplibre-worker.mjs   # postinstall: copia o worker do maplibre-gl para public/
  audit-normalized-data.mjs  # auditoria dos dados normalizados no Supabase
  revise-catholic-language.mjs # revisão em lote da linguagem editorial católica

supabase/
  migrations/              # migrações SQL (schema de trajetórias, políticas RLS)
  inventory/               # snapshots de inventário antes/depois de migrações

database/                  # scripts SQL históricos anteriores à normalização
```

## Dados e configuração

- Fonte de dados: Supabase (tabelas `saints_catalog`, `popes`,
  `historical_events`, `timeline_saint_points`, `saint_search_catalog`).
- Variáveis de ambiente (`.env.local`, ver `.env.example`):
  `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`,
  `NEXT_PUBLIC_MAPTILER_KEY`.
- O ano selecionado na timeline é persistido em `localStorage`
  (`sancta-historia:selected-year`).

## Coisas a saber antes de mexer

- `BottomNav.tsx` existe mas não está montado em nenhuma página — só
  adicione seus itens (Camadas, Peregrinações etc.) quando a
  funcionalidade por trás deles existir; não é um lugar para novos
  botões sem ação.
- O layout do mapa reserva "zonas seguras" (ver paddings calculados em
  `SaintsMap.tsx` a partir de `[data-map-left-panel]`,
  `[data-map-right-panel]`, `[data-map-timeline]` e
  `[data-map-context-panel]`) para não sobrepor marcadores aos
  painéis — ao mexer no layout desses painéis, cheque se os
  `data-*` continuam batendo com o que `SaintsMap.tsx` procura.
- `pointer-events: none` é o padrão em `.hero-header`; qualquer
  elemento novo renderizado dentro do `TopBar` (modais, popovers)
  precisa herdar `pointer-events: auto` explicitamente ou ficará
  visível porém inerte a cliques.
