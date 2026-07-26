-- Internal, auditable workflow for researching saints and importing the
-- worldwide administrative structure of the Catholic Church.

alter table public.research_sources
  add column if not exists checked_at date,
  add column if not exists language_code text,
  add column if not exists is_official boolean not null default false,
  add column if not exists rights_note text;

create unique index if not exists research_sources_url_key
  on public.research_sources (url);

insert into public.research_sources (
  title,
  publisher,
  url,
  source_type,
  checked_at,
  language_code,
  is_official,
  rights_note
)
values
  (
    'Dicastério para as Causas dos Santos',
    'Santa Sé',
    'https://www.vatican.va/roman_curia/congregations/csaints/index.htm',
    'website',
    current_date,
    'mul',
    true,
    'Usar como fonte primária para atos, listas e documentação oficial; não copiar textos extensos.'
  ),
  (
    'Celebrações Litúrgicas Pontifícias — Santos',
    'Santa Sé',
    'https://www.vatican.va/news_services/liturgy/documents/index_saints_en.html',
    'website',
    current_date,
    'mul',
    true,
    'As biografias e atos individuais devem ser citados por URL própria.'
  ),
  (
    'Documentos do Dicastério para o Culto Divino e a Disciplina dos Sacramentos',
    'Santa Sé',
    'https://www.vatican.va/content/romancuria/en/dicasteri/dicastero-culto-divino-e-disciplina-sacramenti/documenti.html',
    'website',
    current_date,
    'mul',
    true,
    'Fonte para calendário, celebrações e atualizações do Martirológio Romano.'
  ),
  (
    'Catholic Church Statistics 2025',
    'Agência Fides / Santa Sé',
    'https://press.vatican.va/content/dam/salastampa/it/fuori-bollettino/pdf/EN%20-%20Catholic%20Church%20Statistics%202025.pdf',
    'article',
    current_date,
    'en',
    true,
    'Dados atualizados até 31 de dezembro de 2023; usar para metas e conferência agregada, não como cadastro geográfico.'
  ),
  (
    'Annuario Pontificio Digital',
    'Secretaria de Estado da Santa Sé',
    'https://www.annuariopontificio.catholic/',
    'website',
    current_date,
    'it',
    true,
    'Fonte canônica atualizada e assinada. Não automatizar extração nem adquirir assinatura sem aprovação e verificação dos termos de uso.'
  )
on conflict (url) do update
set
  title = excluded.title,
  publisher = excluded.publisher,
  source_type = excluded.source_type,
  checked_at = excluded.checked_at,
  language_code = excluded.language_code,
  is_official = excluded.is_official,
  rights_note = excluded.rights_note;

create schema if not exists research;

revoke all on schema research from public;
revoke all on schema research from anon, authenticated, service_role;

create table if not exists research.batches (
  id bigint generated always as identity primary key,
  slug text not null unique,
  dataset text not null,
  title text not null,
  scope_description text not null,
  sequence_order integer not null,
  status text not null default 'planned',
  target_count integer,
  source_strategy text not null,
  started_at timestamptz,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint research_batches_slug_nonempty check (trim(slug) <> ''),
  constraint research_batches_title_nonempty check (trim(title) <> ''),
  constraint research_batches_dataset_values
    check (dataset in ('saints', 'ecclesiastical_jurisdictions')),
  constraint research_batches_status_values
    check (status in ('planned', 'ready', 'in_progress', 'review', 'completed', 'blocked')),
  constraint research_batches_target_count_nonnegative
    check (target_count is null or target_count >= 0)
);

create table if not exists research.batch_sources (
  batch_id bigint not null
    references research.batches(id)
    on delete cascade,
  source_id bigint not null
    references public.research_sources(id)
    on delete restrict,
  purpose text not null,
  primary key (batch_id, source_id),
  constraint research_batch_sources_purpose_nonempty check (trim(purpose) <> '')
);

create index if not exists research_batch_sources_source_id_idx
  on research.batch_sources (source_id);

