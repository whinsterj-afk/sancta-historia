# Relatório de Análise Técnica — Sancta Historia

**Tipo:** Avaliação somente-leitura (nenhum arquivo de código/config foi alterado para produzir este relatório).
**Data:** 2026-07-26
**Branch analisada:** `transfer-pc-2026-07-25`
**Método:** leitura direta de código-fonte (app/, components/, lib/, supabase/migrations/), testes ao vivo no navegador (viewport mobile 375×812 e tablet 768×1024, console, network) e duas revisões em profundidade por subagentes especializados (uma focada em `app/`+`components/`+`lib/`, outra em `supabase/migrations/`).

**Convenção de severidade usada neste documento:**
- 🔴 **Crítico** — bug ativo, risco de segurança, ou quebra de funcionalidade
- 🟠 **Importante** — não quebra hoje, mas é dívida técnica com custo real (performance, manutenibilidade, acessibilidade)
- 🟡 **Menor** — polimento, consistência, nice-to-have
- 🟢 **Ponto forte** — prática correta, deve ser preservada/replicada

Cada achado inclui arquivo:linha quando aplicável, para permitir verificação rápida antes de agir.

---

## 1. Resumo executivo

O projeto está em bom estado geral: a arquitetura React/Next.js é razoável, as migrações Supabase seguem convenções consistentes (blocos `begin/commit`, comentários em português, `security definer` com `search_path` travado), e há exemplos concretos de acessibilidade bem implementada (`AboutModal.tsx`). Os problemas mais sérios encontrados são:

1. Um **bug de layout mobile real e verificado ao vivo**: o painel de contexto (ao clicar num santo/evento) se sobrepõe parcialmente fora da tela e os painéis "recuados" continuam ocupando espaço no fluxo do documento.
2. **Dois clientes Supabase distintos** (`lib/supabase.ts` anônimo vs. `@supabase/ssr` autenticado) que nunca se veem — hoje inofensivo, mas vai quebrar silenciosamente assim que qualquer query com RLS de usuário for adicionada às páginas públicas.
3. **Modais de autenticação/perfil sem focus trap** (ao contrário do `AboutModal`, que faz isso corretamente) — o modal que lida com credenciais e dados pessoais é o menos acessível do app.
4. Logo do cabeçalho servido em **3840px de largura** para ser exibido a ~225px — desperdício de banda real, mensurável na aba de rede.

Nenhum desses é um incêndio; todos são corrigíveis de forma incremental e local.

---

## 2. Funcionamento (`app/`, `components/`, `lib/`)

### 🔴 Crítico

- **Painel de contexto mobile parcialmente fora da tela.** Verificado ao vivo (viewport 375×812, após selecionar um santo): `[data-map-context-panel]` retorna `getBoundingClientRect()` = `{top: 142, left: -16, width: 351.3, height: 934}`, ou seja, 16px do painel ficam cortados à esquerda da viewport. Ao mesmo tempo, `.leftPanelReceded`/`.rightPanelReceded` (`app/page.module.css`) usam `position: relative` no breakpoint mobile (`@media max-width: 720px`, linha ~1840+) em vez de removerem o elemento do fluxo — então mesmo "recuados" eles continuam ocupando 550px e 605px de altura na página, e o `.contextPanel` (que é `position: absolute`, não trocado para `relative` nesse breakpoint — ver `app/page.module.css:~180-203`) fica desalinhado por cima. Isso explica o `scrollHeight` de 1100px observado (bate com `.page { min-height: 1100px }`) mesmo com conteúdo visualmente incompleto.
  - **Nota de verificação pendente:** um `getComputedStyle` pontual mostrou `transform: matrix(1,0,0,1,0,0)` (identidade) no elemento com classe `leftPanelReceded`, o que contradiz a regra CSS `transform: translateX(-104%)` esperada. Isso pode ser um segundo bug (a transição não é aplicada nesse estado/breakpoint) ou apenas uma leitura tomada num instante de transição. **Recomendo reconfirmar com uma leitura de computed style alguns segundos após o estado mudar**, antes de tratar como fato — mas o problema de sobreposição do painel de contexto em si já está confirmado independentemente disso.
  - **Correção sugerida (não aplicada):** no breakpoint `max-width: 720px`, `.contextPanel` precisa da mesma tratativa de `.leftPanel`/`.rightPanel` (`position: relative`, sem `left` negativo), e os painéis recuados deveriam ir para `display: none` (ou `visibility: hidden` + `position: absolute` fora do fluxo) em vez de só opacidade/transform, para não reservar espaço fantasma.

