<!-- BEGIN:nextjs-agent-rules -->
# This is NOT the Next.js you know

This version has breaking changes — APIs, conventions, and file structure may all differ from your training data. Read the relevant guide in `node_modules/next/dist/docs/` before writing any code. Heed deprecation notices.
<!-- END:nextjs-agent-rules -->

# Sancta Historia

Plataforma interativa de página única: mapa mundial (MapLibre + MapTiler)
sincronizado com uma linha do tempo, exibindo santos, papas e eventos
históricos por ano a partir de dados no Supabase.

## 1. Visão do produto

Sancta Historia é uma plataforma digital de exploração da História da
Igreja Católica — uma espécie de "Google Earth da História da Igreja".
Permite navegar por uma linha do tempo interativa que conecta santos,
eventos da Igreja, história mundial, papados, concílios, ordens
religiosas e geografia histórica.

Missão: tornar visual, acessível e compreensível toda a história da
santidade cristã, conectando pessoas, lugares, eventos e séculos em uma
única experiência interativa.

Domínio: sanctahistoria.com

### 1.1. Voz editorial (REGRA IMPORTANTE DO PROJETO)

O Sancta Historia é um site de um católico para católicos. Todo o
conteúdo é escrito de dentro da fé católica, e não sob a perspectiva de
um observador externo ou acadêmico neutro.

As verdades da fé católica são afirmadas como verdades, sem
relativizá-las com expressões que as tratem como mera crença ou ponto
de vista.

- ERRADO: "Jesus é, para a fé católica, o Filho de Deus."
- ERRADO: "Segundo os cristãos, Jesus ressuscitou."
- ERRADO: "Os católicos acreditam que Maria é Mãe de Deus."
- CERTO: "Jesus é o Filho de Deus."
- CERTO: "Jesus ressuscitou ao terceiro dia."
- CERTO: "Maria é a Mãe de Deus."

Diretrizes de aplicação:

- Não usar fórmulas como "para a fé católica...", "segundo a
  crença...", "os cristãos acreditam que...", "de acordo com a
  tradição da Igreja..." ao enunciar verdades de fé. Afirmá-las
  diretamente.
- Fatos de datação incerta (comuns na Igreja Antiga) continuam podendo
  usar "c.", "por volta de", "a tradição relata" — isso é honestidade
  histórica sobre DATAS e LUGARES, não relativização da fé. Ex.: "A
  tradição relata que São Tomé pregou na Índia" é aceitável, pois trata
  de um fato histórico incerto, não de uma verdade de fé.
- A distinção é: verdades de fé (afirmação direta) vs. fatos históricos
  de fontes incertas (podem ter ressalva de datação).
- Isso vale para todo o conteúdo: biografias de santos, descrições de
  fatos históricos, textos de interface, páginas dos papas.
- Os marcos principais da linha do tempo devem priorizar acontecimentos
  da vida da Igreja, como concílios, pontificados, aparições e movimentos
  de renovação católica. Não use rupturas ou movimentos contrários à
  Igreja como nomes de era; quando forem historicamente indispensáveis,
  trate-os apenas no contexto necessário e a partir da perspectiva
  católica.
- Essa regra já está em aplicação hoje: `lib/catholicEditorial.ts`
  mantém revisões manuais de textos vindos do Supabase por
  `id`, e `scripts/revise-catholic-language.mjs` faz a revisão em
  lote. Ao adicionar ou revisar texto de santos/eventos/locais, siga
  este padrão em vez de escrever a frase hedged direto na UI.

## 2. Público-alvo

Católicos praticantes, catequistas, seminaristas, sacerdotes,
historiadores, estudantes e pesquisadores.

## 3. Stack técnica (estado real vs. visão)

- Frontend: Next.js + TypeScript + Tailwind CSS.
  **Framer Motion está na visão do produto, mas não é uma dependência
  instalada hoje** (não consta em `package.json`); as transições atuais
  usam CSS puro (`app/globals.css`, `app/page.module.css`).
