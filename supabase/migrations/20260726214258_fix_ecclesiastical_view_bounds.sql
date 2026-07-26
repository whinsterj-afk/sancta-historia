create or replace function public.ecclesiastical_points_in_view(
  min_long double precision,
  min_lat double precision,
  max_long double precision,
  max_lat double precision,
  map_zoom double precision,
  selected_year integer default null
)
returns table (
  id bigint,
  name text,
  site_type text,
  canonical_type text,
  jurisdiction_name text,
  latitude double precision,
  longitude double precision,
  address text,
  locality text,
  country_code text,
  official_url text,
  min_zoom real
)
language sql
stable
security invoker
set search_path = ''
as $$
  select
    site.id,
    site.name,
    site.site_type,
    jurisdiction.canonical_type,
    jurisdiction.name as jurisdiction_name,
    extensions.st_y(site.location::extensions.geometry) as latitude,
    extensions.st_x(site.location::extensions.geometry) as longitude,
    site.address,
    site.locality,
    site.country_code,
    coalesce(site.official_url, jurisdiction.official_url) as official_url,
    site.min_zoom
  from public.ecclesiastical_sites as site
  join public.ecclesiastical_jurisdictions as jurisdiction
    on jurisdiction.id = site.jurisdiction_id
  where site.is_published
    and jurisdiction.is_published
    and site.min_zoom <= map_zoom
    and (
      selected_year is null
      or (
        (site.valid_from_year is null or site.valid_from_year <= selected_year)
        and (site.valid_to_year is null or site.valid_to_year >= selected_year)
        and (
          jurisdiction.erected_year is null
          or jurisdiction.erected_year <= selected_year
        )
        and (
          jurisdiction.suppressed_year is null
          or jurisdiction.suppressed_year >= selected_year
        )
      )
    )
    and site.location::extensions.geometry operator(extensions.&&)
      extensions.st_setsrid(
        extensions.st_makebox2d(
          extensions.st_point(min_long, min_lat),
          extensions.st_point(max_long, max_lat)
        ),
        4326
      )
  order by site.display_rank, site.min_zoom, site.name
  limit 750
$$;
