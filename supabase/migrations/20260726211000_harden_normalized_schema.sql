-- Endurece funções públicas e completa os índices das relações de fontes.

begin;

alter function public.normalize_catalog_text(text)
  set search_path = pg_catalog;

alter function public.set_updated_at()
  set search_path = pg_catalog;

create index if not exists saint_source_citations_source_id_idx
  on public.saint_source_citations(source_id);

create index if not exists trajectory_source_citations_source_id_idx
  on public.trajectory_source_citations(source_id);

commit;
