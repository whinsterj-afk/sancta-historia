---
report_type: audit_comparison
project: sancta-historia
generated_at: 2026-07-26
language: pt-BR
status: final
---

# Comparação básica dos relatórios de auditoria

## 1. Arquivos comparados

| Autor | Arquivo | Tamanho | Linhas | Perfil |
| --- | --- | ---: | ---: | --- |
| Claude Code | `RELATORIO_ANALISE_TECNICA.md` | 17.194 bytes | 140 | análise concisa, com inspeção visual no navegador |
| Codex | `docs/PROJECT_AUDIT.md` | 34.500 bytes | 756 | auditoria extensa, com banco ao vivo, segurança, dependências e plano por prioridade |

Esta comparação não modifica nem funde os relatórios originais.

## 2. Conclusão geral

Os relatórios são **majoritariamente complementares**:

- Claude é mais forte na verificação visual direta, especialmente mobile, logo e
  comportamento observado no navegador.
- Codex é mais forte em segurança, Supabase ao vivo, qualidade dos dados,
  dependências, semântica histórica, operação e critérios de aceite.
- Ambos concordam que o projeto tem boa identidade visual e uma base técnica
  promissora, mas precisa melhorar acessibilidade, manutenção, responsividade e
  controle de requisições.

O relatório do Codex deve ser usado como inventário principal de riscos. O do
Claude deve ser usado como complemento visual, com uma reconfirmação do suposto
deslocamento permanente do painel mobile.

## 3. Pontos em comum

| Tema | Claude | Codex | Síntese |
| --- | --- | --- | --- |
| Modais de Auth/Profile | sem focus trap, Escape e restauração de foco | diálogo incompleto semanticamente e por teclado | achado confirmado por ambos; prioridade alta |
| Timeline | falta debounce nas consultas por ano | cada passo dispara cinco consultas | mesmo problema, descrito com profundidades diferentes |
| CSS | `globals.css` monolítico | arquivos centrais concentram responsabilidades | dívida real de manutenção |
| Conteúdo por ID | `catholicEditorial.ts` frágil | segunda fonte de verdade fora do banco | mover revisões aprovadas para o fluxo editorial |
| AboutModal | exemplo correto de acessibilidade | foco, Escape e scroll bem implementados | deve servir de base aos outros modais |
| Mapa | bom cleanup e respeito a movimento reduzido | bom ciclo de vida, padding e descarte de respostas antigas | implementação atual tem cuidados sólidos |
| Migrações | convenções e segurança geralmente boas | RLS, views e RPC bem estruturadas | fundação do banco é um ponto forte |
| Responsividade | mobile merece correção/reteste | layout mobile rígido e timeline fixa | necessária rodada dedicada em dispositivos |

## 4. Achados exclusivos ou mais aprofundados pelo Claude

1. Inspeção no navegador em 375×812 e 768×1024.
2. Possível problema de fluxo/altura do painel de contexto no mobile.
3. Logo solicitado pelo otimizador do Next em largura muito superior à exibida,
   provavelmente por ausência do atributo `sizes`.
4. Duas instâncias do cliente Supabase dentro de `AuthModal`.
5. Rótulos canônicos incompletos para alguns tipos eclesiásticos.
6. Duas migrações sem bloco explícito `begin/commit`.
7. UUID do estilo MapTiler e validações de coordenadas repetidas.

Esses pontos são úteis, especialmente o `sizes` do logo e a inspeção mobile.

## 5. Achados exclusivos ou mais aprofundados pelo Codex

1. Next.js 16.2.9 com vulnerabilidades conhecidas e patch disponível.
2. Redirecionamento absoluto externo após confirmação de e-mail.
3. 647 estruturas eclesiásticas contemporâneas aparecendo inclusive no ano 0
   em zoom 4.5 ou superior.
4. Divergência entre 20 migrações locais e 14 versões registradas no Supabase.
5. Ausência completa de testes automatizados.
6. Favoritos dos cards mantidos apenas em memória.
7. Bucket de avatar sem limite de tamanho/MIME e publicamente listável.
8. Advisors de segurança e desempenho do Supabase.
9. Métricas ao vivo: 93 santos, 29 sem biografia, 93 sem imagem e zero
   citações vinculadas.
10. Limite de escala dos marcadores DOM para dioceses e paróquias mundiais.
11. Santo inexistente retornando HTTP 200 e metadata genérica.
12. Comando oficial de lint contaminado por worktrees e artefatos gerados.
13. Falta de garantia no banco para o tipo de `favorite_parish_id`.

