-- Sancta Historia
-- Normaliza lugares e trajetórias sem apagar os dados legados.
-- A migração é idempotente e mantém cópias de segurança das tabelas de origem.

begin;

do $backups$
begin
  execute 'create schema if not exists sancta_historia_backups';

  if to_regclass(
    'sancta_historia_backups.saints_before_normalization_20260726'
  ) is null then
    execute $sql$
      create table
        sancta_historia_backups.saints_before_normalization_20260726
      as
      select now() as backed_up_at, saints.*
      from public.saints
    $sql$;
  end if;

  if to_regclass(
    'sancta_historia_backups.locations_before_normalization_20260726'
  ) is null then
    execute $sql$
      create table
        sancta_historia_backups.locations_before_normalization_20260726
      as
      select now() as backed_up_at, locations.*
      from public.locations
    $sql$;
  end if;
end
$backups$;

create or replace function public.normalize_catalog_text(input_value text)
returns text
language sql
immutable
strict
parallel safe
as $function$
  select trim(
    regexp_replace(
      translate(
        lower(input_value),
        'áàâãäéèêëíìîïóòôõöúùûüçñýÿ',
        'aaaaaeeeeiiiiooooouuuucnyy'
      ),
      '[^a-z0-9]+',
      ' ',
      'g'
    )
  );
$function$;

alter table public.saints
  add column if not exists slug text,
  add column if not exists canonical_saint_id bigint,
  add column if not exists is_published boolean not null default true;

do $constraints$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'saints_canonical_saint_id_fkey'
      and conrelid = 'public.saints'::regclass
  ) then
    alter table public.saints
      add constraint saints_canonical_saint_id_fkey
      foreign key (canonical_saint_id)
      references public.saints(id)
      on delete restrict;
  end if;

  if not exists (
    select 1
    from pg_constraint
    where conname = 'saints_canonical_saint_is_not_self'
      and conrelid = 'public.saints'::regclass
  ) then
    alter table public.saints
      add constraint saints_canonical_saint_is_not_self
      check (canonical_saint_id is null or canonical_saint_id <> id);
  end if;
end
$constraints$;

do $validate_duplicates$
declare
  mismatched_records text;
begin
  with expected(id, name) as (
    values
      (2::bigint, 'São Pedro'),
      (3::bigint, 'São Paulo'),
      (4::bigint, 'Santo Agostinho de Hipona'),
      (5::bigint, 'São Bento de Núrsia'),
      (11::bigint, 'São Policarpo de Esmirna'),
      (15::bigint, 'Santo Atanásio de Alexandria'),
      (17::bigint, 'São Gregório Nazianzeno'),
      (20::bigint, 'Santo Agostinho'),
      (22::bigint, 'São Bento'),
      (69::bigint, 'São Clemente I'),
      (74::bigint, 'Santo Antão do Deserto'),
      (77::bigint, 'Santo Ambrósio de Milão'),
      (85::bigint, 'São Pedro Apóstolo'),
      (93::bigint, 'São Paulo Apóstolo'),
      (100::bigint, 'São Clemente Romano'),
      (102::bigint, 'São Policarpo'),
      (114::bigint, 'Santo Antão'),
      (116::bigint, 'Santo Atanásio'),
      (118::bigint, 'São Gregório de Nazianzo'),
      (120::bigint, 'Santo Ambrósio')
  )
  select string_agg(
    format(
      'id %s: esperado "%s", encontrado "%s"',
      expected.id,
      expected.name,
      coalesce(saints.name, '<ausente>')
    ),
    '; '
  )
  into mismatched_records
  from expected
  left join public.saints as saints using (id)
  where saints.name is distinct from expected.name;

  if mismatched_records is not null then
    raise exception
      'Migração interrompida porque os registros de santos mudaram: %',
      mismatched_records;
  end if;
end
$validate_duplicates$;

with duplicate_map(duplicate_id, canonical_id) as (
  values
    (20::bigint, 4::bigint),
    (22::bigint, 5::bigint),
    (85::bigint, 2::bigint),
    (93::bigint, 3::bigint),
    (100::bigint, 69::bigint),
    (102::bigint, 11::bigint),
    (114::bigint, 74::bigint),
    (116::bigint, 15::bigint),
    (118::bigint, 17::bigint),
    (120::bigint, 77::bigint)
)
update public.saints as saints
set
  canonical_saint_id = duplicate_map.canonical_id,
  is_published = false
