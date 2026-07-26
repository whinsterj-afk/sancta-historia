-- Separa deslocamentos em vida de lugares ligados ao culto e às relíquias.

begin;

alter table public.saint_trajectory_points
  add column if not exists point_kind text not null default 'life';

do $constraints$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'saint_trajectory_points_kind_values'
      and conrelid = 'public.saint_trajectory_points'::regclass
  ) then
    alter table public.saint_trajectory_points
      add constraint saint_trajectory_points_kind_values
      check (
        point_kind in (
          'life',
          'mission',
          'martyrdom',
          'tradition',
          'relics',
          'posthumous_cult',
          'other'
        )
      );
  end if;
end
$constraints$;

update public.saint_trajectory_points
set point_kind = 'relics'
where source_location_ids && array[62]::bigint[];

update public.saint_trajectory_points
set point_kind = 'posthumous_cult'
where source_location_ids && array[114]::bigint[];

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
  and saints.is_published
  and saints.canonical_saint_id is null;

create or replace view public.saint_heritage_points
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
  and saints.is_published
  and saints.canonical_saint_id is null;

grant select on public.timeline_saint_points to anon, authenticated;
grant select on public.saint_heritage_points to anon, authenticated;

comment on column public.saint_trajectory_points.point_kind is
  'Distingue trajetória em vida, missão, martírio, tradição, relíquias e culto póstumo.';
comment on view public.saint_heritage_points is
  'Locais ligados a relíquias ou culto posteriores à vida do santo.';

commit;

select
  (select count(*) from public.timeline_saint_points) as life_trajectory_points,
  (select count(*) from public.saint_heritage_points) as heritage_points,
  (
    select count(*)
    from public.saint_trajectory_points
    where not is_published
  ) as archived_points;