create table if not exists research.saint_reviews (
  saint_id bigint primary key
    references public.saints(id)
    on delete cascade,
  batch_id bigint not null
    references research.batches(id)
    on delete restrict,
  status text not null default 'queued',
  priority smallint not null default 3,
  missing_fields text[] not null default '{}'::text[],
  research_notes text,
  last_verified_at timestamptz,
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint research_saint_reviews_status_values
    check (status in ('queued', 'in_progress', 'researched', 'reviewed', 'published', 'blocked')),
  constraint research_saint_reviews_priority_values check (priority between 1 and 5)
);

create index if not exists research_saint_reviews_batch_status_priority_idx
  on research.saint_reviews (batch_id, status, priority, saint_id);

create table if not exists research.saint_candidates (
  id bigint generated always as identity primary key,
  batch_id bigint not null
    references research.batches(id)
    on delete cascade,
  source_record_key text not null,
  proposed_name text not null,
  source_url text not null,
  payload jsonb not null default '{}'::jsonb,
  validation_errors text[] not null default '{}'::text[],
  status text not null default 'raw',
  linked_saint_id bigint
    references public.saints(id)
    on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (batch_id, source_record_key),
  constraint research_saint_candidates_name_nonempty check (trim(proposed_name) <> ''),
  constraint research_saint_candidates_source_url_nonempty check (trim(source_url) <> ''),
  constraint research_saint_candidates_payload_object check (jsonb_typeof(payload) = 'object'),
  constraint research_saint_candidates_status_values
    check (status in ('raw', 'normalized', 'duplicate', 'rejected', 'promoted'))
);

create index if not exists research_saint_candidates_batch_status_idx
  on research.saint_candidates (batch_id, status, id);

create index if not exists research_saint_candidates_linked_saint_id_idx
  on research.saint_candidates (linked_saint_id)
  where linked_saint_id is not null;

create table if not exists research.ecclesiastical_import_rows (
  id bigint generated always as identity primary key,
  batch_id bigint not null
    references research.batches(id)
    on delete cascade,
  source_record_key text not null,
  entity_scope text not null,
  raw_name text not null,
  canonical_type text,
  parent_source_record_key text,
  country_code text,
  address_text text,
  latitude double precision,
  longitude double precision,
  payload jsonb not null default '{}'::jsonb,
  validation_errors text[] not null default '{}'::text[],
  status text not null default 'raw',
  promoted_jurisdiction_id bigint
    references public.ecclesiastical_jurisdictions(id)
    on delete set null,
  promoted_site_id bigint
    references public.ecclesiastical_sites(id)
    on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (batch_id, source_record_key),
  constraint research_ecclesiastical_import_name_nonempty check (trim(raw_name) <> ''),
  constraint research_ecclesiastical_import_scope_values
    check (entity_scope in ('jurisdiction', 'site')),
  constraint research_ecclesiastical_import_country_code
    check (country_code is null or country_code ~ '^[A-Z]{2}$'),
  constraint research_ecclesiastical_import_latitude
    check (latitude is null or latitude between -90 and 90),
  constraint research_ecclesiastical_import_longitude
    check (longitude is null or longitude between -180 and 180),
  constraint research_ecclesiastical_import_payload_object check (jsonb_typeof(payload) = 'object'),
  constraint research_ecclesiastical_import_status_values
    check (status in ('raw', 'normalized', 'geocoded', 'validated', 'duplicate', 'rejected', 'promoted'))
);

create index if not exists research_ecclesiastical_import_batch_status_idx
  on research.ecclesiastical_import_rows (batch_id, status, id);

create index if not exists research_ecclesiastical_import_jurisdiction_id_idx
  on research.ecclesiastical_import_rows (promoted_jurisdiction_id)
  where promoted_jurisdiction_id is not null;

create index if not exists research_ecclesiastical_import_site_id_idx
  on research.ecclesiastical_import_rows (promoted_site_id)
  where promoted_site_id is not null;

alter table research.batches enable row level security;
alter table research.batch_sources enable row level security;
alter table research.saint_reviews enable row level security;
alter table research.saint_candidates enable row level security;
alter table research.ecclesiastical_import_rows enable row level security;

