---
report_type: deep_project_audit
project: sancta-historia
language: pt-BR
generated_at: 2026-07-26
audited_git_commit: 180d17d
audit_mode: read_only
database_checked: true
database_platform: Supabase
runtime_checked: local_development_server
confidence: high
status: final
---

# Auditoria profunda do projeto Sancta Historia

## 1. Resumo executivo

O Sancta Historia já tem uma identidade visual forte e uma proposta de produto
clara: mapa, linha do tempo, santos, papas, fatos e estrutura da Igreja formam
uma experiência coerente. A arquitetura de dados também avançou além de um
protótipo: há RLS, views `security_invoker`, separação do fluxo de pesquisa,
rastreabilidade planejada e uma RPC geoespacial com filtragem por viewport e
zoom.

O projeto, porém, ainda não está pronto para ser tratado como produção madura.
Os riscos principais não estão na estética, mas em quatro fundamentos:

1. **segurança imediata** — Next.js 16.2.9 possui vulnerabilidades conhecidas
   corrigidas em patch disponível; a confirmação de e-mail aceita redirecionamento
   absoluto externo; o bucket de avatares não limita tamanho ou MIME;
2. **correção histórica** — 647 estruturas eclesiásticas atuais aparecem no mapa
   inclusive no ano 0 em zoom 4.5+, pois a vigência histórica da maior parte do
   lote mundial não foi verificada;
3. **confiabilidade operacional** — não há testes automatizados, o comando oficial
   de lint está contaminado por arquivos gerados/worktrees e o histórico remoto
   de migrações não corresponde à cadeia de arquivos do repositório;
4. **escala e manutenção** — `app/page.tsx`, `components/SaintsMap.tsx` e
   `app/globals.css` concentram responsabilidades, cada movimento anual do slider
   dispara cinco consultas e marcadores cartográficos são elementos DOM recriados.

Avaliação global: **3,1/5 — produto promissor e funcional, com boa fundação
visual e de domínio, mas com dívidas de segurança, temporalidade, testes e
reprodutibilidade que devem preceder expansão acelerada de conteúdo.**

## 2. Escopo e método

### 2.1 Escopo coberto

- funcionamento da página inicial e da página de santo;
- mapa, linha do tempo, busca, painéis, autenticação e perfil;
- responsividade por inspeção de layout, breakpoints e unidades de viewport;
- acessibilidade semântica e de teclado por inspeção;
- arquitetura Next.js/React e organização do código;
- Supabase: tabelas, views, funções, RLS, grants, Storage, Advisors e migrações;
- qualidade e cobertura do conteúdo publicado;
- desempenho previsível no navegador e no banco;
- segurança de dependências, autenticação, redirecionamentos e uploads;
- documentação, scripts, lint, TypeScript, HTTP e capacidade de manutenção.

### 2.2 Evidências executadas

| Verificação | Resultado |
| --- | --- |
| `npx tsc --noEmit` | aprovado, código 0 |
| `npx eslint app components lib proxy.ts scripts` | aprovado, código 0 |
| `npm run lint` | reprovado operacionalmente: 8.647 ocorrências, quase todas em `.claude/worktrees/**/.next` e worker gerado |
| `npm audit --omit=dev --json` | reprovado: 3 pacotes de produção classificados como `high`; correção disponível via Next.js 16.2.12 |
| `GET /` | 200, 24.561 bytes |
| `GET /saints/1` | 200, 37.853 bytes |
| `GET /saints/not-a-number` | 200, embora represente recurso inexistente |
| Supabase Security Advisor | 18 avisos: 12 `INFO`, 6 `WARN` |
| Supabase Performance Advisor | 19 avisos `INFO` |
| catálogo e políticas ao vivo | inspecionados somente por SQL de leitura |

### 2.3 Limitações

- Não foi executado `next build`, para não disputar a pasta `.next` com o
  servidor de desenvolvimento que deve permanecer disponível.
- A conexão de automação visual do navegador não estava disponível. Portanto,
  a avaliação responsiva é baseada em CSS, estrutura React e respostas HTTP,
  não em comparação pixel a pixel em dispositivos reais.
- Não foi realizado login real, OAuth ou upload de arquivo, para não alterar
  estado de usuário ou Storage.
- Não foram executadas migrações, DDL, escrita no banco ou alterações de código.
- A única alteração no projeto produzida por esta auditoria é este relatório.

## 3. Mapa do sistema

