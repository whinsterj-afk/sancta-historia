update public.ecclesiastical_sites as site
set
  min_zoom = 3.2,
  display_rank = 10,
  updated_at = now()
from public.ecclesiastical_jurisdictions as jurisdiction
where jurisdiction.id = site.jurisdiction_id
  and jurisdiction.canonical_type in (
    'patriarchate',
    'major_archiepiscopal_church'
  )
  and site.is_primary
  and (
    site.min_zoom is distinct from 3.2::real
    or site.display_rank is distinct from 10
  );
