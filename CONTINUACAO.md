# Sancta Historia — ponto de continuidade

Última atualização: 26 de julho de 2026.

## Como retomar

1. Na raiz do repositório, execute `git status` e `git log -5 --oneline`.
2. Leia `AGENTS.md` por inteiro; ele é o contrato comum entre Codex e Claude Code.
3. Leia primeiro `docs/AUDIT_COMPARISON.md` e depois consulte os relatórios
   completos conforme a área que será trabalhada.
4. Verifique `http://localhost:3000`. Se o servidor anterior não estiver mais
   disponível, confirme que as portas 3000–3002 estão livres e execute
   `npm run dev`.
5. Antes de qualquer alteração estrutural ou no Supabase, confirme novamente o
   estado do Git e a cadeia de migrações remota.

## Estado salvo

- Branch: `transfer-pc-2026-07-25`.
- Último commit funcional antes dos relatórios:
  `180d17d Destaca trajetos dos santos no mapa`.
- Auditoria do Codex:
  `e979fd2 Documenta auditoria profunda do projeto`.
- Comparação crítica do Codex:
  `bb17015 Compara relatorios de auditoria`.
- Relatórios produzidos pelo Claude Code:
  `524bde6 Salva relatorios produzidos pelo Claude Code`.
- Nenhum código funcional, layout, dado ou configuração do Supabase foi alterado
  durante as auditorias.
- O servidor de desenvolvimento respondia com HTTP 200 em
  `http://localhost:3000` no encerramento desta sessão.

## Relatórios disponíveis

| Arquivo | Uso recomendado |
| --- | --- |
| `docs/AUDIT_COMPARISON.md` | síntese consolidada e divergências entre agentes |
| `docs/PROJECT_AUDIT.md` | auditoria principal: segurança, banco, dados, operação e prioridades |
| `RELATORIO_ANALISE_TECNICA.md` | inspeção do Claude, especialmente observações visuais |
| `docs/COMPARACAO_AUDITORIAS.md` | comparação original produzida pelo Claude |
| `docs/DATA_RESEARCH.md` | processo vigente de pesquisa e promoção de conteúdo |

`docs/AUDIT_COMPARISON.md` deve orientar a leitura conjunta porque corrige duas
interpretações importantes:

- os clientes Supabase separados são uma decisão arquitetural intencional;
- o deslocamento horizontal de `-16px` medido no painel mobile coincide com o
  primeiro quadro da animação e precisa ser medido novamente depois de 500 ms
  antes de ser tratado como bug permanente.

## Validações realizadas

- `npx tsc --noEmit`: aprovado.
- `npx eslint app components lib proxy.ts scripts`: aprovado.
- `GET /`: HTTP 200.
- `GET /saints/1`: HTTP 200.
- `GET /saints/not-a-number`: HTTP 200, embora devesse ser tratado como 404.
- Supabase ao vivo: tabelas, policies, views, funções, Storage, Advisors,
  migrações e métricas inspecionados apenas por leitura.
- `npm run lint`: não serve como gate no estado atual, pois varre
  `.claude/worktrees/**/.next` e workers gerados, produzindo 8.647 ocorrências.
- `npm audit --omit=dev`: encontrou vulnerabilidades altas corrigíveis por patch
  do Next.js.
- `next build` não foi repetido durante a auditoria para não disputar `.next`
  com o servidor que deveria permanecer disponível.

## Prioridades consolidadas para a próxima sessão

### P0 — hardening antes de ampliar o produto

1. Atualizar Next.js do patch 16.2.9 para um patch seguro e validar build/Auth.
2. Restringir redirects de confirmação e OAuth à mesma origem.
3. Corrigir a semântica histórica das estruturas eclesiásticas:
   647 estruturas atuais aparecem inclusive no ano 0 em zoom 4.5+.
4. Limitar tamanho/MIME e listagem do bucket de avatares.
5. Reconciliar os 20 arquivos locais de migração com as 14 versões registradas
   no Supabase remoto.

### P1 — confiabilidade e experiência

1. Reconfirmar o painel de contexto mobile depois de concluída a animação;
   revisar também a altura rígida de 1100 px e painéis recuados no fluxo.
2. Aplicar o padrão acessível do `AboutModal` a `AuthModal` e `ProfileModal`.
3. Criar testes automatizados e corrigir o comando oficial de lint.
4. Adicionar `sizes` adequado ao logo para evitar imagem superdimensionada.
5. Reduzir as cinco consultas disparadas por cada movimento da timeline.
6. Decidir se o botão de favorito será persistido ou removido/renomeado.

### P2 — escala e conteúdo

1. Preparar layers/clustering em vez de markers DOM para expansão de paróquias.
2. Completar citações, biografias e imagens licenciadas dos santos.
3. Modularizar `app/page.tsx`, `SaintsMap.tsx`, `ProfileModal.tsx` e
   `globals.css`.
4. Implementar 404 real, metadata por santo e comboboxes completos por teclado.

## Métricas verificadas no Supabase em 26/07/2026

- 93 santos publicados;
- 29 santos sem biografia;
- 93 santos sem imagem;
- 151 pontos de trajetória, todos ligados a lugares com coordenadas;
- 295 papas;
- 69 fatos históricos;
- 663 jurisdições eclesiásticas publicadas;
- 13 fontes de pesquisa;
- 0 citações vinculadas a santos;
- 0 citações vinculadas a trajetórias.

## Cuidados na retomada

- Não unifique os clientes Supabase automaticamente; siga o contrato documentado
  em `AGENTS.md`.
- Não aplique novas migrações antes de reconciliar o histórico remoto.
- Não trate o lote mundial atual de arquidioceses como reconstrução histórica.
- Não edite retroativamente migrações já aplicadas; faça correções progressivas.
- Não exponha valores de `.env.local`.
- Preserve mudanças de outro agente e faça commits separados por autoria/escopo.