- Mapas: MapLibre GL JS + MapTiler (tiles), com estilo customizado
  histórico/sépia via filtro CSS em `.maplibregl-canvas`
  (`app/globals.css`). Migrado do Mapbox por ser gratuito e
  open-source. **OpenFreeMap como fallback é uma ideia registrada na
  visão do produto, ainda não implementada no código.**
- Banco de dados: Supabase (PostgreSQL).
- Hospedagem: Vercel.
- Versionamento: GitHub.

## 4. Funcionalidades (visão de produto)

> As funcionalidades abaixo descrevem a visão do produto, não
> necessariamente o que já está implementado. Veja "Dados e
> configuração" e "Estrutura do projeto" para o estado real do código.

- Home institucional
- Linha do tempo interativa
- Mapa-múndi dinâmico
- Perfil detalhado dos santos
- Contexto histórico sincronizado (ao selecionar um ano, mostrar santos
  vivos, papa reinante, concílios, eventos mundiais e contexto
  político-cultural)

Hoje a home já É a linha do tempo + mapa sincronizado (não há uma
"home institucional" separada), e a página de perfil do santo existe em
`app/saints/[id]/page.tsx`.

## 5. Arquitetura de telas (visão de produto)

```
HOME → TIMELINE → PERFIL DO SANTO → DETALHAMENTO HISTÓRICO
```

Layout principal: Linha do Tempo | Mapa-múndi, com painel de detalhes
inferior. Na implementação atual, "timeline" e "mapa" são a mesma tela
(`app/page.tsx`); o "detalhamento histórico" é o `MapContextPanel.tsx`,
aberto por cima do mapa ao selecionar um santo ou evento.

## Estrutura do projeto

```
proxy.ts                 # (raiz) refresca a sessão Supabase a cada request —
                          # é o "middleware.ts" do Next.js 16, renomeado

app/
  layout.tsx           # fontes (Cinzel/Cormorant Garamond) e shell HTML
  page.tsx              # composição principal: busca, painéis, mapa, timeline
  page.module.css        # posicionamento absoluto e responsividade da tela do mapa
  globals.css            # identidade visual (paleta ink/gold), painéis, marcadores do mapa
  saints/[id]/page.tsx    # página dedicada de um santo, com contador de devotos
  auth/callback/route.ts  # troca o "code" do OAuth (Google) pela sessão
  auth/confirm/route.ts   # verifica o token_hash do e-mail de confirmação de cadastro

components/
  TopBar.tsx             # cabeçalho: brasão, busca com sugestões, "Sobre" e conta
  Timeline.tsx           # slider de ano, eras nomeadas, pontífice vigente e controle da legenda
  FactsPanel.tsx          # painel esquerdo: fatos históricos do período
  SaintsPanel.tsx         # painel direito: santos vivos no período, favoritos
  MapContextPanel.tsx     # painel de contexto ao selecionar um santo/evento (trajetória, eventos relacionados)
  SaintsMap.tsx           # mapa MapLibre: santos, marcos, estrutura eclesiástica por viewport/zoom, rotas e fitBounds
  AboutModal.tsx          # modal "Sobre o projeto" (acionado pelo TopBar)
  MapLegend.tsx           # conteúdo da legenda dos símbolos (acionado pela seta acima da timeline)
  AuthModal.tsx           # login com Google (signInWithOAuth) ou e-mail/senha, mostrado quando deslogado
  ProfileModal.tsx        # nome, cidade, país, foto e santo de devoção, mostrado quando logado
  BottomNav.tsx           # navegação inferior por ícones — construída, ainda não usada em app/
  icons.tsx               # ícones SVG inline usados em todo o app

lib/
  supabase.ts             # cliente Supabase anônimo (dados públicos: mapa, timeline, busca, santo)
  supabaseBrowserClient.ts # cliente Supabase autenticado para Client Components (@supabase/ssr)
  supabaseServerClient.ts  # cliente Supabase autenticado para Server Components/Route Handlers
  useSupabaseSession.ts    # hook de sessão (user atual) via onAuthStateChange
  searchText.ts            # normalizeSearchTerm, usado pela busca do TopBar e pelo seletor de santo do perfil
  catholicEditorial.ts     # normaliza/revisa textos de santos, eventos e locais vindos do banco
  historicalYear.ts        # formata anos como "d.C."/"a.C." e intervalos de vida

scripts/
  copy-maplibre-worker.mjs   # postinstall: copia o worker do maplibre-gl para public/
  audit-normalized-data.mjs  # auditoria dos dados normalizados no Supabase
  revise-catholic-language.mjs # revisão em lote da linguagem editorial católica
  fetch-wikidata-archdioceses.mjs # coleta e audita o snapshot aberto de arquidioceses/arquieparquias
  generate-archdiocese-migration.mjs # gera a migração idempotente a partir do snapshot

supabase/
  migrations/              # migrações SQL (schema de trajetórias, políticas RLS, perfil/devoção)
  data/                    # snapshots rastreáveis usados por migrações geradas
  inventory/               # snapshots de inventário antes/depois de migrações

database/                  # scripts SQL históricos anteriores à normalização
```