### 🟠 Importante

- **Dois clientes Supabase que não compartilham sessão.** `lib/supabase.ts` (chave anon + localStorage) é usado em `app/page.tsx`, `components/SaintsMap.tsx` e `app/saints/[id]/page.tsx` para todas as leituras públicas. Os fluxos autenticados usam `@supabase/ssr` via cookies (`lib/supabaseBrowserClient.ts` / `lib/supabaseServerClient.ts`). Hoje isso não quebra nada porque nenhuma query pública depende de RLS de usuário — mas o dia em que alguém adicionar, por exemplo, "destacar meu santo de devoção no mapa" a uma dessas páginas usando `lib/supabase.ts`, a sessão do usuário será invisível e a query vai silenciosamente se comportar como anônima. Vale um comentário no arquivo alertando sobre isso, ou migrar os call sites públicos para o cliente `@supabase/ssr` do lado do browser por consistência.
- **`AuthModal.tsx` instancia `createSupabaseBrowserClient()` duas vezes** (uma em `signInWithGoogle`, outra em `handleSubmit`) em vez de reutilizar uma instância — provável causa do aviso "Multiple GoTrueClient instances" no console.
- **Sem debounce no efeito de busca de dados por ano da timeline** (`app/page.tsx`, efeito ~linhas 131-208), diferente da busca por texto que já tem debounce. Mover o slider rapidamente dispara uma query por frame.
- **`SaintsMap.tsx`: sem debounce no `moveend`** que dispara a RPC de jurisdições eclesiásticas — pan/zoom contínuo pode gerar rajadas de chamadas.
- **Erro genérico único cobrindo 5 falhas de query distintas** em `app/page.tsx` — dificulta diagnosticar qual chamada falhou (santos, eventos, busca, contexto, jurisdições) quando o usuário reporta "deu erro".
- **Uso inconsistente de `useCallback`**: `selectSaint` é memoizado, mas funções irmãs como `selectSuggestion`/`closeContext` não são — inconsistência que não causa bug hoje mas mistura padrões dentro do mesmo arquivo.

### 🟡 Menor

- `MAX_TIMEOUT_DELAY` em `app/page.tsx` (~linha 76-95, auto-reagendamento do calendário para evitar overflow de 32 bits do `setTimeout`, ~24.8 dias) é um número mágico sem comentário explicando o porquê — é sutil o suficiente para merecer uma linha de comentário.
- 4 blocos praticamente idênticos de validação de latitude/longitude em `SaintsMap.tsx` — candidato a uma função utilitária única.
- UUID do estilo MapTiler hardcoded (`SaintsMap.tsx:~270`) sem constante nomeada nem comentário do que é.
- `ecclesiasticalMarkerTier`/`CANONICAL_TYPE_LABELS` (`SaintsMap.tsx:190-233`) não cobrem `patriarchate` nem `major_archiepiscopal_church` — jurisdições desses tipos provavelmente caem num rótulo genérico/errado.
- `lib/catholicEditorial.ts`: `Record` indexado por ID numérico bruto do Supabase, sem slug estável nem comentário `// id N = nome do santo`. Funciona, mas é frágil a reordenação/migração de dados e difícil de auditar a olho.

### 🟢 Pontos fortes

- **`AboutModal.tsx` é o modal implementado corretamente**: focus trap completo (Tab/Shift+Tab), Escape para fechar, scroll lock com restauração do `overflow` anterior, restauração de foco ao elemento previamente focado, uso de `useEffectEvent` (API nova do React) para evitar recriar o listener a cada render. Deveria ser o template para `AuthModal`/`ProfileModal`.
- **Ciclo de vida do mapa em `SaintsMap.tsx` está correto**: instância única, `.remove()` no cleanup (~linha 279), cada efeito de marcador limpa seus próprios marcadores, `prefers-reduced-motion` respeitado de forma consistente em todas as animações.
- Persistência do ano selecionado em `localStorage` é simples e funciona sem estado extra de carregamento perceptível.

---

## 3. Responsividade

| Breakpoint | Fonte | Observação |
|---|---|---|
| `max-width: 980px` | `globals.css:1796` | não testado ao vivo nesta rodada |
| `max-height: 680px and min-width: 721px` | `globals.css:1816` | caso de tela curta/desktop — não testado ao vivo |
| `max-width: 720px` (mobile) | `globals.css:1840`, `page.module.css` | **testado ao vivo — bug confirmado, ver seção 2** |
| `prefers-reduced-motion: reduce` | `globals.css:2050` | respeitado consistentemente no mapa |

