create index ecclesiastical_jurisdictions_source_idx
  on public.ecclesiastical_jurisdictions (primary_source_id);
create index ecclesiastical_relations_source_idx
  on public.ecclesiastical_relations (primary_source_id);
create index ecclesiastical_sites_jurisdiction_idx
  on public.ecclesiastical_sites (jurisdiction_id);
create index ecclesiastical_sites_source_idx
  on public.ecclesiastical_sites (primary_source_id);
