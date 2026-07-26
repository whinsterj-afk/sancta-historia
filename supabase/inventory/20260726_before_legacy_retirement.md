# Inventário anterior à retirada das estruturas legadas

Data da verificação: 2026-07-26  
Projeto Supabase: `excfutxxfydoyjegliwu`

## Estruturas públicas e contagens exatas

| Objeto | Tipo | Registros | Destino |
| --- | --- | ---: | --- |
| `historical_events` | tabela | 21 | manter |
| `locations` | tabela | 174 | apagar após validação e snapshot |
| `places` | tabela | 97 | manter; catálogo geográfico canônico |
| `popes` | tabela | 295 | manter |
| `research_sources` | tabela | 0 | manter; estrutura de pesquisa futura |
| `saint_aliases` | tabela | 10 | manter |
| `saint_locations` | tabela | 0 | apagar; nunca foi utilizada |
| `saint_source_citations` | tabela | 0 | manter; relacionamento de fontes |
| `saint_trajectory_points` | tabela | 151 | manter; relacionamento normalizado |
| `saints` | tabela | 103 | consolidar para 93 santos canônicos |
| `trajectory_migration_exclusions` | tabela | 33 | manter como trilha de auditoria |
| `trajectory_source_citations` | tabela | 0 | manter; relacionamento de fontes |
| `saints_catalog` | view | 93 | recriar sem colunas legadas |
| `saint_search_catalog` | view | 93 | recriar sem filtro de duplicatas |
| `timeline_saint_points` | view | 139 | recriar sem filtro de duplicatas |
| `saint_heritage_points` | view | 2 | recriar sem filtro de duplicatas |

Todas as tabelas do schema `public` estavam com RLS ativado no momento do
inventário.

## Cobertura da transição

- IDs existentes em `locations`: 174.
- IDs referenciados por `saint_trajectory_points.source_location_ids` ou por
  `trajectory_migration_exclusions.source_location_id`: 174 distintos.
- IDs antigos sem destino: 0.
- IDs de origem desconhecidos na estrutura nova: 0.
- Pontos normalizados: 151, dos quais 139 pertencem à trajetória em vida, 2 ao
  patrimônio posterior e 10 estão arquivados.
- Exclusões justificadas: 33.
- Relações em `saint_locations`: 0.
- Santos canônicos publicados: 93.
- Duplicatas arquivadas em `saints`: 10.
- Duplicatas sem alias canônico correspondente: 0.
- Duplicatas com trajetória própria: 0.

Os 151 pontos e as 33 exclusões podem compartilhar IDs de origem quando vários
registros antigos foram consolidados. A união distinta cobre exatamente os 174
IDs de `locations`.

## Objetos legados identificados

### Tabelas

- `locations`: origem antiga, substituída por `places` e
  `saint_trajectory_points`.
- `saint_locations`: tabela de junção vazia, substituída por
  `saint_trajectory_points`.

### Colunas

- `saints.birth_lat`, `saints.birth_lng`, `saints.death_lat` e
  `saints.death_lng`: coordenadas produzidas pelo geocodificador antigo,
  redundantes com o catálogo `places`.
- `saints.canonical_saint_id`: usada apenas durante a consolidação temporária
  das dez duplicatas.
- `saint_aliases.source_saint_id`: será mantida como ID de proveniência, mas sem
  chave estrangeira para linhas que serão apagadas.
- `trajectory_migration_exclusions.source_location_id`: será mantida como ID de
  proveniência, acompanhada do snapshot JSON do registro de origem e sem chave
  estrangeira para `locations`.

Existiam 162 pares de coordenadas de nascimento/morte em 81 linhas de `saints`.
Nenhum par coincidia exatamente com as coordenadas canônicas de `places` e
somente 14 tinham correspondência pelo nome normalizado. Esses valores não eram
lidos pelo site e permanecem no backup anterior à normalização.

### Dependências removíveis

- Chaves estrangeiras de `saint_locations` para `saints` e `locations`.
- Chave estrangeira de `trajectory_migration_exclusions.source_location_id`
  para `locations`.
- Chave estrangeira de `saint_aliases.source_saint_id` para `saints`.
- Índices, check constraint, políticas RLS e views que usavam
  `saints.canonical_saint_id`.

## Cópias de segurança confirmadas

Schema: `sancta_historia_backups`

| Tabela | Registros |
| --- | ---: |
| `locations_before_normalization_20260726` | 174 |
| `saints_before_normalization_20260726` | 103 |

Essas cópias preservam integralmente os locais, os santos duplicados e as
coordenadas antigas. A migração de retirada aborta se os backups não existirem
ou se suas contagens forem diferentes das origens esperadas.

Observação de segurança: o inventário do Supabase indicou RLS desativado nas
duas tabelas do schema de backup. A retirada das estruturas legadas não altera
automaticamente a política de acesso dessas cópias.

## Referências no código

O aplicativo ativo lê apenas `saints_catalog`, `saint_search_catalog`,
`timeline_saint_points`, `saint_heritage_points`, `places`, `popes` e
`historical_events`.

As referências restantes a `locations`, `saint_locations` e às coordenadas
antigas estavam limitadas a scripts pontuais de geocodificação/auditoria e ao
histórico de migrações. Os scripts pontuais serão removidos ou adaptados; os
arquivos de migração já executados serão preservados como histórico imutável.

## Resultado planejado

- 10 tabelas públicas funcionais.
- 93 linhas canônicas em `saints`.
- Nenhuma tabela pública `locations` ou `saint_locations`.
- Nenhuma coordenada geográfica duplicada em `saints`.
- Nenhuma linha temporária de santo duplicado.
- Proveniência dos IDs antigos preservada nas estruturas novas.
- Dados brutos anteriores à transição preservados no schema de backup.