- 🔴 Ver bug do painel de contexto mobile (seção 2).
- 🟠 **Viewport tablet (768×1024) não foi verificado a fundo nesta análise** — o resize foi feito e a lista de requisições de rede foi inspecionada (nada anormal: chunks Next.js/Turbopack, fontes, worker do MapLibre, todos 200/304), mas a árvore de acessibilidade e os estilos computados no breakpoint tablet não foram reinspecionados após o resize. Recomendo uma passada dedicada nesse breakpoint antes de considerar a responsividade tablet validada.
- 🟠 **Logo do cabeçalho sobredimensionada.** Requisição de rede observada: `GET /_next/image?url=%2Fsancta-historia-logo.png&w=3840&q=75`. O componente `next/image` em `components/TopBar.tsx:84-96` recebe `width={2121} height={3000}` (dimensão intrínseca do arquivo) mas nenhum atributo `sizes`, e é exibido via CSS a apenas `225px` de largura (`style={{ width: 225, ... }}`). Sem `sizes`, o Next.js escolhe o maior breakpoint de `deviceSizes` configurado, resultando no download de uma imagem ~17x maior que o necessário. Correção sugerida (não aplicada): adicionar `sizes="225px"` (ou o valor real renderizado) à tag `<Image>`.
- `app/page.module.css` mobile: `.leftPanel`/`.rightPanel` corretamente convertidos para `position: relative` no breakpoint mobile — só `.contextPanel` ficou de fora dessa conversão (ver seção 2).
- Página `/saints/[id]` não foi testada ao vivo nesta rodada de análise — recomenda-se verificação dedicada, especialmente da responsividade do grid de duas colunas mencionado no plano de contador de devotos.

---

## 4. Organização e Arquitetura

### 🟠 Importante

- **Três fábricas de cliente Supabase** (`lib/supabase.ts`, `lib/supabaseBrowserClient.ts`, `lib/supabaseServerClient.ts`) sem um comentário central explicando quando usar cada uma — ver risco de dessincronia de sessão na seção 2.
- **`app/globals.css` é um arquivo monolítico de 2059 linhas**, sem `@layer` nem divisão por componente/domínio. Não é um bug, mas dificulta localizar regras (os 20 `!important` no arquivo, concentrados nas linhas ~1793-2030, são sintoma disso: provavelmente compensando especificidade perdida em meio ao tamanho do arquivo).
- **`AGENTS.md` tem pequena divergência da realidade do repo**: referencia um diretório `database/` que ainda existe fisicamente mas é histórico (pré-normalização, já documentado como tal no próprio arquivo — ok), porém não menciona 2 scripts mais novos em `scripts/` (`audit-normalized-data.mjs`, `revise-catholic-language.mjs` — na verdade já estão listados, então isso é uma correção **menor**, verificar se algum script novo desde a última atualização ficou de fora) e não documenta o schema interno `research` usado pelo fluxo de conteúdo (`add_content_research_workflow` migration). Vale uma atualização pontual.

### 🟡 Menor

- `BottomNav.tsx` existe mas não é montado em nenhuma página (isso já é uma regra documentada e intencional em `AGENTS.md` — apenas confirmando que a regra está sendo seguida, não é uma pendência).

---

## 5. Layout, Acessibilidade e Design

### 🟠 Importante

- **`AuthModal.tsx` e `ProfileModal.tsx` não têm focus trap, Escape-to-close nem restauração de foco**, ao contrário de `AboutModal.tsx`. Isso é o achado de acessibilidade mais consequente do projeto: são exatamente os modais que lidam com credenciais e dados pessoais (login, senha, foto, cidade/país, santo de devoção), e são os menos protegidos contra navegação por teclado ficar "vazando" para trás do modal.
  - **Correção sugerida (não aplicada):** extrair a lógica de `AboutModal.tsx:10-58` (focus trap + scroll lock + restauração de foco) para um hook compartilhado (ex: `useModalA11y(dialogRef, onClose)`) e aplicá-lo aos três modais.
- `pointer-events: none` como padrão em `.hero-header` (`globals.css`) exige que todo novo elemento dentro do `TopBar` (modais, popovers) declare `pointer-events: auto` explicitamente — já documentado como armadilha conhecida em `AGENTS.md`; confirmar que `AuthModal`/`ProfileModal`/`AboutModal` de fato o fazem (não verificado diretamente nesta análise, mas como os modais funcionam clicáveis na prática, provavelmente já herdam corretamente via seus próprios backdrops de tela cheia).

### 🟢 Pontos fortes