```text
app/layout.tsx
├── metadados globais e fontes
├── app/page.tsx (Client Component)
│   ├── Supabase público (consultas por ano)
│   ├── TopBar
│   │   ├── busca
│   │   ├── AboutModal
│   │   ├── AuthModal
│   │   └── ProfileModal
│   ├── SaintsMap (MapLibre + MapTiler + RPC Supabase)
│   ├── FactsPanel
│   ├── SaintsPanel
│   ├── MapContextPanel
│   └── Timeline + MapLegend
├── app/saints/[id]/page.tsx (Server Component)
└── app/auth/{callback,confirm}/route.ts

Supabase
├── public.*: conteúdo publicado, perfis, contadores e estruturas
├── research.*: staging e revisão, fora da API pública
├── storage.avatars: bucket público
└── ecclesiastical_points_in_view(...): RPC por viewport, zoom e ano
```

## 4. Pontuação por área

| Área | Nota | Leitura |
| --- | ---: | --- |
| Proposta e identidade visual | 4,5/5 | distintiva, coerente e emocionalmente alinhada |
| Funcionalidade atual | 3,7/5 | fluxo principal funciona; alguns comportamentos comunicam mais do que persistem |
| Layout desktop | 4,1/5 | composição forte e boa hierarquia |
| Responsividade | 3,0/5 | adaptações existem, mas dependem de alturas/posições rígidas |
| Acessibilidade | 2,7/5 | bons detalhes isolados, modais e comboboxes incompletos |
| Arquitetura frontend | 3,1/5 | moderna, porém concentrada e excessivamente client-side |
| Banco e modelagem | 3,8/5 | bom desenho e RLS; migrações e cobertura temporal exigem correção |
| Segurança | 2,4/5 | há defesas boas, mas três riscos prioritários verificáveis |
| Desempenho e escala | 2,9/5 | adequado ao volume atual; estratégia não escala para paróquias mundiais |
| Conteúdo e rastreabilidade | 2,8/5 | processo bem documentado, execução ainda incompleta |
| Testes e operação | 2,2/5 | ausência de suíte e lint oficial inutilizável |
| Documentação | 3,8/5 | `AGENTS.md` e pesquisa são fortes; README e onboarding estão defasados |

## 5. Pontos fortes

### 5.1 Produto, layout e experiência

- A paleta, tipografia, transparências, mapa escurecido e ouro criam uma
  identidade própria; não parece um painel administrativo genérico.
- A abertura em formato de manifesto é visualmente e semanticamente consistente
  com o objetivo pastoral do produto.
- A composição desktop usa bem as bordas: fatos à esquerda, santos à direita,
  timeline abaixo e mapa como plano central.
- A legenda integrada à timeline reduz ocupação permanente do mapa.
- O contexto de um santo recua os painéis laterais e reposiciona a câmera,
  preservando a relação entre narrativa e geografia.
- A rota ciano com contorno escuro tem contraste mais robusto sobre o mapa
  (`components/SaintsMap.tsx:685-706`).

### 5.2 Responsividade e movimento

- Há breakpoints específicos em 980 px e 720 px, além de tratamento para telas
  baixas (`app/globals.css:1796-1997`).
- O modal Sobre troca a grade de três colunas por uma coluna em telas estreitas.
- `100svh` e `100dvh` são usados onde ajudam a lidar com barras móveis.
- A câmera calcula padding com base nos painéis reais e limita a área mínima
  visível do mapa (`components/SaintsMap.tsx:48-112`).
- O projeto respeita `prefers-reduced-motion`, tanto no CSS quanto nas animações
  do mapa (`app/globals.css:2050-2058`).

### 5.3 Acessibilidade já presente

- Foco visível global para botões, inputs e links (`app/globals.css:45-50`).
- O modal Sobre tem `role="dialog"`, `aria-modal`, título/descrição associados,
  Escape, foco inicial, armadilha de Tab e restauração do foco
  (`components/AboutModal.tsx:8-77`).
- Marcadores do mapa são botões reais e recebem `aria-label`.
- A timeline expõe `aria-valuetext` com ano e período.
- Estados de carregamento/erro usam regiões vivas em pontos importantes.
- `textContent`/`setDOMContent` são usados nos popups do mapa, evitando injeção
  de HTML por conteúdo do banco.

### 5.4 Banco e segurança estrutural

- Todas as tabelas de aplicação verificadas têm RLS habilitado.
- As cinco views públicas usam `security_invoker=true`, portanto respeitam as
  políticas das tabelas de origem.
- `profiles` aplica corretamente `(select auth.uid())` e permite ler/escrever
  apenas a própria linha.
- O schema `research` está separado do conteúdo servido ao frontend e modela
  lotes, revisão, fontes e promoção.
