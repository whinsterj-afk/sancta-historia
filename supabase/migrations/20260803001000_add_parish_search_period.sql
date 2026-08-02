-- Conserva o ano selecionado ao localizar uma paroquia sempre que ela ja
-- existia naquele periodo. Para paroquias mais novas, a interface avanca
-- apenas ate o primeiro ano em que o marcador pode ser exibido.

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
  sites.longitude,
  case
    when jurisdictions.erected_year is null then sites.valid_from_year
    when sites.valid_from_year is null then jurisdictions.erected_year
    else greatest(jurisdictions.erected_year, sites.valid_from_year)
  end as display_start_year,
  case
    when jurisdictions.suppressed_year is null then sites.valid_to_year
    when sites.valid_to_year is null then jurisdictions.suppressed_year
    else least(jurisdictions.suppressed_year, sites.valid_to_year)
  end as display_end_year
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
    ) as longitude,
    ecclesiastical_sites.valid_from_year,
    ecclesiastical_sites.valid_to_year
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
  'Catalogo publico normalizado de paroquias publicadas, com localidade, coordenadas e intervalo de exibicao do local principal para busca e navegacao no mapa.';

commit;
