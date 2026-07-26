-- Proposed field values stay private until research and editorial review are
-- complete. Sources are linked independently so one synthesis may cite more
-- than one document.

create table if not exists research.saint_revision_drafts (
  id bigint generated always as identity primary key,
  saint_id bigint not null
    references public.saints(id)
    on delete cascade,
  batch_id bigint not null
    references research.batches(id)
    on delete restrict,
  field_name text not null,
  proposed_value jsonb not null,
  rationale text,
  status text not null default 'draft',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (saint_id, field_name),
  constraint research_saint_revision_field_values
    check (field_name in (
      'name',
      'birth_year',
      'death_year',
      'birth_place',
      'death_place',
      'short_description',
      'biography',
      'feast_day',
      'canonization_year',
      'canonization_note',
      'patron_of',
      'religious_order',
      'category',
      'famous_quote',
      'historical_importance',
      'image_url',
      'birth_year_note',
      'death_year_note'
    )),
  constraint research_saint_revision_value_scalar
    check (jsonb_typeof(proposed_value) in ('string', 'number', 'null')),
  constraint research_saint_revision_status_values
    check (status in ('draft', 'researched', 'accepted', 'rejected', 'promoted'))
);

create index if not exists research_saint_revision_batch_status_idx
  on research.saint_revision_drafts (batch_id, status, saint_id);

create table if not exists research.saint_revision_draft_sources (
  draft_id bigint not null
    references research.saint_revision_drafts(id)
    on delete cascade,
  source_id bigint not null
    references public.research_sources(id)
    on delete restrict,
  citation_note text,
  primary key (draft_id, source_id)
);

create index if not exists research_saint_revision_draft_sources_source_id_idx
  on research.saint_revision_draft_sources (source_id);

alter table research.saint_revision_drafts enable row level security;
alter table research.saint_revision_draft_sources enable row level security;

revoke all on research.saint_revision_drafts
  from public, anon, authenticated, service_role;
revoke all on research.saint_revision_draft_sources
  from public, anon, authenticated, service_role;
revoke all on all sequences in schema research
  from public, anon, authenticated, service_role;

drop trigger if exists research_saint_revision_drafts_set_updated_at
  on research.saint_revision_drafts;
create trigger research_saint_revision_drafts_set_updated_at
before update on research.saint_revision_drafts
for each row execute function public.set_updated_at();

comment on table research.saint_revision_drafts is
  'Valores propostos por campo para santos existentes; somente itens aceitos podem ser promovidos para public.saints.';

comment on table research.saint_revision_draft_sources is
  'Fontes que sustentam cada valor proposto, preservadas antes e depois da revisão.';