- A RPC cartográfica é `security invoker`, fixa `search_path=''`, valida
  publicação, ano, zoom e envelope geográfico, e limita a 750 linhas
  (`supabase/migrations/20260726213736_add_ecclesiastical_structure.sql:188-276`).
- O frontend descarta respostas cartográficas obsoletas com contador de
  requisição (`components/SaintsMap.tsx:508-540`).
- Índices geoespaciais e de chaves estrangeiras importantes foram criados.

### 5.5 Organização de domínio

- A normalização separa santos, aliases, lugares e pontos de trajetória.
- Trajetória de vida é distinguida de relíquias e culto póstumo.
- O documento `docs/DATA_RESEARCH.md` define um funil editorial prudente, com
  preferência por fontes oficiais e revisão humana.
- `AGENTS.md` é uma fonte compartilhada de verdade excepcionalmente detalhada e
  reduz risco de incompatibilidade entre Codex e Claude Code.

## 6. Achados prioritários

Escala de severidade:

- **Crítica**: risco imediato de segurança, perda ou quebra sistêmica;
- **Alta**: compromete confiança, correção central ou evolução segura;
- **Média**: degrada UX, manutenção ou desempenho de forma relevante;
- **Baixa**: melhoria incremental, limpeza ou refinamento.

| ID | Severidade | Área | Achado |
| --- | --- | --- | --- |
| SEC-01 | Alta | Dependências | Next.js 16.2.9 está dentro de faixas vulneráveis; patch 16.2.12 disponível |
| SEC-02 | Alta | Auth | confirmação de e-mail permite redirecionamento absoluto para domínio externo |
| HIST-01 | Alta | Correção histórica | 647 estruturas atuais aparecem inclusive no ano 0 em zoom 4.5+ |
| OPS-01 | Alta | Banco/operação | cadeia local de 20 migrações não corresponde às 14 migrações registradas no projeto remoto |
| QUAL-01 | Alta | Qualidade | não existe suíte automatizada de testes |
| FUNC-01 | Alta | Produto | botão “favorito” dos cards de santos é somente estado local e desaparece ao recarregar |
| SEC-03 | Alta | Storage | avatares sem limite de tamanho/MIME e bucket público listável |
| PERF-01 | Média | Frontend/banco | cada passo do slider dispara cinco consultas e usa `select("*")` |
| DATA-01 | Alta | Conteúdo | 0 citações vinculadas, 29 biografias ausentes e 93 imagens ausentes entre 93 santos |
| DATA-02 | Média | Governança | correções editoriais por IDs numéricos vivem no bundle, fora do fluxo de pesquisa |
| A11Y-01 | Alta | Acessibilidade | AuthModal e ProfileModal não implementam semântica/comportamento de diálogo |
| A11Y-02 | Média | Acessibilidade | comboboxes não oferecem navegação completa por teclado |
| RESP-01 | Média | Responsividade | mobile depende de página mínima fixa de 1100 px e timeline fixa |
| PERF-02 | Média | Escala do mapa | marcadores são DOM; a estratégia não comportará paróquias mundiais |
| SEO-01 | Média | SEO/HTTP | santo inexistente retorna 200; páginas não têm metadados específicos |
| DX-01 | Média | Ferramentas | `npm run lint` varre `.claude/worktrees` e artefatos públicos gerados |
| MAINT-01 | Média | Organização | três arquivos centrais concentram grande parte da complexidade |
| DATA-03 | Média | Integridade | banco não garante que `favorite_parish_id` aponte para paróquia |
| SEC-04 | Média | Banco | duas funções `SECURITY DEFINER` de trigger podem ser executadas diretamente por papéis públicos |
| AUTH-01 | Média | Auth | proteção contra senhas vazadas está desabilitada |
| DOC-01 | Baixa | Onboarding | README está defasado e não existe `.env.example` |
| REPO-01 | Baixa | Repositório | imagens públicas não utilizadas somam aproximadamente 3,26 MB |

## 7. Detalhamento dos achados

### SEC-01 — dependência Next.js vulnerável

**Evidência verificada:** `package.json` fixa `next: 16.2.9`. Em 26/07/2026,
`npm audit --omit=dev` encontrou três dependências de produção em severidade
alta (`next`, `postcss` transitivo e `sharp` transitivo) e ofereceu atualização
sem quebra semântica para Next.js 16.2.12.

**Impacto:** o conjunto inclui bypass de Proxy, negação de serviço e outras
falhas no intervalo instalado. Nem todas as variantes são necessariamente
exploráveis nesta aplicação, mas o Proxy é usado para sessão Supabase, então o
bypass merece prioridade.

