create index ecclesiastical_sites_location_geometry_gix
  on public.ecclesiastical_sites
  using gist ((location::extensions.geometry));