Importante sobre `lib/supabase.ts` vs. `lib/supabaseBrowserClient.ts`/`supabaseServerClient.ts`:
são clientes deliberadamente separados. `lib/supabase.ts` (chave anônima, sem cookies) continua
servindo todo o conteúdo público existente — não altere esses call sites para usar os novos
clientes. Os novos clientes existem só para os fluxos que dependem de sessão (login, perfil,
upload de avatar, salvar `favorite_saint_id`).

## 6. Estrutura real do banco de dados

Estes são os nomes de tabela e campo que o código de fato usa hoje
(confirmado em `app/page.tsx`, `app/saints/[id]/page.tsx` e
`components/*.tsx`). Uma versão anterior deste documento descrevia
tabelas `saints`, `locations`, `journeys`, `historicalEvents`,
`councils`, `religiousOrders`, `saintRelationships` — esses nomes não
existem no schema atual; o texto abaixo os substitui.

- `saints_catalog` — `id`, `name`, `birth_year`, `death_year`,
  `birth_place`, `death_place`, `short_description`, `biography`,
  `feast_day`, `patron_of`, `religious_order`, `famous_quote`.
  Campos da visão de produto ainda não usados no código:
  `canonization_year`, `image_url`, `category`.
- `popes` — `id`, `name`, `start_year`, `end_year`, `description`.
  Campos mais ricos da visão de produto (`birth_name`,
  `pontificate_start/end`, `historical_importance`, `feast_day`,
  `is_saint`, `canonization_year`, `famous_quote`, `image_url`) ainda
  não são lidos pela aplicação.
- `historical_events` — `id`, `year`, `title`, `description`,
  `category` (este campo já é lido e exibido em
  `MapContextPanel.tsx`).
- `timeline_saint_points` — trajetória de um santo: `id`, `saint_id`,
  `location_name`, `latitude`, `longitude`, `start_year`, `end_year`,
  `description`, `sequence_order`, `date_precision`
  (`exact | year | approximate | range | unknown`),
  `historical_certainty`. Substitui a tabela `locations`/`journeys` da
  visão original.
- `map_landmarks` — camada editorial de lugares exibidos na legenda:
  `id`, `place_id` (referencia `places`), `kind`
  (`important_city | episcopal_see | pilgrimage_site`), `title`,
  `description`, `start_year`, `end_year`, `source_url`,
  `is_published`. Possui RLS de leitura pública apenas para registros
  publicados. A view pública `timeline_map_landmarks` junta esses
  registros às coordenadas de `places`; `app/page.tsx` filtra o
  intervalo histórico e entrega os pontos a `SaintsMap.tsx`.
- `ecclesiastical_sources` — catálogo de fontes oficiais/canônicas
  usadas para rastrear os dados da estrutura física e jurisdicional da
  Igreja.
