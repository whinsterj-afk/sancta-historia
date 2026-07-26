-- Arquiva pontos importados dos dez cadastros duplicados.
-- Os pontos permanecem no banco para auditoria, mas deixam de compor a view pública.

begin;

insert into public.trajectory_migration_exclusions (source_location_id, reason)
values
  (159, 'Ponto de São Pedro Apóstolo; a trajetória canônica de São Pedro já contém versão editorial equivalente.'),
  (160, 'Ponto de São Pedro Apóstolo; a trajetória canônica de São Pedro já contém versão editorial equivalente.'),
  (161, 'Ponto de São Pedro Apóstolo; a trajetória canônica de São Pedro já contém versão editorial equivalente.'),
  (162, 'Ponto de São Paulo Apóstolo; a trajetória canônica de São Paulo já contém versão editorial equivalente.'),
  (163, 'Ponto de São Paulo Apóstolo; a trajetória canônica de São Paulo já contém versão editorial equivalente.'),
  (164, 'Ponto de São Paulo Apóstolo; a trajetória canônica de São Paulo já contém versão editorial equivalente.'),
  (175, 'Ponto de Santo Ambrósio; a trajetória canônica de Santo Ambrósio de Milão já contém versão editorial equivalente.'),
  (176, 'Ponto de Santo Ambrósio; a trajetória canônica de Santo Ambrósio de Milão já contém versão editorial equivalente.'),
  (182, 'Ponto de Santo Antão; a trajetória canônica de Santo Antão do Deserto já contém versão editorial equivalente.'),
  (183, 'Ponto de Santo Antão; a trajetória canônica de Santo Antão do Deserto já contém versão editorial equivalente.')
on conflict (source_location_id)
do update set
  reason = excluded.reason,
  reviewed_at = excluded.reviewed_at;

update public.saint_trajectory_points
set
  is_published = false,
  updated_at = now()
where source_location_ids && array[
  159, 160, 161, 162, 163, 164, 175, 176, 182, 183
]::bigint[];

drop policy if exists "Public read reviewed legacy locations"
  on public.locations;
create policy "Public read reviewed legacy locations"
on public.locations
for select
to anon, authenticated
using (
  not (
    locations.id = any(
      array[
        17, 18, 19, 20,
        159, 160, 161, 162, 163, 164,
        165, 166, 167, 168, 169, 170, 171, 172, 173, 174,
        175, 176, 177, 178, 179, 180, 181, 182, 183,
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

commit;

select
  (select count(*) from public.saint_trajectory_points) as preserved_trajectory_points,
  (select count(*) from public.timeline_saint_points) as published_trajectory_points,
  (select count(*) from public.trajectory_migration_exclusions) as excluded_legacy_points;