revoke all on all tables in schema research from public, anon, authenticated, service_role;
revoke all on all sequences in schema research from public, anon, authenticated, service_role;

drop trigger if exists research_batches_set_updated_at on research.batches;
create trigger research_batches_set_updated_at
before update on research.batches
for each row execute function public.set_updated_at();

drop trigger if exists research_saint_reviews_set_updated_at on research.saint_reviews;
create trigger research_saint_reviews_set_updated_at
before update on research.saint_reviews
for each row execute function public.set_updated_at();

drop trigger if exists research_saint_candidates_set_updated_at on research.saint_candidates;
create trigger research_saint_candidates_set_updated_at
before update on research.saint_candidates
for each row execute function public.set_updated_at();

drop trigger if exists research_ecclesiastical_import_set_updated_at on research.ecclesiastical_import_rows;
create trigger research_ecclesiastical_import_set_updated_at
before update on research.ecclesiastical_import_rows
for each row execute function public.set_updated_at();

insert into research.batches (
  slug,
  dataset,
  title,
  scope_description,
  sequence_order,
  status,
  target_count,
  source_strategy
)
values
  ('saints-existing-audit-01', 'saints', 'Santos existentes — auditoria 1', 'Primeiros 25 registros pela quantidade de lacunas e cronologia.', 10, 'ready', 25, 'Fontes oficiais da Santa Sé primeiro; fontes secundárias confiáveis apenas para complementar.'),
  ('saints-existing-audit-02', 'saints', 'Santos existentes — auditoria 2', 'Registros 26 a 50 pela quantidade de lacunas e cronologia.', 20, 'planned', 25, 'Fontes oficiais da Santa Sé primeiro; fontes secundárias confiáveis apenas para complementar.'),
  ('saints-existing-audit-03', 'saints', 'Santos existentes — auditoria 3', 'Registros 51 a 75 pela quantidade de lacunas e cronologia.', 30, 'planned', 25, 'Fontes oficiais da Santa Sé primeiro; fontes secundárias confiáveis apenas para complementar.'),
  ('saints-existing-audit-04', 'saints', 'Santos existentes — auditoria 4', 'Registros 76 a 93 pela quantidade de lacunas e cronologia.', 40, 'planned', 18, 'Fontes oficiais da Santa Sé primeiro; fontes secundárias confiáveis apenas para complementar.'),
  ('ecclesiastical-africa-01', 'ecclesiastical_jurisdictions', 'Circunscrições eclesiásticas — África', 'Circunscrições católicas da África; paróquias e locais físicos entram em fases posteriores.', 110, 'planned', 554, 'Annuario Pontificio como cadastro canônico; estatísticas Fides como conferência agregada.'),
  ('ecclesiastical-americas-01', 'ecclesiastical_jurisdictions', 'Circunscrições eclesiásticas — Américas', 'Circunscrições católicas das Américas; paróquias e locais físicos entram em fases posteriores.', 120, 'planned', 1102, 'Annuario Pontificio como cadastro canônico; estatísticas Fides como conferência agregada.'),
  ('ecclesiastical-asia-01', 'ecclesiastical_jurisdictions', 'Circunscrições eclesiásticas — Ásia', 'Circunscrições católicas da Ásia; paróquias e locais físicos entram em fases posteriores.', 130, 'planned', 545, 'Annuario Pontificio como cadastro canônico; estatísticas Fides como conferência agregada.'),
  ('ecclesiastical-europe-01', 'ecclesiastical_jurisdictions', 'Circunscrições eclesiásticas — Europa', 'Circunscrições católicas da Europa; paróquias e locais físicos entram em fases posteriores.', 140, 'planned', 759, 'Annuario Pontificio como cadastro canônico; estatísticas Fides como conferência agregada.'),
  ('ecclesiastical-oceania-01', 'ecclesiastical_jurisdictions', 'Circunscrições eclesiásticas — Oceania', 'Circunscrições católicas da Oceania; paróquias e locais físicos entram em fases posteriores.', 150, 'planned', 81, 'Annuario Pontificio como cadastro canônico; estatísticas Fides como conferência agregada.')