from duplicate_map
where saints.id = duplicate_map.duplicate_id;

with ranked as (
  select
    id,
    regexp_replace(public.normalize_catalog_text(name), ' ', '-', 'g') as base_slug,
    row_number() over (
      partition by public.normalize_catalog_text(name)
      order by id
    ) as duplicate_number
  from public.saints
)
update public.saints as saints
set slug = case
  when ranked.duplicate_number = 1 then ranked.base_slug
  else ranked.base_slug || '-' || saints.id
end
from ranked
where ranked.id = saints.id
  and (
    saints.slug is null
    or trim(saints.slug) = ''
  );

create unique index if not exists saints_canonical_slug_key
  on public.saints(slug)
  where canonical_saint_id is null;

create index if not exists saints_canonical_saint_id_idx
  on public.saints(canonical_saint_id);

create index if not exists saints_published_lifetime_idx
  on public.saints(birth_year, death_year)
  where is_published and canonical_saint_id is null;

create table if not exists public.saint_aliases (
  id bigint generated by default as identity primary key,
  saint_id bigint not null
    references public.saints(id)
    on delete cascade,
  alias text not null,
  normalized_alias text generated always as (
    public.normalize_catalog_text(alias)
  ) stored,
  source_saint_id bigint
    references public.saints(id)
    on delete restrict,
  created_at timestamp with time zone not null default now(),
  constraint saint_aliases_nonempty
    check (trim(alias) <> '')
);

create unique index if not exists saint_aliases_normalized_alias_key
  on public.saint_aliases(normalized_alias);

create unique index if not exists saint_aliases_source_saint_id_key
  on public.saint_aliases(source_saint_id)
  where source_saint_id is not null;

create index if not exists saint_aliases_saint_id_idx
  on public.saint_aliases(saint_id);

insert into public.saint_aliases (saint_id, alias, source_saint_id)
select canonical.id, duplicate.name, duplicate.id
from (
  values
    (20::bigint, 4::bigint),
    (22::bigint, 5::bigint),
    (85::bigint, 2::bigint),
    (93::bigint, 3::bigint),
    (100::bigint, 69::bigint),
    (102::bigint, 11::bigint),
    (114::bigint, 74::bigint),
    (116::bigint, 15::bigint),
    (118::bigint, 17::bigint),
    (120::bigint, 77::bigint)
) as duplicate_map(duplicate_id, canonical_id)
join public.saints as duplicate on duplicate.id = duplicate_map.duplicate_id
join public.saints as canonical on canonical.id = duplicate_map.canonical_id
on conflict (source_saint_id) where source_saint_id is not null
do update set
  saint_id = excluded.saint_id,
  alias = excluded.alias;

create table if not exists public.places (
  id bigint generated by default as identity primary key,
  name text not null,
  normalized_name text generated always as (
    public.normalize_catalog_text(name)
  ) stored,
  latitude double precision,
  longitude double precision,
  country_code text,
  region text,
  place_type text not null default 'city',
  source_location_ids bigint[] not null default '{}',
  is_published boolean not null default true,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now(),
  constraint places_name_nonempty
    check (trim(name) <> ''),
  constraint places_latitude_range
    check (latitude is null or latitude between -90 and 90),
  constraint places_longitude_range
    check (longitude is null or longitude between -180 and 180),
  constraint places_coordinates_complete
    check ((latitude is null) = (longitude is null)),
  constraint places_country_code_format
    check (country_code is null or country_code ~ '^[A-Z]{2}$'),
  constraint places_type_values
    check (place_type in ('city', 'region', 'country', 'sanctuary', 'monastery', 'other'))
);

create unique index if not exists places_normalized_name_key
  on public.places(normalized_name);

create index if not exists places_published_name_idx
  on public.places(name)
  where is_published;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $function$
begin
  new.updated_at = now();
  return new;
end
$function$;

drop trigger if exists places_set_updated_at on public.places;
create trigger places_set_updated_at
before update on public.places
for each row
execute function public.set_updated_at();

