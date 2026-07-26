-- Conclui a normalização geográfica e retira estruturas transitórias.
-- A transação aborta antes de qualquer exclusão se a cobertura estiver incompleta.

begin;

select pg_advisory_xact_lock(hashtext('sancta_historia_retire_legacy_geography'));

do $preflight$
declare
  legacy_location_count integer;
  covered_location_count integer;
  missing_location_count integer;
  unknown_location_count integer;
  duplicate_saint_count integer;
  duplicate_alias_count integer;
  duplicate_reference_count integer;
  backup_location_count integer;
  backup_saint_count integer;
begin
  if to_regclass(
    'sancta_historia_backups.locations_before_normalization_20260726'
  ) is null then
    raise exception 'Backup de locations não encontrado; retirada cancelada.';
  end if;

  if to_regclass(
    'sancta_historia_backups.saints_before_normalization_20260726'
  ) is null then
    raise exception 'Backup de saints não encontrado; retirada cancelada.';
  end if;

  select count(*)
  into legacy_location_count
  from public.locations;

  execute
    'select count(*) from sancta_historia_backups.locations_before_normalization_20260726'
  into backup_location_count;

  execute
    'select count(*) from sancta_historia_backups.saints_before_normalization_20260726'
  into backup_saint_count;

  if legacy_location_count <> 174
    or backup_location_count <> legacy_location_count
    or backup_saint_count <> 103 then
    raise exception
      'Contagens de origem/backup divergentes: locations=%, backup_locations=%, backup_saints=%.',
      legacy_location_count,
      backup_location_count,
      backup_saint_count;
  end if;

  with covered as (
    select distinct unnest(source_location_ids)::bigint as location_id
    from public.saint_trajectory_points
    where source_location_ids is not null

    union

    select source_location_id
    from public.trajectory_migration_exclusions
  )
  select
    count(*),
    count(*) filter (where locations.id is null)
  into covered_location_count, unknown_location_count
  from covered
  left join public.locations
    on locations.id = covered.location_id;

  with covered as (
    select distinct unnest(source_location_ids)::bigint as location_id
    from public.saint_trajectory_points
    where source_location_ids is not null

    union

    select source_location_id
    from public.trajectory_migration_exclusions
  )
  select count(*)
  into missing_location_count
  from public.locations
  left join covered
    on covered.location_id = locations.id
  where covered.location_id is null;

  if covered_location_count <> legacy_location_count
    or missing_location_count <> 0
    or unknown_location_count <> 0 then
    raise exception
      'Cobertura incompleta: cobertos=%, locations=%, ausentes=%, desconhecidos=%.',
      covered_location_count,
      legacy_location_count,
      missing_location_count,
      unknown_location_count;
  end if;

  if (select count(*) from public.saint_locations) <> 0 then
    raise exception 'saint_locations contém dados; retirada cancelada.';
  end if;

  select count(*)
  into duplicate_saint_count
  from public.saints
  where canonical_saint_id is not null;

  select count(*)
  into duplicate_alias_count
  from public.saints as duplicates
  join public.saint_aliases as aliases
    on aliases.source_saint_id = duplicates.id
   and aliases.saint_id = duplicates.canonical_saint_id
  where duplicates.canonical_saint_id is not null;

  select
    (
      select count(*)
      from public.saint_trajectory_points
      join public.saints
        on saints.id = saint_trajectory_points.saint_id
      where saints.canonical_saint_id is not null
    )
    +
    (
      select count(*)
      from public.saint_source_citations
      join public.saints
        on saints.id = saint_source_citations.saint_id
      where saints.canonical_saint_id is not null
    )
  into duplicate_reference_count;

  if duplicate_saint_count <> 10
    or duplicate_alias_count <> duplicate_saint_count
    or duplicate_reference_count <> 0 then
    raise exception
      'Consolidação de santos insegura: duplicatas=%, aliases=%, referências=%.',
      duplicate_saint_count,
      duplicate_alias_count,
      duplicate_reference_count;
  end if;

  if (select count(*) from public.saints_catalog) <> 93
    or (select count(*) from public.timeline_saint_points) <> 139
    or (select count(*) from public.saint_heritage_points) <> 2 then
    raise exception 'As views normalizadas não têm as contagens inventariadas.';
  end if;
end
$preflight$;

alter table public.trajectory_migration_exclusions
  add column if not exists source_location_snapshot jsonb;

update public.trajectory_migration_exclusions as exclusions
set source_location_snapshot = to_jsonb(locations)
from public.locations
where locations.id = exclusions.source_location_id
  and exclusions.source_location_snapshot is null;

alter table public.trajectory_migration_exclusions
  alter column source_location_snapshot set not null;

alter table public.trajectory_migration_exclusions
  drop constraint if exists
    trajectory_migration_exclusions_source_location_id_fkey;

alter table public.saint_aliases
  drop constraint if exists saint_aliases_source_saint_id_fkey;

comment on column public.trajectory_migration_exclusions.source_location_id is
  'ID imutável do registro removido de public.locations.';
comment on column public.trajectory_migration_exclusions.source_location_snapshot is
  'Snapshot JSON integral do registro excluído durante a normalização.';