- `AboutModal.tsx` usa `role="dialog"`, `aria-modal="true"`, `aria-labelledby`, `aria-describedby` corretamente.
- `TopBar.tsx` usa `role="combobox"`/`aria-expanded`/`aria-controls`/`role="listbox"`/`role="option"` no campo de busca — padrão ARIA combobox aplicado corretamente.
- `AboutModal` foi propositalmente redesenhado de um simples "Sobre" para um manifesto de boas-vindas ("UM CONVITE À SANTIDADE") — mudança de produto, não um bug; nota-se que `aboutOpen` inicia `true` em todo mount de `TopBar` (linha 33), ou seja, o modal aparece a cada carregamento/refresh da página sem persistência de "já vi isso" — **provavelmente intencional dado o novo tom de manifesto de boas-vindas**, mas vale confirmar com o usuário se esse é o comportamento desejado a longo prazo (ex: usuários recorrentes veem o manifesto toda vez).

---

## 6. Banco de dados / Migrações Supabase

### 🟠 Importante

- **Duas migrações sem bloco `begin;/commit;`**: `20260726215243_replace_reformation_with_council_of_trent.sql` e `20260726221526_add_content_research_workflow.sql` — todas as outras migrações do projeto usam esse padrão; essas duas são a exceção, o que significa que uma falha no meio da migração não dá rollback automático.
- **Duas correções sucessivas na mesma função em uma sessão**: `ecclesiastical_points_in_view()` foi corrigida três vezes (`20260726213736` cria, `20260726214258` e `20260726231015` corrigem bounds/zoom) — não é um problema em si (iteração é normal), mas sinaliza que a função pode se beneficiar de testes automatizados antes do merge, já que os bugs só apareceram depois de aplicada.
- **Duas migrações de ~340KB cada misturando schema e dados** (`20260726230811_import_global_archdioceses.sql`, `20260726231807_sync_global_archdioceses.sql`) — funcional, mas migrações desse tamanho são difíceis de revisar linha a linha em code review; strategy comum é separar schema (migração) de seed de dados (script/seed separado).

### 🟢 Pontos fortes

- Convenções consistentes: nomes de arquivo `YYYYMMDDHHMMSS_snake_case`, comentários em português explicando o "porquê", trigger `set_updated_at()` reaproveitado, `security definer` sempre com `search_path` travado.
- `20260726210000_retire_legacy_geography.sql` é um exemplo exemplar de DDL destrutivo feito com segurança (documentado no relatório do subagente como modelo a seguir para futuras remoções de coluna/tabela).
- A migração `20260726234500_add_parishes_and_profile_link.sql` (aplicada nesta mesma sessão) reaproveita `ecclesiastical_jurisdictions` em vez de criar um catálogo de paróquias duplicado, evitando duas fontes de verdade — decisão correta e já documentada no comentário da coluna.
- Checklist de segurança do Supabase (RLS, `WITH CHECK` em updates, `security definer` com escopo mínimo) foi seguido nas migrações de perfil/devoção escritas nesta sessão.

---

## 7. Lista priorizada de próximos passos (sugestão, nada aplicado)

1. 🔴 Corrigir `.contextPanel` no breakpoint mobile (`page.module.css`, `max-width: 720px`) para não ficar parcialmente fora da tela; trocar painéis "recuados" para saírem do fluxo do documento em vez de só opacidade/transform.
2. 🟠 Adicionar `sizes="225px"` ao `<Image>` do logo em `TopBar.tsx` — ganho de performance imediato e de baixo risco.
3. 🟠 Extrair o hook de acessibilidade de `AboutModal.tsx` e aplicá-lo em `AuthModal.tsx`/`ProfileModal.tsx`.
4. 🟠 Decidir e documentar (comentário de código) a estratégia definitiva para dessincronia entre `lib/supabase.ts` e os clientes `@supabase/ssr`, antes que uma query com RLS de usuário seja adicionada às páginas públicas.
5. 🟡 Debounce no efeito de busca por ano (`page.tsx`) e no `moveend` do mapa (`SaintsMap.tsx`).
6. 🟡 Reunificar instância do Supabase browser client dentro de `AuthModal.tsx`.
7. 🟡 Envolver as duas migrações sem `begin/commit` em transação, para consistência com o resto do histórico (só relevante para migrações futuras — as já aplicadas em produção não devem ser reescritas retroativamente).

---

*Fim do relatório. Nenhum arquivo de código, estilo ou configuração foi modificado durante esta análise — apenas leitura e testes de verificação ao vivo no navegador.*