**Recomendação:** atualizar o patch, reinstalar lockfile, executar build,
autenticação e regressão das rotas. Referência:
[GitHub Advisory GHSA-6gpp-xcg3-4w24](https://github.com/advisories/GHSA-6gpp-xcg3-4w24).

### SEC-02 — redirecionamento externo após confirmação

**Evidência:** `resolveRedirect()` retorna diretamente `new URL(target)` para
qualquer URL absoluta (`app/auth/confirm/route.ts:19-24`) e o resultado alimenta
`NextResponse.redirect` após OTP válido (`app/auth/confirm/route.ts:38`).

**Impacto:** um link de confirmação legítimo pode terminar em domínio controlado
por terceiro, facilitando phishing e quebra de confiança.

**Recomendação:** aceitar apenas caminhos relativos iniciados por `/` e/ou
validar que `url.origin === request.nextUrl.origin`. Aplicar a mesma função de
validação ao callback OAuth, hoje montado por concatenação
(`app/auth/callback/route.ts:5-14`).

### HIST-01 — mapa contemporâneo exibido como histórico

**Evidência de produção:** consulta read-only à RPC global:

```sql
select z, y, count(*)
from (values (2.5::float8), (4.5::float8), (6::float8)) zooms(z)
cross join (values (0), (33), (400), (1054), (1545), (1917), (2026)) years(y)
cross join lateral public.ecclesiastical_points_in_view(
  -180, -90, 180, 90, z, y
) p
group by z, y;
```

Resultado relevante:

- zoom 2.5: 1 ponto em todos os anos;
- zoom 4.5: **647 pontos no ano 0**, 647 em 33, 400, 1054, 1545 e 1917;
- zoom 4.5 em 2026: 659 pontos.

O próprio documento de pesquisa registra que o lote mundial é um “cadastro
mundial atual, não uma reconstrução completa” (`docs/DATA_RESEARCH.md`). Na RPC,
`erected_year is null` permite a entidade em qualquer ano
(`...add_ecclesiastical_structure.sql:233-246`).

**Impacto:** o usuário pode interpretar arquidioceses modernas como existentes
na Igreja apostólica ou medieval. Isso atinge o núcleo intelectual do produto.

**Recomendação:** separar explicitamente “estrutura atual” de “estrutura
historicamente válida”. Até haver datas verificadas, uma opção conservadora é
mostrar o lote contemporâneo apenas no ano atual ou sob camada claramente
rotulada como atual. Não inferir datas de elevação a partir de Wikidata sem
revisão.

### OPS-01 — histórico de migrações não reproduz o banco

**Evidência:**

- repositório: 20 arquivos `.sql`;
- Supabase remoto: 14 migrações registradas;
- versões iniciais remotas (`20260726193457`,
  `20260726193626`) não correspondem aos nomes/versões locais;
- migrações locais de perfil e paróquia não aparecem no histórico remoto,
  embora as colunas/tabelas existam no schema ao vivo.

**Impacto:** `db reset`, bootstrap de ambiente, branch de banco e auditoria podem
produzir um schema diferente de produção. O risco cresce a cada nova migração.

**Recomendação:** produzir um baseline reconciliado, documentar quais migrações
foram aplicadas manualmente/renomeadas e testar reconstrução em branch descartável
antes do próximo lote estrutural.

### QUAL-01 — ausência de testes

**Evidência:** `package.json` não possui script `test`; não há arquivos de teste
do projeto. A presença opcional de Playwright no lockfile vem de dependência, não
de uma suíte configurada.

**Impacto:** mudanças na timeline, filtros por ano, RLS, redirects e mapa podem
regredir silenciosamente. A colaboração paralela entre agentes aumenta esse
risco.

**Recomendação mínima:** testes unitários para anos/editoriais; testes de
integração das consultas e redirects; E2E para abertura, timeline, busca, santo,
login/perfil e breakpoints; teste SQL/RLS com anon e authenticated.

### FUNC-01 — “favoritos” não persistem

**Evidência:** `SaintsPanel` mantém `saved` em um `useState<Set<number>>`
(`components/SaintsPanel.tsx:31-40`). Não usa Supabase, perfil nem
`localStorage`.

**Impacto:** o ícone e os rótulos “Adicionar aos favoritos” comunicam persistência,
mas a seleção é perdida ao desmontar ou recarregar. Existe ainda o conceito
separado de “santo de devoção” no perfil, criando ambiguidade de produto.

**Recomendação:** decidir se são conceitos distintos. Se favorito for recurso
real, modelar relação usuário-santo; se não, remover ou renomear a interação.

### SEC-03 — upload de avatar sem limites

**Evidência combinada:**

- bucket `avatars`: `public=true`, `file_size_limit=null`,
  `allowed_mime_types=null`;
- input aceita `image/*` e o cliente envia o arquivo sem validação de tamanho
  (`components/ProfileModal.tsx:187-207`, `:284`);
- Security Advisor: `public_bucket_allows_listing`;
- extensões diferentes permitem múltiplos caminhos `avatar.<ext>` por usuário;
- não existe política de exclusão do próprio arquivo.

**Impacto:** abuso de armazenamento e banda por usuários autenticados, arquivos
inesperados e acúmulo de versões. A listagem pública expõe os nomes dos objetos.

**Recomendação:** limitar tamanho e MIME no bucket, validar novamente no cliente,
normalizar formato/nome, remover a política ampla de listagem quando URLs públicas
bastarem e definir ciclo de substituição/remoção.

### PERF-01 — slider gera rajadas de consultas

**Evidência:** o `input[type=range]` chama `onChange` a cada movimento
(`components/Timeline.tsx:190-195`). Toda alteração de `year` executa um
`Promise.all` com cinco consultas e `select("*")`
(`app/page.tsx:128-205`).

**Impacto:** arrastar de 0 a 2026 pode criar muitas requisições concorrentes,
transferir colunas não usadas e fazer a interface oscilar em redes móveis. O
flag `active` impede aplicar respostas antigas, mas não cancela tráfego já
enviado.

**Recomendação:** separar valor visual transitório de ano confirmado, aplicar
debounce/throttle, abortar requisições quando suportado, selecionar somente
colunas usadas e considerar uma RPC agregadora por ano.

### DATA-01 — rastreabilidade planejada, mas ainda vazia

**Métricas ao vivo:**

| Métrica | Valor |
| --- | ---: |
| santos publicados | 93 |
| santos sem biografia | 29 |
| santos sem imagem | 93 |
| pontos de trajetória | 151 |
| pontos com lugar sem coordenada | 0 |
| fontes de pesquisa cadastradas | 13 |
| citações vinculadas a santos | 0 |
| citações vinculadas a trajetórias | 0 |
| papas | 295 |
| fatos históricos | 69 |

**Impacto:** o contrato editorial exige ao menos uma fonte para publicação, mas
o catálogo atual antecede esse processo. A UI não diferencia texto verificado,
tradição, hipótese e lacuna de fonte.

**Recomendação:** concluir o primeiro lote dos 93 antes de ampliar agressivamente;
exibir proveniência/certidão histórica no produto; medir cobertura como gate de
publicação.

### DATA-02 — segunda fonte de verdade editorial

**Evidência:** `lib/catholicEditorial.ts` substitui campos de santos, eventos e
locais por IDs fixos e é aplicado tanto na home quanto na página de santo.

**Impacto:** banco, pesquisa e frontend podem discordar; IDs são frágeis entre
ambientes; consultas externas ao app não veem a correção; o bundle cresce com
conteúdo.

**Recomendação:** promover revisões aprovadas ao banco com citações. Manter no
código apenas regras de apresentação, não conteúdo canônico.

### A11Y-01 — modais de conta incompletos

**Evidência:** `AuthModal` e `ProfileModal` renderizam backdrops fixos
(`components/AuthModal.tsx:86-94`,
`components/ProfileModal.tsx:244-251`), mas não possuem:

- `role="dialog"` e `aria-modal="true"`;
- nome acessível associado;
- foco inicial e armadilha de foco;
- fechamento por Escape;
- bloqueio/restauração do scroll;
- restauração do foco ao botão que abriu.

**Impacto:** leitores de tela e usuários de teclado podem navegar pelo mapa atrás
do modal ou perder o contexto.

**Recomendação:** extrair um componente de diálogo reutilizável a partir da
implementação já correta de `AboutModal`.

### A11Y-02 — comboboxes incompletos

**Evidência:** a busca principal usa `role="combobox"`/`listbox`, mas não gerencia
opção ativa, `aria-activedescendant`, setas, Enter ou Home/End
(`components/TopBar.tsx:100-151`). Os campos de santo/paróquia no perfil nem
associam formalmente o texto visível ao input.

**Recomendação:** implementar padrão ARIA de combobox ou usar componente
testado; manter o mouse como alternativa, não como fluxo principal.

### RESP-01 — layout móvel rígido

**Evidência:** em até 720 px, `.page` recebe `min-height: 1100px` e
`overflow-y:auto`; a timeline vira `position:fixed`
(`app/page.module.css:151-178`). A busca usa 46 vw
(`app/globals.css:1910-1925`).

**Impacto:** grande área rolável mesmo em conteúdos curtos, timeline cobrindo
conteúdo/teclado virtual e comportamento irregular em landscape ou aparelhos
baixos. Há mitigação por padding, mas ela é fixa.

**Recomendação:** validar pelo menos 320×568, 360×800, 390×844, 768×1024,
1024×768 e landscape; preferir layout em regiões/stacks cuja altura derive do
viewport e conteúdo.

### PERF-02 — estratégia cartográfica não escala a paróquias

**Evidência:** cada entidade vira um `Marker` DOM com botão e popup
(`components/SaintsMap.tsx:543-606`). A RPC limita 750 resultados
(`...add_ecclesiastical_structure.sql:257-258`), sem sinalizar truncamento ao
cliente.

**Impacto:** com milhares de dioceses e potencialmente centenas de milhares de
paróquias, regiões densas podem omitir pontos e o DOM ficará caro.

**Recomendação:** antes do lote mundial de paróquias, migrar estruturas de volume
para source/layers GeoJSON ou tiles vetoriais com clustering, paginação espacial
ou agregação por zoom. Reservar markers DOM para seleção/destaque.

### SEO-01 — semântica HTTP e metadados

**Evidência:**

- `/saints/not-a-number` responde 200 e mostra “Santo não encontrado”
  (`app/saints/[id]/page.tsx:30-54`);
- só há metadata global genérica (`app/layout.tsx:18-21`);
- não há `generateMetadata`, `not-found.tsx`, sitemap, robots, Open Graph ou
  metadata por santo.

**Impacto:** indexação incorreta, resultados de busca pouco informativos e
compartilhamentos sem contexto.

**Recomendação:** validar ID, chamar `notFound()`, gerar título/descrição por
santo e adicionar metadados sociais/canônicos.

### DX-01 — lint oficial sem isolamento

**Evidência:** `eslint.config.mjs` ignora `.next`, mas não
`.claude/worktrees/**`, `public/maplibre-gl-*.mjs` ou outros artefatos gerados.
`npm run lint` levou cerca de dois minutos e reportou 294 erros + 8.353 avisos.
O lint limitado ao código-fonte passou sem ocorrências.

**Impacto:** o comando não serve como gate de CI e oculta erros reais em ruído.

**Recomendação:** ampliar ignores ou limitar o script aos diretórios de fonte.

### MAINT-01 — concentração de responsabilidades

| Arquivo | Tamanho aproximado | Responsabilidades concentradas |
| --- | ---: | --- |
| `app/globals.css` | mais de 2.000 linhas físicas | tokens, mapa, modais, painéis, timeline, popups, responsividade |
| `components/SaintsMap.tsx` | 767 linhas | inicialização, câmera, cinco tipos de marker, RPC, rota, popups |
| `app/page.tsx` | 494 linhas físicas | calendário, persistência, cinco datasets, busca, seleção e contexto |
| `components/ProfileModal.tsx` | 477 linhas físicas | perfil, duas buscas, upload, persistência e sessão |

**Impacto:** conflitos entre agentes, regressões laterais e revisão difícil.

**Recomendação:** extrair hooks por domínio, tipos gerados do Supabase,
componentes de diálogo/combobox e módulos CSS por região, mantendo contratos
claros no `AGENTS.md`.

### DATA-03 — paróquia favorita sem garantia no banco

**Evidência:** `favorite_parish_id` é FK para qualquer
`ecclesiastical_jurisdictions`; apenas o frontend filtra `parish` e
`quasi_parish`. A própria migração documenta a ausência da constraint
(`20260726234500_add_parishes_and_profile_link.sql:10-16`).

**Impacto:** cliente alternativo ou bug pode gravar arquidiocese/diocese como
paróquia do usuário.

**Recomendação:** validar no banco por trigger/função controlada ou remodelar o
vínculo para uma relação cujo tipo seja garantido.

### SEC-04 e AUTH-01 — avisos dos Advisors

O Security Advisor encontrou:

- 12 tabelas com RLS sem policy. Para `research.*` e tabelas de citação/staging,
  isso funciona como bloqueio total e é principalmente informativo;
- bucket público listável;
- `handle_new_user()` e `sync_saint_devotee_count()` executáveis por `anon` e
  `authenticated`, apesar de serem funções de trigger `SECURITY DEFINER`;
- proteção contra senhas vazadas desabilitada.

**Recomendação:** revogar `EXECUTE` direto das funções de trigger e manter apenas
uso pelos triggers; habilitar proteção de senha; documentar explicitamente que
RLS sem policies é “deny all” intencional. Referência:
[Supabase Database Advisors](https://supabase.com/docs/guides/database/database-advisors).

## 8. Banco de dados e cobertura administrativa

### 8.1 Estado atual

| Tipo publicado | Quantidade |
| --- | ---: |
| arquidiocese metropolitana | 543 |
| arquidiocese | 45 |
| arquieparquia metropolitana | 38 |
| arquieparquia | 29 |
| patriarcado | 3 |
| paróquia | 2 |
| Santa Sé | 1 |
| diocese | 1 |
| província eclesiástica | 1 |

O lote de arquidioceses é amplo e bem útil como primeira camada mundial. A
legenda, contudo, já promete “Dioceses e equivalentes” e “Paróquias e capelas”
quando a cobertura real desses níveis é apenas inicial. A interface deveria
deixar claro que a camada está em expansão.

### 8.2 Índices e Advisors

O Performance Advisor encontrou 19 itens informativos:

- 2 FKs sem índice em `profiles`:
  `favorite_saint_id` e `favorite_parish_id`;
- 2 tabelas de backup sem PK;
- 15 índices ainda não usados, majoritariamente no schema de pesquisa recém
  criado.

Os FKs de perfil devem receber índice antes de crescimento significativo. Não
remover índices “não usados” do workflow recente sem carga real e
`pg_stat_statements`; ausência de uso agora não prova inutilidade.

### 8.3 Grants

Papéis `anon` e `authenticated` conservam grants amplos herdados em várias
tabelas, enquanto RLS efetivamente bloqueia escritas sem policy. A proteção
funciona, mas não segue estritamente privilégio mínimo. Em uma rodada de hardening,
revogar operações desnecessárias deixará o contrato mais explícito.

## 9. Layout e design

### 9.1 O que está funcionando

- hierarquia visual compreensível;
- bom contraste estrutural entre mapa e interface;
- estados selecionados e hover consistentes;
- modal Sobre forte, proporcional e adaptável;
- rota do santo agora distinguível;
- marcadores de estrutura variam por grau e zoom;
- legenda compacta e contextual.

### 9.2 O que merece refinamento

- muitos textos auxiliares usam 9–10 px; isso prejudica leitura em telas densas;
- há grande quantidade de posicionamento absoluto, o que aumenta custo de
  acomodar novos recursos;
- `backdrop-filter` aparece em várias superfícies e pode custar GPU em aparelhos
  modestos;
- a abertura Sobre em toda montagem da home foi uma decisão explícita de produto,
  mas impede acesso imediato ao mapa para visitantes recorrentes; medir abandono
  e considerar lembrar a conclusão sem retirar o botão Sobre;
- a timeline fixa em mobile compete com teclado, controles do mapa e conteúdo;
- a estrutura administrativa pode dominar visualmente o mapa ao crescer; precisa
  de densidade/clustering e filtros de camada.

## 10. Arquitetura Next.js e React

### 10.1 Aspectos positivos

- App Router atual e convenção `proxy.ts` compatível com Next.js 16;
- página de santo é Server Component;
- clientes Supabase para browser/SSR estão separados;
- cleanup de timers, listeners e efeitos é geralmente cuidadoso;
- respostas antigas de busca/contexto não são aplicadas após desmontagem;
- uso de `next/image` para o logo.

### 10.2 Aspectos a melhorar

- a home inteira é um Client Component; todos os imports renderizados entram na
  fronteira cliente. A documentação local do Next.js recomenda confinar
  `"use client"` às ilhas interativas;
- não há `error.tsx`, `loading.tsx`, `not-found.tsx` ou `global-error.tsx`;
- o cliente Supabase público depende de assertions `!`; variável ausente falha
  tarde e com mensagem pouco orientativa;
- não há tipos gerados do schema Supabase; interfaces manuais e `select("*")`
  deixam drift passar pelo compilador;
- `next.config.ts` está vazio, sem headers de segurança ou política explícita de
  imagens;
- página de santo ignora erros individuais das consultas e mostra ausência de
  dados como se fosse resultado legítimo.

## 11. Plano priorizado de melhoria

### P0 — antes de exposição pública ampliada

1. Atualizar Next.js para o patch seguro e executar build/regressão.
2. Fechar o open redirect de confirmação/callback.
3. Impedir que estruturas contemporâneas sem vigência apareçam em anos
   históricos ou rotulá-las explicitamente como camada atual.
4. Restringir bucket de avatares: tamanho, MIME, listagem e ciclo de substituição.
5. Reconciliar histórico de migrações com o schema remoto.

### P1 — antes de novos grandes lotes

1. Criar suíte mínima de testes e tornar lint/build gates confiáveis.
2. Migrar marcadores administrativos de massa para layers/clustering.
3. Debounce/throttle da timeline e redução das colunas/consultas.
4. Implementar diálogos e comboboxes acessíveis.
5. Transformar correções editoriais do bundle em dados revisados/citados.
6. Esclarecer ou persistir favoritos de santos.

### P2 — consolidação

1. Dividir page, mapa, perfil e CSS em módulos/hook por domínio.
2. Gerar tipos Supabase e eliminar `select("*")`.
3. Adicionar metadata por santo, 404 correto, sitemap e Open Graph.
4. Adicionar índices dos FKs de perfil e revisar grants.
5. Completar fontes, biografias, imagens licenciadas e níveis administrativos.

### P3 — refinamento e métricas

1. Testes visuais nos breakpoints definidos.
2. Métricas de Web Vitals, erros de runtime e uso da abertura Sobre.
3. Revisão de fontes abaixo de 12 px e custo de blur.
4. Remover assets órfãos e atualizar README/onboarding.

## 12. Critérios de aceite sugeridos

O projeto pode ser considerado pronto para uma fase pública mais ampla quando:

- `npm audit --omit=dev` não trouxer vulnerabilidade alta aplicável;
- redirects de Auth forem restritos à mesma origem;
- ano 0 não exibir estruturas sem comprovação de existência no ano 0;
- banco puder ser reconstruído integralmente a partir da cadeia versionada;
- `npm run lint`, TypeScript, build e testes passarem em CI;
- modais forem navegáveis por teclado e reconhecidos como diálogo;
- avatar tiver limites no banco/Storage, não apenas no HTML;
- páginas inexistentes retornarem 404;
- a interface distinguir cobertura completa, parcial e atual;
- expansão de paróquias não depender de centenas de markers DOM simultâneos.

## 13. Fontes técnicas de referência

- [Next.js — Server and Client Components](https://nextjs.org/docs/app/getting-started/server-and-client-components)
- [GitHub Advisory — Next.js Proxy bypass](https://github.com/advisories/GHSA-6gpp-xcg3-4w24)
- [Supabase — Row Level Security](https://supabase.com/docs/guides/database/postgres/row-level-security)
- [Supabase — Database Advisors](https://supabase.com/docs/guides/database/database-advisors)
- [Supabase — Securing your data](https://supabase.com/docs/guides/database/secure-data)
- [Supabase — Password security](https://supabase.com/docs/guides/auth/password-security)

## 14. Resumo estruturado para outra IA

```yaml
project_state:
  frontend_compiles: true
  source_lint_passes: true
  official_lint_usable: false
  local_server_root_200: true
  automated_tests_present: false
  database_live_checked: true
  workspace_changed_beyond_report: false

top_risks:
  - id: SEC-01
    priority: P0
    action: upgrade_next_patch
  - id: SEC-02
    priority: P0
    action: enforce_same_origin_auth_redirects
  - id: HIST-01
    priority: P0
    action: separate_current_ecclesiastical_layer_from_historical_validity
  - id: OPS-01
    priority: P0
    action: reconcile_local_and_remote_migration_history
  - id: SEC-03
    priority: P0
    action: restrict_avatar_bucket

verified_live_counts:
  saints: 93
  saints_without_biography: 29
  saints_without_image: 93
  saint_trajectory_points: 151
  historical_events: 69
  popes: 295
  ecclesiastical_jurisdictions: 663
  saint_citations: 0
  trajectory_citations: 0

do_not_assume:
  - ecclesiastical_records_are_historically_valid_for_selected_year
  - favorite_bookmark_is_persisted
  - remote_database_can_be_rebuilt_from_current_local_migrations
  - npm_run_lint_currently_checks_only_project_source
  - auth_and_profile_modals_are_accessible_dialogs

recommended_next_task:
  title: "Hardening P0 sem expansão de escopo"
  ordered_actions:
    - next_patch_update
    - auth_redirect_validation
    - historical_layer_semantics
    - avatar_storage_limits
    - migration_reconciliation
```

## 15. Declaração de não alteração

Esta auditoria foi conduzida em modo somente leitura para código, configuração e
banco. Nenhuma implementação, migração, política, dado, dependência ou layout foi
alterado. O único arquivo criado é `docs/PROJECT_AUDIT.md`.
