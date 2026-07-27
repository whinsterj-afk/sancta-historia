---
report_type: audit_comparison
compares:
  - RELATORIO_ANALISE_TECNICA.md (Claude Code, 2026-07-26)
  - docs/PROJECT_AUDIT.md (Codex, 2026-07-26, commit 180d17d)
language: pt-BR
---

# Comparação entre as duas auditorias (Claude Code vs. Codex)

## 1. Diferença de método — explica a maior parte da diferença de profundidade

| | Claude Code (`RELATORIO_ANALISE_TECNICA.md`) | Codex (`docs/PROJECT_AUDIT.md`) |
|---|---|---|
| Testes automatizados executados | Não (`tsc`/`eslint`/`npm audit` não rodados) | Sim: `tsc --noEmit`, `eslint`, `npm run lint`, `npm audit --omit=dev` |
| Banco de dados | Não consultado ao vivo (sem acesso MCP Supabase autenticado nesta sessão) | Consultado ao vivo: RPC geoespacial, Advisors de Segurança e Performance, contagem real de linhas |
| Navegador | Testado ao vivo (mobile 375×812 real, com `getBoundingClientRect`/`getComputedStyle`) | Não testado ao vivo (sem automação visual disponível); avaliação por leitura de CSS/estrutura |
| Nota numérica | Não atribuída | Sim, nota por área + nota global (3,1/5) |

**Consequência prática:** a Codex tem evidência quantitativa que a Claude Code não tem (contagem de registros, resultado de Advisors, resultado de `npm audit`), enquanto a Claude Code tem uma evidência ao vivo que a Codex não tem (o bug de layout mobile foi *observado rodando*, não inferido do CSS).

---

## 2. Achados que **as duas auditorias confirmam de forma independente**

Isso é o sinal mais forte do relatório combinado — quando dois métodos diferentes chegam à mesma conclusão sem ter lido um ao outro:

| Achado | Claude Code | Codex |
|---|---|---|
| `AuthModal`/`ProfileModal` não são diálogos acessíveis (sem focus trap, Escape, restauração de foco) | 🟠 Importante | A11Y-01, Alta |
| `AboutModal` é a implementação correta e deveria virar o padrão a extrair | 🟢 Ponto forte | 🟢 Ponto forte (5.3) — mesma recomendação: "extrair componente reutilizável a partir do `AboutModal`" |
| Layout mobile tem problema estrutural de altura/posicionamento fixo | 🔴 Crítico (bug do painel de contexto, verificado ao vivo) | RESP-01, Média (`min-height:1100px`, timeline fixa) — **mesma causa-raiz, ângulos diferentes** |
| Timeline dispara consultas em excesso ao mover o slider | 🟠 Importante (sem debounce) | PERF-01, Média (`select("*")`, 5 queries por movimento, sem abort) — Codex é mais específico aqui |
| `lib/catholicEditorial.ts` é frágil (IDs numéricos crus, sem fonte/citação) | 🟡 Menor | DATA-02, Média — Codex trata como problema de governança de dados, não só de código |
| `AGENTS.md`/documentação tem pequenas divergências com a realidade do repo | 🟡 Menor | DOC-01, Baixa (README defasado, sem `.env.example`) |

---

## 3. Achados **exclusivos de cada auditoria**

### Só na Codex (não capturados pela Claude Code — geralmente por falta de acesso a banco/testes/scripts)

- **SEC-01**: Next.js 16.2.9 com vulnerabilidade conhecida, patch 16.2.12 disponível.
- **SEC-02**: open redirect real no fluxo de confirmação de e-mail (`app/auth/confirm/route.ts:19-24`) — aceita qualquer URL absoluta.
- **HIST-01**: o achado mais grave do documento — 647 estruturas eclesiásticas *atuais* aparecem no mapa mesmo em anos históricos (ano 0, 33, 1054...) porque `erected_year is null` não bloqueia exibição. Isso ataca diretamente a integridade histórica do produto, que é o núcleo da proposta do Sancta Historia.
- **OPS-01**: histórico de migrações locais (20 arquivos) não bate com o que está registrado no Supabase remoto (14 migrações) — risco de não conseguir reconstruir o banco do zero.
- **SEC-03**: bucket de avatares sem limite de tamanho/MIME e com listagem pública habilitada.
- **FUNC-01**: o botão de "favoritar santo" em `SaintsPanel.tsx` é só `useState` local — nunca persiste, nunca é salvo. É uma promessa de UI (ícone, texto "Adicionar aos favoritos") que não se cumpre.
- **DATA-01**: métricas reais de cobertura de conteúdo (29 santos sem biografia, 93 sem imagem, 0 citações vinculadas) — só possível com acesso ao banco.
- **SEO-01**: `/saints/not-a-number` retorna HTTP 200 em vez de 404; sem `generateMetadata`/Open Graph por santo.
- **DX-01**: `npm run lint` oficial está contaminado por `.claude/worktrees/**` e gera ~8.600 ocorrências, tornando-o inútil como gate de CI.
- **SEC-04/AUTH-01**: funções trigger `SECURITY DEFINER` executáveis diretamente por `anon`/`authenticated`; proteção contra senha vazada desabilitada no Supabase Auth.

