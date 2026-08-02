-- Catálogo público de busca de paróquias.
-- Reutiliza a normalização já aplicada à busca de santos para aceitar
-- consultas sem acentos e inclui cidade/estado para diferenciar homônimas.

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
  ) as search_text
from public.ecclesiastical_jurisdictions as jurisdictions
left join lateral (
  select
    ecclesiastical_sites.locality,
    ecclesiastical_sites.admin_area
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
  'Catálogo público normalizado de paróquias publicadas, com cidade e estado para busca e desambiguação.';

commit;