- `ecclesiastical_jurisdictions` — entidades canônicas, incluindo
  Santa Sé, províncias eclesiásticas, arquidioceses, dioceses/eparquias
  e equivalentes latinos/orientais, foranias/vicariatos e paróquias.
  `ecclesiastical_relations` registra relações como metrópole,
  sufragânea e subdivisão; uma província é uma relação/área e não deve
  gerar um ponto cartográfico duplicado.
- `ecclesiastical_sites` — locais físicos ligados às jurisdições:
  sede apostólica, catedral/concatedral, cúria, igreja paroquial,
  capela, santuário e estação missionária. A coluna geográfica PostGIS
  `location`, `min_zoom`, vigência histórica e prioridade de exibição
  alimentam o RPC público `ecclesiastical_points_in_view`, que retorna
  somente os pontos publicados dentro do viewport, do zoom e do ano
  selecionado. A migração
  `20260726213736_add_ecclesiastical_structure.sql` contém o modelo e
  um piloto rastreável de Santa Sé, Brasília e Formosa.
- As migrações `20260726230811_import_global_archdioceses.sql` e
  `20260726231807_sync_global_archdioceses.sql` promoveram 658
  arquidioceses, arquieparquias e patriarcados territoriais ativos do
  snapshot aberto de
  26/07/2026: 543 arquidioceses metropolitanas, 45 arquidioceses não
  metropolitanas, 38 arquieparquias metropolitanas, 29
  arquieparquias e 3 patriarcados territoriais. Cada registro preserva
  identificadores Wikidata,
  Catholic-Hierarchy e GCatholic quando disponíveis em
  `research.ecclesiastical_jurisdiction_identifiers`. As 658 sedes
  estão publicadas no mapa; Brasília reutiliza a jurisdição e a
  catedral já existentes, sem duplicá-las.
- As coordenadas desse lote representam a sede ou a cidade da
  circunscrição e têm `location_accuracy = 'approximate'`. Datas de
  elevação só foram publicadas quando confirmadas por ato da Santa Sé;
  nos demais registros o cadastro representa o estado atual e não deve
  ser interpretado como uma reconstrução histórica completa. A
  migração `20260726231015_fix_ecclesiastical_zoom_threshold.sql`
  garante que os limiares decimais de zoom sejam inclusivos, e
  `20260726231906_promote_patriarchate_zoom.sql` mantém patriarcados no
  mesmo nível visual das estruturas metropolitanas.
- `saint_search_catalog` — usada só para a busca do `TopBar`:
  `id`, `name`, `birth_year`, `death_year`, `short_description`.

### Pesquisa e importação de conteúdo

As migrações `20260726221526_add_content_research_workflow.sql` e
`20260726221833_add_saint_revision_drafts.sql` criam o schema privado
`research` e seu fluxo para separar coleta e revisão dos dados
publicados:

- `research.batches` e `research.batch_sources` organizam lotes e suas
  fontes;
- `research.saint_reviews` mantém o checklist dos 93 santos existentes,
  dividido em lotes de 25, 25, 25 e 18 registros;
- `research.saint_revision_drafts` guarda os valores propostos por campo
  e `research.saint_revision_draft_sources` liga cada proposta às suas
  fontes antes da promoção;
- `research.saint_candidates` recebe novos santos antes da
  deduplicação e promoção;
- `research.ecclesiastical_import_rows` recebe circunscrições e locais
  brutos antes da validação e promoção.
- `research.ecclesiastical_jurisdiction_identifiers` preserva os
  identificadores externos das circunscrições promovidas e a fonte de
  cada identificador.

O schema não concede `USAGE` a `anon`, `authenticated` nem
`service_role` e não deve ser acessado pelo frontend. RLS sem policies
nessas tabelas é intencional: rascunhos não são dados públicos. O fluxo,
os critérios de publicação, as fontes iniciais e as fases continentais
estão em `docs/DATA_RESEARCH.md`; mantenha esse documento sincronizado
com qualquer mudança no processo.