create table if not exists public.saint_trajectory_points (
  id bigint generated by default as identity primary key,
  saint_id bigint not null
    references public.saints(id)
    on delete restrict,
  place_id bigint not null
    references public.places(id)
    on delete restrict,
  sequence_order integer not null,
  start_year integer,
  end_year integer,
  date_precision text not null default 'unknown',
  historical_certainty text not null default 'unknown',
  description text,
  source_location_ids bigint[] not null default '{}',
  legacy_key text,
  is_published boolean not null default true,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now(),
  constraint saint_trajectory_points_sequence_positive
    check (sequence_order > 0),
  constraint saint_trajectory_points_period_valid
    check (start_year is null or end_year is null or start_year <= end_year),
  constraint saint_trajectory_points_date_precision_values
    check (date_precision in ('exact', 'year', 'approximate', 'range', 'unknown')),
  constraint saint_trajectory_points_certainty_values
    check (historical_certainty in ('documented', 'probable', 'traditional', 'disputed', 'unknown'))
);

create unique index if not exists saint_trajectory_points_legacy_key_key
  on public.saint_trajectory_points(legacy_key)
  where legacy_key is not null;

create index if not exists saint_trajectory_points_saint_period_idx
  on public.saint_trajectory_points(
    saint_id,
    start_year,
    end_year,
    sequence_order
  )
  where is_published;

create index if not exists saint_trajectory_points_place_id_idx
  on public.saint_trajectory_points(place_id);

drop trigger if exists saint_trajectory_points_set_updated_at
  on public.saint_trajectory_points;
create trigger saint_trajectory_points_set_updated_at
before update on public.saint_trajectory_points
for each row
execute function public.set_updated_at();

create table if not exists public.research_sources (
  id bigint generated by default as identity primary key,
  title text not null,
  author text,
  publisher text,
  publication_year integer,
  url text,
  citation text,
  source_type text not null default 'other',
  created_at timestamp with time zone not null default now(),
  constraint research_sources_title_nonempty
    check (trim(title) <> ''),
  constraint research_sources_type_values
    check (source_type in ('scripture', 'patristic', 'magisterium', 'book', 'article', 'archive', 'website', 'other'))
);

create table if not exists public.saint_source_citations (
  saint_id bigint not null
    references public.saints(id)
    on delete cascade,
  source_id bigint not null
    references public.research_sources(id)
    on delete restrict,
  citation_note text,
  primary key (saint_id, source_id)
);

create table if not exists public.trajectory_source_citations (
  trajectory_point_id bigint not null
    references public.saint_trajectory_points(id)
    on delete cascade,
  source_id bigint not null
    references public.research_sources(id)
    on delete restrict,
  citation_note text,
  primary key (trajectory_point_id, source_id)
);

create table if not exists public.trajectory_migration_exclusions (
  source_location_id bigint primary key
    references public.locations(id)
    on delete restrict,
  reason text not null,
  reviewed_at timestamp with time zone not null default now()
);