on conflict (slug) do update
set
  title = excluded.title,
  scope_description = excluded.scope_description,
  sequence_order = excluded.sequence_order,
  target_count = excluded.target_count,
  source_strategy = excluded.source_strategy;

with audited as (
  select
    saints.id as saint_id,
    saints.death_year,
    array_remove(array[
      case when nullif(trim(saints.biography), '') is null then 'biography' end,
      case when nullif(trim(saints.feast_day), '') is null then 'feast_day' end,
      case when saints.canonization_year is null
             and nullif(trim(saints.canonization_note), '') is null
        then 'canonization_context' end,
      case when nullif(trim(saints.image_url), '') is null then 'image' end,
      case when nullif(trim(saints.category), '') is null then 'category' end,
      case when nullif(trim(saints.sources), '') is null then 'legacy_sources' end
    ]::text[], null) as missing_fields
  from public.saints
  where saints.is_published
),
ranked as (
  select
    audited.*,
    row_number() over (
      order by cardinality(audited.missing_fields) desc,
               audited.death_year nulls last,
               audited.saint_id
    ) as row_number
  from audited
),
assigned as (
  select
    ranked.*,
    'saints-existing-audit-' || lpad((((ranked.row_number - 1) / 25) + 1)::text, 2, '0') as batch_slug
  from ranked
)
insert into research.saint_reviews (
  saint_id,
  batch_id,
  priority,
  missing_fields
)
select
  assigned.saint_id,
  batches.id,
  case
    when cardinality(assigned.missing_fields) >= 5 then 1
    when cardinality(assigned.missing_fields) >= 3 then 2
    else 3
  end,
  assigned.missing_fields
from assigned
join research.batches
  on batches.slug = assigned.batch_slug
on conflict (saint_id) do update
set
  batch_id = excluded.batch_id,
  priority = excluded.priority,
  missing_fields = excluded.missing_fields,
  updated_at = now();

insert into research.batch_sources (batch_id, source_id, purpose)
select
  batches.id,
  sources.id,
  case
    when sources.url like '%causesanti%' or sources.url like '%csaints%'
      then 'Atos e documentação oficial de canonização.'
    when sources.url like '%index_saints%'
      then 'Biografias e celebrações pontifícias oficiais.'
    else 'Calendário litúrgico e atualizações do Martirológio Romano.'
  end
from research.batches
cross join public.research_sources as sources
where batches.dataset = 'saints'
  and sources.url in (
    'https://www.vatican.va/roman_curia/congregations/csaints/index.htm',
    'https://www.vatican.va/news_services/liturgy/documents/index_saints_en.html',
    'https://www.vatican.va/content/romancuria/en/dicasteri/dicastero-culto-divino-e-disciplina-sacramenti/documenti.html'
  )
on conflict (batch_id, source_id) do update
set purpose = excluded.purpose;

insert into research.batch_sources (batch_id, source_id, purpose)
select
  batches.id,
  sources.id,
  case
    when sources.url like '%Statistics%202025.pdf'
      then 'Meta agregada e conferência de cobertura continental.'
    else 'Cadastro canônico atualizado das circunscrições; acesso depende de assinatura e termos.'
  end
from research.batches
cross join public.research_sources as sources
where batches.dataset = 'ecclesiastical_jurisdictions'
  and sources.url in (
    'https://press.vatican.va/content/dam/salastampa/it/fuori-bollettino/pdf/EN%20-%20Catholic%20Church%20Statistics%202025.pdf',
    'https://www.annuariopontificio.catholic/'
  )
on conflict (batch_id, source_id) do update
set purpose = excluded.purpose;

comment on schema research is
  'Área interna de triagem e revisão; não exposta ao Data API nem usada diretamente pelo frontend.';

comment on table research.saint_reviews is
  'Checklist dos santos existentes. Publicação exige pesquisa e revisão humana antes de atualizar public.saints.';

comment on table research.ecclesiastical_import_rows is
  'Staging de importação. Nenhuma linha aparece no mapa até ser validada e promovida às tabelas públicas.';