Esses achados ampliam o relatório para riscos de produção, integridade histórica,
segurança e reprodutibilidade.

## 6. Divergências que precisam de interpretação

### 6.1 Clientes Supabase

Claude classifica a existência de clientes separados como risco importante e
sugere unificação futura.

O `AGENTS.md` afirma explicitamente que a separação é deliberada:

- `lib/supabase.ts` atende conteúdo público anônimo;
- clientes `@supabase/ssr` atendem fluxos dependentes de sessão.

**Conclusão:** não há defeito atual. Existe apenas risco de uso incorreto no
futuro. A ação adequada é preservar o contrato e documentar cada novo call site,
não unificar automaticamente os clientes.

### 6.2 Painel de contexto mobile

Claude mediu `left: -16px` logo após abrir o painel e tratou a sobreposição como
bug confirmado. A animação `context-enter` começa em `translateX(-28px)`, enquanto
o painel mobile começa em `left: 12px`; durante o primeiro quadro, isso resulta
exatamente em `-16px`.

**Conclusão:** o corte horizontal permanente ainda não está comprovado. Deve ser
medido novamente depois de pelo menos 500 ms. A altura de 934 px e a permanência
dos painéis recuados no fluxo continuam sendo sinais reais de layout rígido e
merecem teste.

### 6.3 Combobox principal

Claude considera o padrão ARIA corretamente aplicado. Codex aponta ausência de
navegação por setas, Enter e `aria-activedescendant`.

**Conclusão:** a semântica básica existe, mas o padrão interativo completo não.
O achado do Codex complementa, e não invalida, a observação positiva do Claude.

### 6.4 `moveend` do mapa

Claude recomenda debounce porque a RPC é chamada em `moveend`.

`moveend` já ocorre quando o movimento termina, não a cada frame. Movimentos
sucessivos ainda podem produzir várias chamadas, mas o componente descarta
respostas antigas.

**Conclusão:** otimização válida para escala, porém menos urgente que o debounce
da timeline.

### 6.5 Migrações aplicadas

Claude afirma que perfil/paróquia foram aplicados. A inspeção do Codex confirma
que os objetos existem no banco ao vivo, mas as versões correspondentes não
aparecem no registro remoto de migrações.

**Conclusão:** o schema existe, mas sua proveniência versionada está inconsistente.
O achado operacional do Codex permanece válido.

### 6.6 `AGENTS.md` e schema `research`

Claude sugere que `AGENTS.md` não documenta o schema `research`.

O arquivo atual contém uma seção detalhada sobre pesquisa, tabelas, RLS e acesso.

**Conclusão:** essa observação do relatório do Claude está desatualizada ou
incorreta e não deve gerar tarefa.

## 7. Prioridade consolidada

### P0

1. Atualizar o patch do Next.js.
2. Restringir redirects de autenticação à mesma origem.
3. Corrigir a semântica temporal da estrutura eclesiástica.
4. Restringir uploads e listagem de avatares.
5. Reconciliar migrações locais e remotas.

### P1

1. Reconfirmar e corrigir o layout do contexto mobile após a animação.
2. Aplicar ao AuthModal/ProfileModal o padrão acessível do AboutModal.
3. Adicionar testes automatizados e corrigir o comando de lint.
4. Adicionar `sizes` adequado ao logo.
5. Debounce/throttle das consultas da timeline.
6. Decidir e esclarecer a persistência de favoritos.

### P2

1. Modularizar CSS, mapa, página principal e perfil.
2. Preparar clustering/layers para expansão de paróquias.
3. Completar citações, biografias, imagens e metadados.
4. Melhorar comboboxes e semântica HTTP/SEO.

## 8. Síntese para outra IA

```yaml
comparison_result: complementary
primary_report: docs/PROJECT_AUDIT.md
visual_supplement: RELATORIO_ANALISE_TECNICA.md

high_confidence_consensus:
  - auth_profile_modal_accessibility
  - timeline_request_rate
  - frontend_file_concentration
  - catholic_editorial_ids_are_fragile
  - about_modal_is_good_reference

claude_items_to_reverify:
  - mobile_context_left_offset_after_animation
  - claimed_agents_md_research_omission

do_not_do:
  - do_not_merge_supabase_clients_without_new_requirement
  - do_not_treat_minus_16px_animation_frame_as_permanent_layout_bug
  - do_not_edit_applied_migrations_retroactively

recommended_source_usage:
  security_database_history: Codex
  live_visual_mobile_logo: Claude
  consolidated_priorities: this_file
```