Tabelas da visão de produto que ainda não existem no schema:
`councils`, `religiousOrders`, `saintRelationships`. Não assuma que
elas existem — confira `supabase/migrations/` antes de escrever uma
query contra elas.

### Área de usuário (login, perfil, devoção)

Adicionada em `supabase/migrations/20260726220000_add_user_profiles_and_devotion.sql`.

- `profiles` — `id` (= `auth.users.id`), `display_name`, `avatar_url`,
  `city`, `country`, `favorite_saint_id` (referencia `public.saints`,
  não `saints_catalog`, porque `saints_catalog` é uma view e não pode
  ser alvo de foreign key). **Privada**: RLS só permite ao próprio
  usuário ler/escrever a própria linha (`auth.uid() = id`); não há
  leitura pública desta tabela. Criada automaticamente no primeiro
  login por um trigger em `auth.users` (`handle_new_user`).
- `saint_devotee_counts` — `saint_id`, `devotee_count`. **Pública**
  (`to anon, authenticated using (true)`), mas é uma tabela, não uma
  view sobre `profiles`: uma view `security_invoker` sobre uma tabela
  com RLS por usuário só mostraria a contagem do próprio usuário (0 ou
  1), não o total — por isso a contagem é mantida por trigger
  (`sync_saint_devotee_count`) disparado em insert/update/delete de
  `profiles.favorite_saint_id`. Ao mudar essa lógica, não substitua a
  tabela por uma view sem resolver esse problema de novo.
- Storage: bucket `avatars` (público). Caminho de cada arquivo é
  `<uid>/avatar.<ext>`; políticas em `storage.objects` restringem
  insert/update ao dono via `(storage.foldername(name))[1] = auth.uid()`,
  com select público (a foto é pública por natureza).
- Login: OAuth Google (`signInWithOAuth`) ou e-mail/senha
  (`signUp`/`signInWithPassword`). Microsoft/Azure foi removido — não
  reintroduza sem pedido explícito. Credenciais do provedor Google são
  configuradas no Supabase Dashboard (Authentication → Providers), não
  neste repositório e não em `.env.local`.
- Cadastro por e-mail/senha depende de confirmação por e-mail (padrão
  em projetos hospedados no Supabase): `signUp` não retorna sessão até
  o usuário clicar no link do e-mail. O link precisa apontar para
  `app/auth/confirm/route.ts` (fluxo PKCE, `verifyOtp` com
  `token_hash`) — isso exige editar o template "Confirm signup" em
  Authentication → Email Templates no Supabase Dashboard para usar
  `{{ .SiteURL }}/auth/confirm?token_hash={{ .TokenHash }}&type=email&next={{ .RedirectTo }}`
  no lugar do link padrão. Sem esse ajuste manual no dashboard, a
  confirmação de cadastro por senha não funciona.

### Convenções de dados

- `birth_year` / `death_year` / `year`: inteiros; anos antes de Cristo
  usam número negativo (ver `lib/historicalYear.ts` para formatação
  como "d.C."/"a.C.").
- Anos incertos: `NULL` no banco.
- Todos os textos descritivos em português do Brasil.
- Fontes preferenciais para conteúdo: Vaticano (vatican.va), Catholic
  Encyclopedia, Oxford Dictionary of Popes, ordens religiosas
  oficiais, dioceses, Britannica. Nunca inventar dados históricos.

## Dados e configuração

- Variáveis de ambiente (`.env.local`, ver `.env.example`):
  `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`,
  `NEXT_PUBLIC_MAPTILER_KEY`.
- A linha do tempo navegável vai do marco `0` até o ano civil atual.
  O marco `0` representa a transição a.C./d.C. e agrega no painel
  lateral os fatos anteriores a Cristo por meio da consulta
  `historical_events.year <= 0`; cada card preserva e formata seu ano
  histórico real como `a.C.`. Seleções e preferências persistidas com
  ano negativo são posicionadas no marco `0`, sem perder o contexto do
  fato selecionado.
- O ano selecionado na timeline é persistido em `localStorage`
  (`sancta-historia:selected-year`).