insert into public.trajectory_migration_exclusions (source_location_id, reason)
values
  (17, 'Registro de Santa Clara copiado para Santo Antônio de Pádua.'),
  (18, 'Registro de Santo Antônio de Pádua copiado para São Boaventura.'),
  (19, 'Registro de Santo Antônio de Pádua copiado para São Boaventura.'),
  (20, 'Registro de Santo Antônio de Pádua copiado para São Boaventura.'),
  (165, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (166, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (167, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (168, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (169, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (170, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (171, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (172, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (173, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (174, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (177, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (178, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (179, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (180, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (181, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (185, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (186, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (187, 'Duplicação posterior de um ponto já presente na trajetória editorial.'),
  (188, 'Duplicação posterior de um ponto já presente na trajetória editorial.')
on conflict (source_location_id)
do update set
  reason = excluded.reason,
  reviewed_at = excluded.reviewed_at;

with clean_locations as (
  select
    locations.*,
    public.normalize_catalog_text(locations.location_name) as place_key
  from public.locations
  where not exists (
    select 1
    from public.trajectory_migration_exclusions as exclusions
    where exclusions.source_location_id = locations.id
  )
),
place_groups as (
  select
    place_key,
    min(id) as representative_id,
    array_agg(id order by id) as source_location_ids
  from clean_locations
  group by place_key
)
insert into public.places (
  name,
  latitude,
  longitude,
  source_location_ids
)
select
  representative.location_name,
  representative.latitude::double precision,
  representative.longitude::double precision,
  place_groups.source_location_ids
from place_groups
join clean_locations as representative
  on representative.id = place_groups.representative_id
on conflict (normalized_name)
do update set
  source_location_ids = (
    select array_agg(distinct source_id order by source_id)
    from unnest(
      public.places.source_location_ids || excluded.source_location_ids
    ) as source_id
  ),
  updated_at = now();

with duplicate_map(duplicate_id, canonical_id) as (
  values
    (20::bigint, 4::bigint),
    (22::bigint, 5::bigint),
    (85::bigint, 2::bigint),
    (93::bigint, 3::bigint),
    (100::bigint, 69::bigint),
    (102::bigint, 11::bigint),
    (114::bigint, 74::bigint),
    (116::bigint, 15::bigint),
    (118::bigint, 17::bigint),
    (120::bigint, 77::bigint)
),
clean_locations as (
  select
    locations.*,
    coalesce(duplicate_map.canonical_id, locations.saint_id) as canonical_saint_id,
    public.normalize_catalog_text(locations.location_name) as place_key
  from public.locations
  left join duplicate_map
    on duplicate_map.duplicate_id = locations.saint_id
  where locations.saint_id is not null
    and not exists (
      select 1
      from public.trajectory_migration_exclusions as exclusions
      where exclusions.source_location_id = locations.id
    )
),
trajectory_groups as (
  select
    canonical_saint_id as saint_id,
    place_key,
    start_year,
    end_year,
    min(id) as first_source_location_id,
    array_agg(id order by id) as source_location_ids,
    string_agg(
      distinct nullif(trim(description), ''),
      E'\n\n'
      order by nullif(trim(description), '')
    ) as description
  from clean_locations
  group by
    canonical_saint_id,
    place_key,
    start_year,
    end_year
),
ordered_trajectories as (
  select
    trajectory_groups.*,
    row_number() over (
      partition by saint_id
      order by
        start_year nulls last,
        end_year nulls last,
        first_source_location_id
    )::integer as sequence_order
  from trajectory_groups
)
insert into public.saint_trajectory_points (
  saint_id,
  place_id,
  sequence_order,
  start_year,
  end_year,
  date_precision,
  historical_certainty,
  description,
  source_location_ids,
  legacy_key
)
select
  ordered_trajectories.saint_id,
  places.id,
  ordered_trajectories.sequence_order,
  ordered_trajectories.start_year,
  ordered_trajectories.end_year,
  case
    when ordered_trajectories.start_year is null
      or ordered_trajectories.end_year is null
      then 'unknown'
    when ordered_trajectories.start_year = ordered_trajectories.end_year
      then 'year'
    else 'range'
  end,
  'unknown',
  ordered_trajectories.description,
  ordered_trajectories.source_location_ids,
  md5(
    concat_ws(
      '|',
      ordered_trajectories.saint_id,
      ordered_trajectories.place_key,
      coalesce(ordered_trajectories.start_year::text, ''),
      coalesce(ordered_trajectories.end_year::text, '')
    )
  )
from ordered_trajectories
join public.places
  on places.normalized_name = ordered_trajectories.place_key
on conflict (legacy_key) where legacy_key is not null
do update set
  saint_id = excluded.saint_id,
  place_id = excluded.place_id,
  sequence_order = excluded.sequence_order,
  start_year = excluded.start_year,
  end_year = excluded.end_year,
  date_precision = excluded.date_precision,
  description = excluded.description,
  source_location_ids = excluded.source_location_ids,
  updated_at = now();

create or replace view public.saints_catalog
with (security_invoker = true)
as
select saints.*
from public.saints
where saints.is_published
  and saints.canonical_saint_id is null;

create or replace view public.saint_search_catalog
with (security_invoker = true)
as
select
  saints.id,
  saints.name,
  saints.birth_year,
  saints.death_year,
  saints.short_description,
  public.normalize_catalog_text(
    concat_ws(
      ' ',
      saints.name,
      string_agg(aliases.alias, ' ' order by aliases.alias)
    )
  ) as search_text
from public.saints as saints
left join public.saint_aliases as aliases
  on aliases.saint_id = saints.id
where saints.is_published
  and saints.canonical_saint_id is null
group by
  saints.id,
  saints.name,
  saints.birth_year,
  saints.death_year,
  saints.short_description;

create or replace view public.timeline_saint_points
with (security_invoker = true)
as
select
  trajectory.id,
  trajectory.saint_id,
  places.name as location_name,
  places.latitude,
  places.longitude,
  trajectory.start_year,
  trajectory.end_year,
  trajectory.description,
  trajectory.sequence_order,
  trajectory.date_precision,
  trajectory.historical_certainty,
  trajectory.source_location_ids
from public.saint_trajectory_points as trajectory
join public.places
  on places.id = trajectory.place_id
join public.saints
  on saints.id = trajectory.saint_id
where trajectory.is_published
  and places.is_published
  and saints.is_published
  and saints.canonical_saint_id is null;

alter table public.saint_aliases enable row level security;
alter table public.places enable row level security;
alter table public.saint_trajectory_points enable row level security;
alter table public.research_sources enable row level security;
alter table public.saint_source_citations enable row level security;
alter table public.trajectory_source_citations enable row level security;
alter table public.trajectory_migration_exclusions enable row level security;

drop policy if exists "Public read saints" on public.saints;
drop policy if exists "Public read published saints" on public.saints;
create policy "Public read published saints"
on public.saints
for select
to anon, authenticated
using (is_published and canonical_saint_id is null);

drop policy if exists "Public read locations" on public.locations;
drop policy if exists "Public read reviewed legacy locations" on public.locations;
create policy "Public read reviewed legacy locations"
on public.locations
for select
to anon, authenticated
using (
  not (
    locations.id = any(
      array[
        17, 18, 19, 20,
        165, 166, 167, 168, 169, 170, 171, 172, 173, 174,
        177, 178, 179, 180, 181,
        185, 186, 187, 188
      ]::bigint[]
    )
  )
  and exists (
    select 1
    from public.saints
    where saints.id = locations.saint_id
      and saints.is_published
      and saints.canonical_saint_id is null
  )
);

drop policy if exists "Public read saint aliases" on public.saint_aliases;
create policy "Public read saint aliases"
on public.saint_aliases
for select
to anon, authenticated
using (
  exists (
    select 1
    from public.saints
    where saints.id = saint_aliases.saint_id
      and saints.is_published
      and saints.canonical_saint_id is null
  )
);

drop policy if exists "Public read places" on public.places;
create policy "Public read places"
on public.places
for select
to anon, authenticated
using (is_published);

drop policy if exists "Public read trajectory points"
  on public.saint_trajectory_points;
create policy "Public read trajectory points"
on public.saint_trajectory_points
for select
to anon, authenticated
using (
  is_published
  and exists (
    select 1
    from public.saints
    where saints.id = saint_trajectory_points.saint_id
      and saints.is_published
      and saints.canonical_saint_id is null
  )
);

grant select on public.saints_catalog to anon, authenticated;
grant select on public.saint_search_catalog to anon, authenticated;
grant select on public.timeline_saint_points to anon, authenticated;
grant select on public.saint_aliases to anon, authenticated;
grant select on public.places to anon, authenticated;
grant select on public.saint_trajectory_points to anon, authenticated;

comment on table public.locations is
  'Tabela legada preservada para auditoria. Novas leituras usam timeline_saint_points.';
comment on table public.saint_locations is
  'Tabela legada não utilizada. O relacionamento normalizado está em saint_trajectory_points.';
comment on table public.places is
  'Catálogo canônico de lugares geográficos, independente de santos e períodos.';
comment on table public.saint_trajectory_points is
  'Passagens históricas que ligam santos a lugares canônicos e períodos.';
comment on view public.timeline_saint_points is
  'Fonte pública única para o mapa histórico e os detalhes de trajetória.';

commit;

select
  (select count(*) from public.saints) as saints_preserved,
  (select count(*) from public.saints_catalog) as canonical_saints,
  (select count(*) from public.saint_aliases) as saint_aliases,
  (select count(*) from public.places) as canonical_places,
  (select count(*) from public.saint_trajectory_points) as trajectory_points,
  (select count(*) from public.trajectory_migration_exclusions) as excluded_legacy_points;