comment on column public.saint_aliases.source_saint_id is
  'ID histórico da linha duplicada removida de public.saints.';

drop view if exists public.saint_search_catalog;
drop view if exists public.timeline_saint_points;
drop view if exists public.saint_heritage_points;
drop view if exists public.saints_catalog;

drop policy if exists "Public read published saints"
  on public.saints;
drop policy if exists "Public read saint aliases"
  on public.saint_aliases;
drop policy if exists "Public read trajectory points"
  on public.saint_trajectory_points;

drop table public.saint_locations;
drop table public.locations;

do $remove_duplicates$
declare
  removed_count integer;
begin
  delete from public.saints
  where canonical_saint_id is not null;

  get diagnostics removed_count = row_count;

  if removed_count <> 10 then
    raise exception 'Quantidade inesperada de duplicatas removidas: %.', removed_count;
  end if;
end
$remove_duplicates$;

drop index if exists public.saints_canonical_saint_id_idx;
drop index if exists public.saints_canonical_slug_key;
drop index if exists public.saints_published_lifetime_idx;

alter table public.saints
  drop constraint if exists saints_canonical_saint_id_fkey,
  drop constraint if exists saints_canonical_saint_is_not_self,
  drop column canonical_saint_id,
  drop column birth_lat,
  drop column birth_lng,
  drop column death_lat,
  drop column death_lng;

create unique index saints_slug_key
  on public.saints(slug)
  where slug is not null;

create index saints_published_lifetime_idx
  on public.saints(birth_year, death_year)
  where is_published;

create view public.saints_catalog
with (security_invoker = true)
as
select
  saints.id,
  saints.name,
  saints.birth_year,
  saints.death_year,
  saints.birth_place,
  saints.death_place,
  saints.short_description,
  saints.biography,
  saints.feast_day,
  saints.canonization_year,
  saints.patron_of,
  saints.image_url,
  saints.religious_order,
  saints.category,
  saints.famous_quote,
  saints.canonization_note,
  saints.historical_importance,
  saints.sources,
  saints.birth_year_note,
  saints.death_year_note,
  saints.slug,
  saints.is_published
from public.saints
where saints.is_published;

create view public.saint_search_catalog
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
from public.saints
left join public.saint_aliases as aliases
  on aliases.saint_id = saints.id
where saints.is_published
group by
  saints.id,
  saints.name,
  saints.birth_year,
  saints.death_year,
  saints.short_description;

create view public.timeline_saint_points
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
  trajectory.source_location_ids,
  trajectory.point_kind
from public.saint_trajectory_points as trajectory
join public.places
  on places.id = trajectory.place_id
join public.saints
  on saints.id = trajectory.saint_id
where trajectory.is_published
  and trajectory.point_kind in (
    'life',
    'mission',
    'martyrdom',
    'tradition'
  )
  and places.is_published
  and saints.is_published;

create view public.saint_heritage_points
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
  trajectory.point_kind,
  trajectory.source_location_ids
from public.saint_trajectory_points as trajectory
join public.places
  on places.id = trajectory.place_id
join public.saints
  on saints.id = trajectory.saint_id
where trajectory.is_published
  and trajectory.point_kind in ('relics', 'posthumous_cult')
  and places.is_published
  and saints.is_published;

create policy "Public read published saints"
on public.saints
for select
to anon, authenticated
using (is_published);

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
  )
);

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
  )
);

grant select on public.saints_catalog to anon, authenticated;
grant select on public.saint_search_catalog to anon, authenticated;
grant select on public.timeline_saint_points to anon, authenticated;
grant select on public.saint_heritage_points to anon, authenticated;

comment on view public.saints_catalog is
  'Catálogo público de santos canônicos e publicados.';
comment on view public.saint_search_catalog is
  'Catálogo público de busca por nome canônico ou alias.';
comment on view public.timeline_saint_points is
  'Pontos publicados pertencentes à trajetória histórica em vida.';
comment on view public.saint_heritage_points is
  'Locais ligados a relíquias ou culto posteriores à vida do santo.';

do $postflight$
begin
  if to_regclass('public.locations') is not null
    or to_regclass('public.saint_locations') is not null then
    raise exception 'As tabelas legadas ainda existem.';
  end if;

  if (select count(*) from public.saints) <> 93
    or (select count(*) from public.saint_aliases) <> 10
    or (select count(*) from public.saint_trajectory_points) <> 151
    or (select count(*) from public.timeline_saint_points) <> 139
    or (select count(*) from public.saint_heritage_points) <> 2
    or (
      select count(*)
      from public.trajectory_migration_exclusions
      where source_location_snapshot is null
    ) <> 0 then
    raise exception 'Validação posterior à retirada falhou.';
  end if;
end
$postflight$;

commit;

select
  (select count(*) from public.saints) as canonical_saints,
  (select count(*) from public.places) as canonical_places,
  (select count(*) from public.timeline_saint_points) as life_trajectory_points,
  (select count(*) from public.saint_heritage_points) as heritage_points,
  to_regclass('public.locations') is null as legacy_locations_removed,
  to_regclass('public.saint_locations') is null as legacy_relations_removed;
