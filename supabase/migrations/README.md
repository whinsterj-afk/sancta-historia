# Migrações do Supabase

Execute os arquivos em ordem cronológica. O conjunto de 2026-07-26:

1. preserva cópias das tabelas legadas;
2. cria santos canônicos, aliases, lugares e pontos de trajetória;
3. arquiva registros duplicados sem apagá-los;
4. restringe a leitura pública aos registros publicados;
5. separa trajetória em vida de relíquias e culto póstumo;
6. valida a cobertura integral dos dados antigos e retira tabelas, colunas e
   linhas transitórias;
7. fixa o `search_path` das funções públicas e completa os índices das relações
   de fontes.

Os dados brutos anteriores à transição permanecem em
`sancta_historia_backups`. A aplicação lê `saints_catalog`,
`saint_search_catalog`, `timeline_saint_points` e `saint_heritage_points`; as
tabelas públicas `locations` e `saint_locations` deixam de existir após a
migração final.

## Reconciliação e paróquias — 2026-08-02

O histórico remoto e os arquivos locais foram reconciliados em 29 versões.
As versões `20260726193457`, `20260726193626` e `20260726210627` são
placeholders de compatibilidade para execuções antigas registradas com outro
timestamp; seus comentários apontam para os arquivos que preservam o SQL
reproduzível na ordem correta.

As migrações `20260802190000` a `20260802193000` importam 300 paróquias de
ES, RJ, MG e SP de forma idempotente. A migração
`20260802222707_publish_parish_search_catalog.sql` publica a view
`parish_search_catalog`, com `security_invoker`, para busca sem acentos por
nome, cidade, estado ou país.

A migração `20260802223635_harden_profile_security_and_indexes.sql` revoga a
execução pública das funções privilegiadas de gatilho, restringe a listagem de
avatares ao próprio usuário e indexa as referências de santo e paróquia do
perfil.
