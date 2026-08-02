-- Permite que a busca publica leve o mapa ate a igreja principal da paroquia.
-- As coordenadas continuam vindo apenas de locais publicados e respeitam RLS
-- porque a view usa os privilegios de quem a consulta.

begin;

create or replace view public.parish_search_catalog
with (security_invoker = true)
as
select
  jurisdictions.id,
  jurisdictions.name,
  sites.locality,
  sites.admin_area,
  jurisdictions.country_code,
  public.normalize_catalog_text(
    concat_ws(
      ' ',
      jurisdictions.name,
      sites.locality,
      sites.admin_area,
      jurisdictions.country_code
    )
  ) as search_text,
  sites.latitude,
  sites.longitude
from public.ecclesiastical_jurisdictions as jurisdictions
left join lateral (
  select
    ecclesiastical_sites.locality,
    ecclesiastical_sites.admin_area,
    extensions.st_y(
      ecclesiastical_sites.location::extensions.geometry
    ) as latitude,
    extensions.st_x(
      ecclesiastical_sites.location::extensions.geometry
    ) as longitude
  from public.ecclesiastical_sites
  where ecclesiastical_sites.jurisdiction_id = jurisdictions.id
    and ecclesiastical_sites.is_published
  order by ecclesiastical_sites.is_primary desc, ecclesiastical_sites.id
  limit 1
) as sites on true
where jurisdictions.canonical_type in ('parish', 'quasi_parish')
  and jurisdictions.is_published;

grant select on public.parish_search_catalog to anon, authenticated;

comment on view public.parish_search_catalog is
  'Catalogo publico normalizado de paroquias publicadas, com localidade e coordenadas do local principal para busca e navegacao no mapa.';

commit;