- A legenda do mapa corresponde a camadas reais: santos usam
  marcadores circulares com monograma; cidades importantes, sedes
  episcopais e locais de peregrinação usam símbolos geométricos
  próprios vindos de `timeline_map_landmarks`; rotas históricas
  continuam tracejadas e aparecem ao abrir a trajetória de um santo.
  Durante essa trajetória, os marcos gerais são ocultados para
  preservar a leitura da rota. Sua abertura é controlada pela seta
  central acima da linha do tempo; não há controle duplicado no
  `TopBar`.
- A estrutura eclesiástica também é uma camada real, consultada pelo
  `SaintsMap.tsx` no RPC `ecclesiastical_points_in_view` a cada
  `moveend`. Sedes maiores aparecem primeiro; dioceses e equivalentes
  surgem no zoom regional, e paróquias/capelas apenas no zoom local.
  Seus marcadores têm formas e tamanhos próprios e também são
  ocultados durante a trajetória de um santo. Não carregue todas as
  estruturas globais no cliente nem transforme províncias em pontos.

## 7. Filtros previstos (visão de produto, não implementado)

Por período, categoria e região geográfica.

## 8. Categorias de santos (visão de produto)

Apóstolo, Mártir, Doutor da Igreja, Papa, Fundador, Missionário,
Místico, Religioso, Leigo, Virgem, Bispo, Presbítero. Ainda sem campo
correspondente em `saints_catalog` (ver seção 6).

## 9. Roadmap

1. Timeline
2. Mapa sincronizado
3. 100 santos
4. Eventos mundiais
5. Rotas históricas
6. IA especializada (assistente sobre santos e história da Igreja,
   baseado em fontes autorizadas)
7. Apps móveis

## Diretrizes de conteúdo, código e segurança

Ao analisar:

- Antes de sugerir mudanças, explore a estrutura real de pastas e
  confirme como o projeto está organizado hoje (ver "Estrutura do
  projeto" acima) em vez de assumir a visão de produto como estado
  atual.
- Agrupe problemas por gravidade: crítico, importante, menor.
- Considere sempre: performance, segurança (RLS do Supabase, chaves de
  API expostas, variáveis de ambiente), acessibilidade e boas práticas
  de Next.js/TypeScript.

Ao codar:

- TypeScript com tipagem forte; evite `any`.
- Componentes React funcionais com Hooks.
- Respeite o padrão de cores e a estética do projeto: fundo escuro
  (tons de `#0a0806`/`--ink-950`), dourado/sépia (`--gold-500`
  `#c9a961`, `--gold-300` `#e8cf9a`), tipografia serifada (Cinzel para
  display, Cormorant Garamond para corpo) — ver `app/globals.css`.
- Textos de interface em português do Brasil.
- Não exponha chaves do Supabase no client; use variáveis de ambiente
  e RLS.

Segurança de dados:

- A `service_role key` do Supabase nunca deve aparecer no frontend.
- Toda tabela pública deve ter Row Level Security habilitada com
  policies explícitas.
- Validar entradas antes de inserir no banco.
- A chave do MapTiler vai em `NEXT_PUBLIC_MAPTILER_KEY` (é uma chave
  pública de client, mas restrinja o domínio no painel do MapTiler
  para evitar uso indevido) — ver `components/SaintsMap.tsx`.

O que confirmar antes de agir:

- Se os dados dos santos já vêm do Supabase ou ainda de arrays fixos
  (hoje: Supabase, ver seção 6).
- Antes de mudanças amplas de arquitetura, apresentar o plano e
  aguardar aprovação.

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
- A migração `20260726220000_add_user_profiles_and_devotion.sql`
  (perfil/devoção) foi escrita seguindo as convenções do schema, mas
  **não foi aplicada nem validada contra o projeto Supabase real** —
  não havia CLI do Supabase instalada nem acesso autenticado ao MCP do
  Supabase nesta sessão. Antes de assumir que `profiles` ou
  `saint_devotee_counts` existem no banco de produção, confirme
  rodando a migração e, se possível, `supabase db advisors`.
- Login com Google depende de configuração externa que não está neste
  repositório: credenciais OAuth criadas no Google Cloud Console,
  cadastradas no Supabase Dashboard (Authentication → Providers). Sem
  isso, `signInWithOAuth` em `AuthModal.tsx` falha ao abrir o provedor.
  Cadastro por e-mail/senha depende do template de e-mail apontado
  para `/auth/confirm` (ver seção "Área de usuário" acima).
- Os rótulos da timeline usam duas alturas alternadas e correção de
  alinhamento nos extremos para evitar colisões. Em telas de até
  `720px`, o marcador visual do ano `33` é ocultado por ficar a menos
  de 5 px do marco `0`, mas a era continua disponível na navegação e
  no readout. No eixo, o primeiro rótulo deve ser o compacto `0`, e não
  “Transição a.C./d.C.”. Preserve as classes
  `timeline-tick--staggered`, `timeline-tick--start`,
  `timeline-tick--end` e `timeline-tick--early` ao alterar os marcos.
  O marco moderno inicial é `1545`, “Concílio de Trento”; não restaure
  “Reforma Protestante” como era principal nem como fato autônomo.

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

## Fonte compartilhada de verdade: Codex e Claude Code

Este arquivo é o contrato operacional comum entre os agentes. Codex e
Claude Code devem seguir o mesmo conteúdo, sem manter versões privadas
ou pressupostos incompatíveis sobre o projeto.

1. **Leia o `AGENTS.md` inteiro no início de cada tarefa.** Releia-o se
   o `HEAD` mudar durante o trabalho, pois o outro agente pode ter
   atualizado as diretrizes ou a arquitetura.
2. **Mantenha aqui somente conhecimento estável e verificado:**
   estrutura do projeto, comandos, nomes de variáveis, contratos entre
   componentes, decisões arquiteturais e armadilhas confirmadas.
   Conversas, hipóteses, tarefas temporárias e progresso minuto a
   minuto não pertencem a este arquivo.
3. **Atualize documentação e implementação juntas.** Toda mudança que
   torne uma informação deste arquivo incorreta deve corrigir o
   `AGENTS.md` no mesmo commit da mudança de código. Não registre como
   concluído algo que ainda não existe no repositório.
4. **Em caso de divergência, verifique o estado real.** Código,
   migrações e configuração executável determinam o comportamento
   atual; a solicitação mais recente do usuário determina a intenção.
   Depois de confirmar os fatos, corrija este arquivo para eliminar a
   divergência para o próximo agente.
5. **Faça handoffs por Git, não por memória de conversa.** Ao concluir
   um bloco, commite apenas os próprios arquivos e informe commit,
   arquivos afetados, testes e pendências. O agente que continuar deve
   começar por `git status`, `git log -1` e, quando necessário,
   `git show` do commit recebido.
6. **Não edite em paralelo um arquivo já modificado pelo outro
   agente.** Mudanças não reconhecidas devem ser preservadas. Trabalhe
   em arquivos sem sobreposição ou aguarde um commit/handoff; nunca
   incorpore silenciosamente trabalho alheio ao próprio commit.
7. **Use UTF-8 e linguagem objetiva.** Registre comandos e
   identificadores exatamente como existem, sem incluir segredos,
   caminhos absolutos pessoais ou detalhes específicos de uma única
   máquina.

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
   indefinidamente**, exceto quando o usuário tiver pedido
   explicitamente para manter o projeto disponível. Ao terminar esse
   período, encerre o servidor: ele segura locks de arquivo em
   `node_modules`/`.next` que atrapalham o outro agente ao mover,
   apagar ou reinstalar dependências.
5. **Nunca renomeie, mova ou apague o diretório raiz do projeto** sem
   confirmar com o usuário primeiro, mesmo que a tarefa pedida pareça
   incluir isso — um agente pode ter o diretório antigo como
   `working-dir` fixo, e o rename quebra a sessão dele sem aviso.
