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

## Como executar e validar localmente

1. **Confirme a raiz real do checkout antes de executar comandos.**
   A sessão do agente pode ter sido aberta com um diretório antigo ou
   renomeado. Use como raiz a pasta que contém `.git`, `package.json`,
   `app/` e este `AGENTS.md`; não mova nem renomeie o projeto para
   corrigir um `working-dir` inválido.
2. **Preserve o ambiente existente.** Há um `package-lock.json`; use
   `npm` e não troque o gerenciador de pacotes. Não reinstale
   dependências por rotina quando `node_modules` já estiver íntegro.
   O `postinstall` prepara o worker do MapLibre em `public/`.
3. **Antes de iniciar um servidor, verifique as portas 3000–3002.**
   Se já houver um Next.js deste checkout em execução, reutilize-o em
   vez de criar outro processo. Caso contrário, execute `npm run dev`
   na raiz do repositório.
4. **Considere o projeto pronto somente após uma requisição HTTP.**
   Confirme que `http://localhost:3000` (ou a porta indicada pelo
   Next.js) responde com status 200 e confira o terminal do servidor
   para detectar erros de compilação ou de execução.
5. **Quando o pedido for explicitamente “rodar o projeto”, mantenha o
   servidor disponível e informe a URL ao usuário.** Em tarefas de
   implementação ou diagnóstico que só precisem de uma validação
   temporária, encerre o servidor ao concluir para não manter locks em
   `.next` ou `node_modules`.
6. **Não exponha valores de `.env.local`.** É permitido confirmar que
   as variáveis necessárias existem, mas nunca imprima chaves do
   Supabase ou do MapTiler no terminal, em logs ou em respostas.

## Trabalho simultâneo com outros agentes de IA

Mais de um agente (Codex, Claude Code, etc.) pode estar trabalhando
neste repositório ao mesmo tempo, em janelas/sessões diferentes. Isso
já causou uma sessão onde mudanças de um agente foram parar,
sem querer, no commit de outro. Para evitar isso:

1. **Antes de tocar em arquivos**, rode `git status` e `git log -1`.
   Se houver mudanças não commitadas que você não reconhece, elas
   provavelmente são de outro agente em andamento — não sobrescreva
   nem descarte; commite-as separadamente ou pergunte ao usuário.
2. **Commite com frequência**, em blocos pequenos e descritivos.
   Não deixe um monte de trabalho sem commit por muito tempo: quanto
   mais tempo passa, maior a chance de outro agente (ou você mesmo,
   em outra sessão) varrer essas mudanças para um commit que não é
   seu.
3. **Antes de qualquer operação destrutiva ou estrutural** (apagar
   pastas, renomear/mover o diretório do projeto, `git reset --hard`,
   trocar de branch com mudanças pendentes), crie um arquivo
   `.agent-lock.json` na raiz com `{ "agent": "...", "task": "...",
   "startedAt": "<ISO 8601>" }`. Se esse arquivo já existir e for
   recente (poucos minutos), outro agente provavelmente está ativo:
   pare e avise o usuário em vez de seguir. Remova o arquivo assim que
   terminar essa etapa.
4. **Não deixe servidores de dev (`npm run dev`) rodando
   indefinidamente** depois de terminar uma tarefa — eles seguram
   locks de arquivo em `node_modules`/`.next` que atrapalham o outro
   agente ao mover, apagar ou reinstalar dependências.
5. **Nunca renomeie, mova ou apague o diretório raiz do projeto** sem
   confirmar com o usuário primeiro, mesmo que a tarefa pedida pareça
   incluir isso — um agente pode ter o diretório antigo como
   `working-dir` fixo, e o rename quebra a sessão dele sem aviso.
