# Validação posterior à retirada das estruturas legadas

Data da verificação: 2026-07-26  
Projeto Supabase: `excfutxxfydoyjegliwu`

## Resultado

| Tabela pública | Registros |
| --- | ---: |
| `historical_events` | 21 |
| `places` | 97 |
| `popes` | 295 |
| `research_sources` | 0 |
| `saint_aliases` | 10 |
| `saint_source_citations` | 0 |
| `saint_trajectory_points` | 151 |
| `saints` | 93 |
| `trajectory_migration_exclusions` | 33 |
| `trajectory_source_citations` | 0 |

- `locations`: removida.
- `saint_locations`: removida.
- Colunas geográficas/canônicas legadas em `saints`: 0.
- Snapshots de exclusão preenchidos: 33 de 33.
- Pontos públicos de trajetória em vida: 139.
- Pontos públicos de patrimônio posterior: 2.
- Pontos arquivados: 10.
- Tabelas públicas sem RLS: 0.
- Erros encontrados pela auditoria normalizada: 0.

As quatro views públicas foram recriadas com `security_invoker`:
`saints_catalog`, `saint_search_catalog`, `timeline_saint_points` e
`saint_heritage_points`.

## Endurecimento

- `search_path` fixado em `pg_catalog` nas funções
  `normalize_catalog_text(text)` e `set_updated_at()`.
- Índices adicionados às chaves estrangeiras `source_id` de
  `saint_source_citations` e `trajectory_source_citations`.
- As tabelas internas de pesquisa, citações e auditoria permanecem fechadas por
  RLS sem política pública enquanto não houver conteúdo destinado ao site.

## Verificações da aplicação

- `npm run audit:data`: aprovado.
- Integridade: coordenadas válidas, nenhum ponto órfão, nenhum período inválido,
  nenhuma trajetória duplicada, sequências únicas e aliases pesquisáveis.
- `npm run lint`: 0 erros; avisos somente nos bundles gerados do MapLibre.
- `npm run build`: aprovado com Next.js 16.2.9 e TypeScript.

## Cópias de segurança

Os backups anteriores à normalização permanecem inalterados:

- `sancta_historia_backups.locations_before_normalization_20260726`: 174.
- `sancta_historia_backups.saints_before_normalization_20260726`: 103.

O Supabase sinaliza RLS desativado nessas duas tabelas de backup. A decisão de
bloquear completamente ou conceder uma política administrativa específica deve
ser tomada antes de alterar o acesso, para não tornar as cópias inacessíveis por
engano.
