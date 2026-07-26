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