### Só na Claude Code (não capturados pela Codex — geralmente por observação ao vivo no navegador)

- **Bug concreto e medido do painel de contexto mobile**: coordenadas reais (`left: -16px`, painéis recuados ainda ocupando 550-605px de altura) obtidas via `getBoundingClientRect`/`getComputedStyle` em execução real — a Codex chegou a uma conclusão qualitativamente parecida (RESP-01) mas sem essa evidência de runtime.
- **Logo do cabeçalho sendo servida a 3840px de largura** para exibição de 225px (`GET /_next/image?url=...&w=3840`) — achado só visível inspecionando requisições de rede reais, não estava no relatório da Codex.
- **`AuthModal.tsx` cria duas instâncias distintas de `createSupabaseBrowserClient()`** — possível causa do aviso "Multiple GoTrueClient instances" no console (observação de console ao vivo).
- Observação (não confirmada, sinalizada como pendente de reverificação) de que a transform `translateX(-104%)` de `.leftPanelReceded` pode não estar sendo aplicada de fato — um possível segundo bug distinto do problema de espaço reservado no fluxo.

---

## 4. Onde as duas discordam ou têm ênfase diferente

- **Severidade do problema mobile**: a Claude Code classifica o bug do painel de contexto como 🔴 Crítico (por tê-lo visto quebrado ao vivo); a Codex trata o tema geral como Média (RESP-01), por ser uma inferência de CSS sem confirmação visual direta. **A leitura combinada é: é pelo menos tão grave quanto a Claude Code descreveu — a Codex provavelmente sub-estimou por não ter conseguido ver a tela real.**
- **Cobertura de banco de dados**: a Claude Code não tem nada a dizer sobre HIST-01, OPS-01, SEC-03, FUNC-01, DATA-01 — não porque discorde, mas porque não teve acesso a essas fontes nesta sessão. Isso não é uma discordância de conteúdo, é uma lacuna de escopo.
- **Tom/format**: a Claude Code entrega ação corretiva por achado sem pontuação numérica; a Codex entrega nota de 0-5 por área mais um plano P0/P1/P2/P3. Os dois são compatíveis — a lista P0 da Codex e a "lista priorizada" da Claude Code não se contradizem em nenhum ponto, apenas a Codex tem mais achados porque teve mais acesso.

---

## 5. Leitura consolidada (o que fazer com as duas em mãos)

1. **Os achados confirmados por ambas (seção 2) são os de maior confiança** — priorizar correção dos modais de auth/perfil (extrair o padrão do `AboutModal`) e do layout mobile antes de qualquer outra coisa, já que dois métodos independentes chegaram à mesma conclusão.
2. **Os P0 exclusivos da Codex (SEC-01, SEC-02, HIST-01, OPS-01, SEC-03) são os mais urgentes do conjunto combinado** — nenhum deles foi contradito pela Claude Code, apenas não pôde ser verificado por falta de acesso a banco/terminal nesta sessão. Em especial, **HIST-01** (estruturas modernas aparecendo em anos históricos) é provavelmente o achado mais importante dos dois relatórios somados, pois ataca a premissa central do produto (rigor histórico), não apenas a qualidade de engenharia.
3. **Nenhuma das duas auditorias contradiz a outra em nenhum ponto factual** — a combinação é estritamente aditiva, o que é um bom sinal de consistência entre os dois agentes trabalhando de forma independente sobre o mesmo código.

---

*Nenhum arquivo de código, configuração ou banco foi alterado para produzir esta comparação — apenas leitura dos dois relatórios já existentes.*
