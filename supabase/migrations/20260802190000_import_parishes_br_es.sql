-- Sancta Historia
-- Migração de Paróquias gerada automaticamente a partir de supabase/data/parishes/BR/ES.json
-- Operação idempotente via ON CONFLICT (slug) DO UPDATE

begin;

-- Jurisdiction: Paróquia Nossa Senhora da Vitória (Catedral Metropolitana)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-nossa-senhora-da-vitoria-vitoria-es',
  'Paróquia Nossa Senhora da Vitória (Catedral Metropolitana)',
  'parish',
  'latin',
  'BR',
  'active',
  1551,
  'Catedral Metropolitana de Vitória, sede da Arquidiocese de Vitória do Espírito Santo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral Metropolitana Nossa Senhora da Vitória
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-nossa-senhora-da-vitoria-vitoria-es'),
  'site-catedral-nossa-senhora-da-vitoria-vitoria-es',
  'Catedral Metropolitana Nossa Senhora da Vitória',
  'cathedral',
  'Praça Dom Luiz Scortegagna, s/n - Centro',
  'Vitória',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.3378, -20.3204), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santuário Nossa Senhora da Penha
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-penha-vila-velha-es',
  'Paróquia Santuário Nossa Senhora da Penha',
  'parish',
  'latin',
  'BR',
  'active',
  1558,
  'Santuário de Nossa Senhora da Penha, padroeira do Estado do Espírito Santo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Convento e Santuário de Nossa Senhora da Penha
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-penha-vila-velha-es'),
  'site-convento-da-penha-vila-velha-es',
  'Convento e Santuário de Nossa Senhora da Penha',
  'shrine',
  'R. Vasco Coutinho - Prainha',
  'Vila Velha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.2872, -20.3292), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora do Rosário
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-do-rosario-prainha-vila-velha-es',
  'Paróquia Nossa Senhora do Rosário',
  'parish',
  'latin',
  'BR',
  'active',
  1535,
  'Igreja de Nossa Senhora do Rosário na Prainha, a igreja mais antiga do Brasil em funcionamento (fundada em 1535).',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora do Rosário
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-do-rosario-prainha-vila-velha-es'),
  'site-igreja-nossa-senhora-do-rosario-vila-velha-es',
  'Igreja Matriz Nossa Senhora do Rosário',
  'parish_church',
  'R. Delmar Duarte, s/n - Prainha',
  'Vila Velha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.2895, -20.3275), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santuário Nacional de São José de Anchieta
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-sao-jose-de-anchieta-anchieta-es',
  'Paróquia Santuário Nacional de São José de Anchieta',
  'parish',
  'latin',
  'BR',
  'active',
  1579,
  'Santuário Nacional e Igreja de Nossa Senhora da Assunção onde São José de Anchieta viveu, pregou e faleceu.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Santuário Nacional de São José de Anchieta
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-sao-jose-de-anchieta-anchieta-es'),
  'site-santuario-sao-jose-de-anchieta-anchieta-es',
  'Santuário Nacional de São José de Anchieta',
  'shrine',
  'Praça da Matriz, s/n - Centro',
  'Anchieta',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.6444, -20.8061), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santa Rita de Cássia
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santa-rita-de-cassia-vitoria-es',
  'Paróquia Santa Rita de Cássia',
  'parish',
  'latin',
  'BR',
  'active',
  1945,
  'Paróquia tradicional no bairro Praia do Canto em Vitória.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santa Rita de Cássia
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santa-rita-de-cassia-vitoria-es'),
  'site-paroquia-santa-rita-de-cassia-vitoria-es',
  'Igreja Matriz Santa Rita de Cássia',
  'parish_church',
  'R. Dr. Leão de Oliveira, 11 - Praia do Canto',
  'Vitória',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.2941, -20.3012), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Pedro (Santuário Basílica de Santo Antônio)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santo-antonio-basilica-vitoria-es',
  'Paróquia São Pedro (Santuário Basílica de Santo Antônio)',
  'parish',
  'latin',
  'BR',
  'active',
  1956,
  'Santuário Basílica de Santo Antônio em Vitória, de arquitetura inspirada na Basílica de Santo Antônio de Pádua.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Santuário Basílica de Santo Antônio
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santo-antonio-basilica-vitoria-es'),
  'site-basilica-santo-antonio-vitoria-es',
  'Santuário Basílica de Santo Antônio',
  'shrine',
  'R. Ludovico Pavoni, s/n - Santo Antônio',
  'Vitória',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.354, -20.315), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Sagrada Família
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sagrada-familia-vitoria-es',
  'Paróquia Sagrada Família',
  'parish',
  'latin',
  'BR',
  'active',
  1970,
  'Paróquia Sagrada Família em Jardim da Penha, Vitória.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Sagrada Família
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sagrada-familia-vitoria-es'),
  'site-paroquia-sagrada-familia-vitoria-es',
  'Igreja Matriz Sagrada Família',
  'parish_church',
  'R. Anísio Fernandes Coelho, s/n - Jardim da Penha',
  'Vitória',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.2998, -20.2925), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Ressurreição
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-ressurreicao-vitoria-es',
  'Paróquia Ressurreição',
  'parish',
  'latin',
  'BR',
  'active',
  1978,
  'Paróquia da Ressurreição em Goiabeiras, Vitória.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz da Ressurreição
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-ressurreicao-vitoria-es'),
  'site-paroquia-ressurreicao-vitoria-es',
  'Igreja Matriz da Ressurreição',
  'parish_church',
  'Av. Fernando Ferrari, s/n - Goiabeiras',
  'Vitória',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.301, -20.274), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Conceição
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-conceicao-bento-ferreira-vitoria-es',
  'Paróquia Nossa Senhora da Conceição',
  'parish',
  'latin',
  'BR',
  'active',
  1962,
  'Paróquia Nossa Senhora da Conceição em Bento Ferreira, Vitória.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Conceição
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-conceicao-bento-ferreira-vitoria-es'),
  'site-nossa-senhora-da-conceicao-bento-ferreira-vitoria-es',
  'Igreja Matriz Nossa Senhora da Conceição',
  'parish_church',
  'R. Amélia da Cunha Ornelas, s/n - Bento Ferreira',
  'Vitória',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.315, -20.311), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Camilo de Lellis
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-camilo-de-lellis-vitoria-es',
  'Paróquia São Camilo de Lellis',
  'parish',
  'latin',
  'BR',
  'active',
  1985,
  'Paróquia São Camilo de Lellis em Mata da Praia, Vitória.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Camilo de Lellis
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-camilo-de-lellis-vitoria-es'),
  'site-paroquia-sao-camilo-de-lellis-vitoria-es',
  'Igreja Matriz São Camilo de Lellis',
  'parish_church',
  'Av. Des. Dermeval Lyrio, s/n - Mata da Praia',
  'Vitória',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.292, -20.281), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santa Teresa de Calcutá
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santa-teresa-de-calcuta-itarare-vitoria-es',
  'Paróquia Santa Teresa de Calcutá',
  'parish',
  'latin',
  'BR',
  'active',
  2016,
  'Paróquia Santa Teresa de Calcutá em Itararé, Vitória.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santa Teresa de Calcutá
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santa-teresa-de-calcuta-itarare-vitoria-es'),
  'site-santa-teresa-de-calcuta-itarare-vitoria-es',
  'Igreja Matriz Santa Teresa de Calcutá',
  'parish_church',
  'R. das Palmeiras, s/n - Itararé',
  'Vitória',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.322, -20.305), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Francisco de Assis
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-francisco-de-assis-jardim-da-penha-vitoria-es',
  'Paróquia São Francisco de Assis',
  'parish',
  'latin',
  'BR',
  'active',
  1982,
  'Paróquia São Francisco de Assis em Jardim da Penha, Vitória.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Francisco de Assis
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-francisco-de-assis-jardim-da-penha-vitoria-es'),
  'site-sao-francisco-de-assis-jardim-da-penha-vitoria-es',
  'Igreja Matriz São Francisco de Assis',
  'parish_church',
  'R. Pontes Vieira, s/n - Jardim da Penha',
  'Vitória',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.295, -20.291), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Glória
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-gloria-gloria-vila-velha-es',
  'Paróquia Nossa Senhora da Glória',
  'parish',
  'latin',
  'BR',
  'active',
  1965,
  'Paróquia Nossa Senhora da Glória no bairro Glória em Vila Velha.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Glória
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-gloria-gloria-vila-velha-es'),
  'site-nossa-senhora-da-gloria-gloria-vila-velha-es',
  'Igreja Matriz Nossa Senhora da Glória',
  'parish_church',
  'R. Aurora, s/n - Glória',
  'Vila Velha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.2885, -20.338), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santa Teresa de Calcutá
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santa-teresa-de-calcuta-itaparica-vila-velha-es',
  'Paróquia Santa Teresa de Calcutá',
  'parish',
  'latin',
  'BR',
  'active',
  2017,
  'Paróquia Santa Teresa de Calcutá em Itaparica, Vila Velha.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santa Teresa de Calcutá
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santa-teresa-de-calcuta-itaparica-vila-velha-es'),
  'site-santa-teresa-de-calcuta-itaparica-vila-velha-es',
  'Igreja Matriz Santa Teresa de Calcutá',
  'parish_church',
  'Av. Estudante José Júlio de Souza, s/n - Praia de Itaparica',
  'Vila Velha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.299, -20.362), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-centro-vila-velha-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  1950,
  'Paróquia São José no Centro de Vila Velha.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-centro-vila-velha-es'),
  'site-sao-jose-centro-vila-velha-es',
  'Igreja Matriz São José',
  'parish_church',
  'Praça Duque de Caxias, s/n - Centro',
  'Vila Velha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.293, -20.3321), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Graças
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-gracas-coqueiral-vila-velha-es',
  'Paróquia Nossa Senhora das Graças',
  'parish',
  'latin',
  'BR',
  'active',
  1980,
  'Paróquia Nossa Senhora das Graças em Coqueiral de Itaparica, Vila Velha.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Graças
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-gracas-coqueiral-vila-velha-es'),
  'site-nossa-senhora-das-gracas-coqueiral-vila-velha-es',
  'Igreja Matriz Nossa Senhora das Graças',
  'parish_church',
  'R. Santa Luzia, s/n - Coqueiral de Itaparica',
  'Vila Velha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.295, -20.355), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santa Mãe de Deus
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santa-mae-de-deus-ibes-vila-velha-es',
  'Paróquia Santa Mãe de Deus',
  'parish',
  'latin',
  'BR',
  'active',
  1960,
  'Paróquia Santa Mãe de Deus no bairro IBES em Vila Velha.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santa Mãe de Deus
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santa-mae-de-deus-ibes-vila-velha-es'),
  'site-santa-mae-de-deus-ibes-vila-velha-es',
  'Igreja Matriz Santa Mãe de Deus',
  'parish_church',
  'Praça do IBES, s/n - IBES',
  'Vila Velha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.312, -20.342), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Francisco de Assis
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-francisco-de-assis-itapua-vila-velha-es',
  'Paróquia São Francisco de Assis',
  'parish',
  'latin',
  'BR',
  'active',
  1988,
  'Paróquia São Francisco de Assis em Itapuã, Vila Velha.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Francisco de Assis
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-francisco-de-assis-itapua-vila-velha-es'),
  'site-sao-francisco-de-assis-itapua-vila-velha-es',
  'Igreja Matriz São Francisco de Assis',
  'parish_church',
  'R. Resende, s/n - Itapuã',
  'Vila Velha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.289, -20.35), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora dos Navegantes
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-dos-navegantes-ponta-da-fruta-vila-velha-es',
  'Paróquia Nossa Senhora dos Navegantes',
  'parish',
  'latin',
  'BR',
  'active',
  1995,
  'Paróquia Nossa Senhora dos Navegantes em Ponta da Fruta, Vila Velha.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora dos Navegantes
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-dos-navegantes-ponta-da-fruta-vila-velha-es'),
  'site-nossa-senhora-dos-navegantes-ponta-da-fruta-vila-velha-es',
  'Igreja Matriz Nossa Senhora dos Navegantes',
  'parish_church',
  'Av. Gabiroba, s/n - Ponta da Fruta',
  'Vila Velha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.332, -20.448), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora do Perpétuo Socorro
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-do-perpetuo-socorro-praia-da-costa-vila-velha-es',
  'Paróquia Nossa Senhora do Perpétuo Socorro',
  'parish',
  'latin',
  'BR',
  'active',
  1975,
  'Paróquia Nossa Senhora do Perpétuo Socorro na Praia da Costa, Vila Velha.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora do Perpétuo Socorro
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-do-perpetuo-socorro-praia-da-costa-vila-velha-es'),
  'site-nossa-senhora-do-perpetuo-socorro-praia-da-costa-vila-velha-es',
  'Igreja Matriz Nossa Senhora do Perpétuo Socorro',
  'parish_church',
  'R. Ceará, s/n - Praia da Costa',
  'Vila Velha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.283, -20.335), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Conceição
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-conceicao-serra-es',
  'Paróquia Nossa Senhora da Conceição',
  'parish',
  'latin',
  'BR',
  'active',
  1556,
  'Matriz histórica da Serra fundada pelo Pe. Brás Lourenço com ajuda dos indígenas.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Conceição
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-conceicao-serra-es'),
  'site-igreja-matriz-serra-es',
  'Igreja Matriz Nossa Senhora da Conceição',
  'parish_church',
  'Praça Barbosa Leão, s/n - Serra Centro',
  'Serra',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.3072, -20.1285), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Pedro
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-pedro-jacaraipe-serra-es',
  'Paróquia São Pedro',
  'parish',
  'latin',
  'BR',
  'active',
  1980,
  'Paróquia São Pedro em Jacaraípe, Serra.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Pedro
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-pedro-jacaraipe-serra-es'),
  'site-sao-pedro-jacaraipe-serra-es',
  'Igreja Matriz São Pedro',
  'parish_church',
  'R. Rômulo Leão, s/n - Jacaraípe',
  'Serra',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.201, -20.1412), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Francisco de Assis
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-francisco-de-assis-laranjeiras-serra-es',
  'Paróquia São Francisco de Assis',
  'parish',
  'latin',
  'BR',
  'active',
  1984,
  'Paróquia São Francisco de Assis em Laranjeiras, Serra.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Francisco de Assis
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-francisco-de-assis-laranjeiras-serra-es'),
  'site-sao-francisco-de-assis-laranjeiras-serra-es',
  'Igreja Matriz São Francisco de Assis',
  'parish_church',
  'Av. Central, s/n - Parque Residencial Laranjeiras',
  'Serra',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.252, -20.198), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Graças
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-gracas-porto-canoa-serra-es',
  'Paróquia Nossa Senhora das Graças',
  'parish',
  'latin',
  'BR',
  'active',
  1990,
  'Paróquia Nossa Senhora das Graças em Porto Canoa, Serra.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Graças
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-gracas-porto-canoa-serra-es'),
  'site-nossa-senhora-das-gracas-porto-canoa-serra-es',
  'Igreja Matriz Nossa Senhora das Graças',
  'parish_church',
  'Av. Brasília, s/n - Porto Canoa',
  'Serra',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.271, -20.182), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São João Paulo II
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-joao-paulo-ii-feu-rosa-serra-es',
  'Paróquia São João Paulo II',
  'parish',
  'latin',
  'BR',
  'active',
  2012,
  'Paróquia São João Paulo II em Feu Rosa, Serra.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São João Paulo II
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-joao-paulo-ii-feu-rosa-serra-es'),
  'site-sao-joao-paulo-ii-feu-rosa-serra-es',
  'Igreja Matriz São João Paulo II',
  'parish_church',
  'R. Pau Brasil, s/n - Feu Rosa',
  'Serra',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.223, -20.165), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Sagrados Corações de Jesus e Maria
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sagrados-coracoes-barcelona-serra-es',
  'Paróquia Sagrados Corações de Jesus e Maria',
  'parish',
  'latin',
  'BR',
  'active',
  1992,
  'Paróquia Sagrados Corações de Jesus e Maria em Barcelona, Serra.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Sagrados Corações de Jesus e Maria
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sagrados-coracoes-barcelona-serra-es'),
  'site-sagrados-coracoes-barcelona-serra-es',
  'Igreja Matriz Sagrados Corações de Jesus e Maria',
  'parish_church',
  'Av. Região Sudeste, s/n - Barcelona',
  'Serra',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.261, -20.21), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Tempo de Graça
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-tempo-de-graca-novo-horizonte-serra-es',
  'Paróquia Tempo de Graça',
  'parish',
  'latin',
  'BR',
  'active',
  2015,
  'Paróquia Tempo de Graça em Novo Horizonte, Serra.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Tempo de Graça
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-tempo-de-graca-novo-horizonte-serra-es'),
  'site-tempo-de-graca-novo-horizonte-serra-es',
  'Igreja Matriz Tempo de Graça',
  'parish_church',
  'Av. Brasil, s/n - Novo Horizonte',
  'Serra',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.245, -20.222), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Bom Pastor
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-bom-pastor-cariacica-es',
  'Paróquia Bom Pastor',
  'parish',
  'latin',
  'BR',
  'active',
  1968,
  'Paróquia Bom Pastor em Campo Grande, Cariacica.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Bom Pastor
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-bom-pastor-cariacica-es'),
  'site-paroquia-bom-pastor-cariacica-es',
  'Igreja Matriz Bom Pastor',
  'parish_church',
  'R. Pres. Vargas, s/n - Campo Grande',
  'Cariacica',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.384, -20.3365), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São João Batista
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-joao-batista-cariacica-es',
  'Paróquia São João Batista',
  'parish',
  'latin',
  'BR',
  'active',
  1837,
  'Matriz histórica de São João Batista em Cariacica Sede.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São João Batista
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-joao-batista-cariacica-es'),
  'site-sao-joao-batista-cariacica-es',
  'Igreja Matriz São João Batista',
  'parish_church',
  'Praça Marechal Deodoro, s/n - Cariacica Sede',
  'Cariacica',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.4201, -20.2642), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Maria Mãe dos Pobres
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-maria-mae-dos-pobres-porto-de-santana-cariacica-es',
  'Paróquia Maria Mãe dos Pobres',
  'parish',
  'latin',
  'BR',
  'active',
  1985,
  'Paróquia Maria Mãe dos Pobres em Porto de Santana, Cariacica.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Maria Mãe dos Pobres
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-maria-mae-dos-pobres-porto-de-santana-cariacica-es'),
  'site-maria-mae-dos-pobres-porto-de-santana-cariacica-es',
  'Igreja Matriz Maria Mãe dos Pobres',
  'parish_church',
  'R. Gabino Rios, s/n - Porto de Santana',
  'Cariacica',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.372, -20.311), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santíssima Trindade
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santissima-trindade-vila-capixaba-cariacica-es',
  'Paróquia Santíssima Trindade',
  'parish',
  'latin',
  'BR',
  'active',
  1976,
  'Paróquia Santíssima Trindade em Vila Capixaba, Cariacica.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santíssima Trindade
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santissima-trindade-vila-capixaba-cariacica-es'),
  'site-santissima-trindade-vila-capixaba-cariacica-es',
  'Igreja Matriz Santíssima Trindade',
  'parish_church',
  'R. Muniz Freire, s/n - Vila Capixaba',
  'Cariacica',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.395, -20.342), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santa Maria de Jetibá
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santa-maria-nova-rosa-da-penha-cariacica-es',
  'Paróquia Santa Maria de Jetibá',
  'parish',
  'latin',
  'BR',
  'active',
  1994,
  'Paróquia em Nova Rosa da Penha, Cariacica.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santa Maria
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santa-maria-nova-rosa-da-penha-cariacica-es'),
  'site-santa-maria-nova-rosa-da-penha-cariacica-es',
  'Igreja Matriz Santa Maria',
  'parish_church',
  'R. 14, s/n - Nova Rosa da Penha',
  'Cariacica',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.418, -20.328), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Matriz Antiga)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-conceicao-guarapari-es',
  'Paróquia Nossa Senhora da Conceição (Matriz Antiga)',
  'parish',
  'latin',
  'BR',
  'active',
  1585,
  'Igreja Matriz Antiga de Guarapari fundada por São José de Anchieta em 1585.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Antiga Nossa Senhora da Conceição
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-conceicao-guarapari-es'),
  'site-matriz-antiga-guarapari-es',
  'Igreja Matriz Antiga Nossa Senhora da Conceição',
  'parish_church',
  'R. João Cavalcanti, s/n - Centro',
  'Guarapari',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.4975, -20.672), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Sagrada Família
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sagrada-familia-praia-do-morro-guarapari-es',
  'Paróquia Sagrada Família',
  'parish',
  'latin',
  'BR',
  'active',
  1998,
  'Paróquia Sagrada Família na Praia do Morro, Guarapari.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Sagrada Família
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sagrada-familia-praia-do-morro-guarapari-es'),
  'site-sagrada-familia-praia-do-morro-guarapari-es',
  'Igreja Matriz Sagrada Família',
  'parish_church',
  'Av. Beira Mar, s/n - Praia do Morro',
  'Guarapari',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.485, -20.661), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Pedro
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-pedro-muquicaba-guarapari-es',
  'Paróquia São Pedro',
  'parish',
  'latin',
  'BR',
  'active',
  1983,
  'Paróquia São Pedro em Muquiçaba, Guarapari.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Pedro
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-pedro-muquicaba-guarapari-es'),
  'site-sao-pedro-muquicaba-guarapari-es',
  'Igreja Matriz São Pedro',
  'parish_church',
  'R. Pedro Caetano, s/n - Muquiçaba',
  'Guarapari',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.498, -20.668), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Sant'Ana
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santana-viana-es',
  'Paróquia Sant''Ana',
  'parish',
  'latin',
  'BR',
  'active',
  1817,
  'Matriz histórica de Sant''Ana em Viana Centro.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Sant'Ana
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santana-viana-es'),
  'site-santana-viana-es',
  'Igreja Matriz Sant''Ana',
  'parish_church',
  'R. Aspazia Varejão, s/n - Viana Centro',
  'Viana',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.498, -20.391), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Marcílio de Noronha
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-marcilio-de-noronha-viana-es',
  'Paróquia Marcílio de Noronha',
  'parish',
  'latin',
  'BR',
  'active',
  1990,
  'Paróquia em Marcílio de Noronha, Viana.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Marcílio de Noronha
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-marcilio-de-noronha-viana-es'),
  'site-marcilio-de-noronha-viana-es',
  'Igreja Matriz Marcílio de Noronha',
  'parish_church',
  'Av. Vitória, s/n - Marcílio de Noronha',
  'Viana',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.445, -20.368), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-fundao-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  1933,
  'Paróquia São José em Fundão Centro.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-fundao-es'),
  'site-sao-jose-fundao-es',
  'Igreja Matriz São José',
  'parish_church',
  'Praça da Matriz, s/n - Fundão Centro',
  'Fundão',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.404, -19.932), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santa Isabel da Hungria
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santa-isabel-domingos-martins-es',
  'Paróquia Santa Isabel da Hungria',
  'parish',
  'latin',
  'BR',
  'active',
  1888,
  'Matriz de Santa Isabel da Hungria na região serrana de Domingos Martins.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santa Isabel da Hungria
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santa-isabel-domingos-martins-es'),
  'site-santa-isabel-domingos-martins-es',
  'Igreja Matriz Santa Isabel da Hungria',
  'parish_church',
  'R. Senador Atílio Vivácqua, s/n - Centro',
  'Domingos Martins',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.659, -20.363), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora de Lourdes
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-de-lourdes-marechal-floriano-es',
  'Paróquia Nossa Senhora de Lourdes',
  'parish',
  'latin',
  'BR',
  'active',
  1940,
  'Paróquia Nossa Senhora de Lourdes em Marechal Floriano.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora de Lourdes
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-de-lourdes-marechal-floriano-es'),
  'site-nossa-senhora-de-lourdes-marechal-floriano-es',
  'Igreja Matriz Nossa Senhora de Lourdes',
  'parish_church',
  'Praça José Henrique Pereira, s/n - Centro',
  'Marechal Floriano',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.683, -20.412), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora do Carmo
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-do-carmo-santa-leopoldina-es',
  'Paróquia Nossa Senhora do Carmo',
  'parish',
  'latin',
  'BR',
  'active',
  1887,
  'Paróquia Nossa Senhora do Carmo em Santa Leopoldina.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora do Carmo
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-do-carmo-santa-leopoldina-es'),
  'site-nossa-senhora-do-carmo-santa-leopoldina-es',
  'Igreja Matriz Nossa Senhora do Carmo',
  'parish_church',
  'R. do Comércio, s/n - Centro',
  'Santa Leopoldina',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.528, -20.101), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Bento
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-bento-santa-maria-de-jetiba-es',
  'Paróquia São Bento',
  'parish',
  'latin',
  'BR',
  'active',
  1990,
  'Paróquia São Bento em Santa Maria de Jetibá.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Bento
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-bento-santa-maria-de-jetiba-es'),
  'site-sao-bento-santa-maria-de-jetiba-es',
  'Igreja Matriz São Bento',
  'parish_church',
  'R. Dalmácio Espíndula, s/n - Centro',
  'Santa Maria de Jetibá',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.745, -20.041), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Conceição
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-conceicao-alfredo-chaves-es',
  'Paróquia Nossa Senhora da Conceição',
  'parish',
  'latin',
  'BR',
  'active',
  1884,
  'Paróquia Nossa Senhora da Conceição em Alfredo Chaves.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Conceição
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-conceicao-alfredo-chaves-es'),
  'site-nossa-senhora-da-conceicao-alfredo-chaves-es',
  'Igreja Matriz Nossa Senhora da Conceição',
  'parish_church',
  'Praça Colombo Guardia, s/n - Centro',
  'Alfredo Chaves',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.751, -20.635), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora Mãe dos Homens
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-mae-dos-homens-iconha-es',
  'Paróquia Nossa Senhora Mãe dos Homens',
  'parish',
  'latin',
  'BR',
  'active',
  1905,
  'Paróquia Nossa Senhora Mãe dos Homens em Iconha.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora Mãe dos Homens
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-mae-dos-homens-iconha-es'),
  'site-nossa-senhora-mae-dos-homens-iconha-es',
  'Igreja Matriz Nossa Senhora Mãe dos Homens',
  'parish_church',
  'Praça Central, s/n - Centro',
  'Iconha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.811, -20.792), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-calogi-serra-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  2002,
  'Paróquia São José na região de Calogi, Serra.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-calogi-serra-es'),
  'site-sao-jose-calogi-serra-es',
  'Igreja Matriz São José',
  'parish_church',
  'Rodovia BR-101, Km 230 - Calogi',
  'Serra',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.325, -20.081), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Catedral São Pedro Apóstolo
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-sao-pedro-cachoeiro-es',
  'Paróquia Catedral São Pedro Apóstolo',
  'parish',
  'latin',
  'BR',
  'active',
  1958,
  'Catedral São Pedro Apóstolo, sede da Diocese de Cachoeiro de Itapemirim.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral São Pedro Apóstolo
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-sao-pedro-cachoeiro-es'),
  'site-catedral-sao-pedro-cachoeiro-es',
  'Catedral São Pedro Apóstolo',
  'cathedral',
  'Praça Jerônimo Monteiro, s/n - Centro',
  'Cachoeiro de Itapemirim',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.1126, -20.8485), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nosso Senhor dos Passos
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nosso-senhor-dos-passos-cachoeiro-es',
  'Paróquia Nosso Senhor dos Passos',
  'parish',
  'latin',
  'BR',
  'active',
  1938,
  'Paróquia Nosso Senhor dos Passos em Cachoeiro de Itapemirim.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nosso Senhor dos Passos
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nosso-senhor-dos-passos-cachoeiro-es'),
  'site-paroquia-nosso-senhor-dos-passos-cachoeiro-es',
  'Igreja Matriz Nosso Senhor dos Passos',
  'parish_church',
  'R. Pe. Bento, s/n - Independência',
  'Cachoeiro de Itapemirim',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.116, -20.847), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santíssimo Sacramento da Eucaristia
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santissimo-sacramento-paraiso-cachoeiro-es',
  'Paróquia Santíssimo Sacramento da Eucaristia',
  'parish',
  'latin',
  'BR',
  'active',
  1972,
  'Paróquia Santíssimo Sacramento em Paraíso, Cachoeiro de Itapemirim.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santíssimo Sacramento
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santissimo-sacramento-paraiso-cachoeiro-es'),
  'site-santissimo-sacramento-paraiso-cachoeiro-es',
  'Igreja Matriz Santíssimo Sacramento',
  'parish_church',
  'R. Linhares, s/n - Paraíso',
  'Cachoeiro de Itapemirim',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.125, -20.852), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Sebastião
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-sebastiao-aquidaban-cachoeiro-es',
  'Paróquia São Sebastião',
  'parish',
  'latin',
  'BR',
  'active',
  1964,
  'Paróquia São Sebastião em Aquidaban, Cachoeiro de Itapemirim.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Sebastião
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-sebastiao-aquidaban-cachoeiro-es'),
  'site-sao-sebastiao-aquidaban-cachoeiro-es',
  'Igreja Matriz São Sebastião',
  'parish_church',
  'R. Samuel Levy, s/n - Aquidaban',
  'Cachoeiro de Itapemirim',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.119, -20.841), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Felipe
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-felipe-aeroporto-cachoeiro-es',
  'Paróquia São Felipe',
  'parish',
  'latin',
  'BR',
  'active',
  1986,
  'Paróquia São Felipe no bairro Aeroporto, Cachoeiro de Itapemirim.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Felipe
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-felipe-aeroporto-cachoeiro-es'),
  'site-sao-felipe-aeroporto-cachoeiro-es',
  'Igreja Matriz São Felipe',
  'parish_church',
  'Av. Jones dos Santos Neves, s/n - Aeroporto',
  'Cachoeiro de Itapemirim',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.141, -20.835), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Graças
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-gracas-baiminas-cachoeiro-es',
  'Paróquia Nossa Senhora das Graças',
  'parish',
  'latin',
  'BR',
  'active',
  1978,
  'Paróquia Nossa Senhora das Graças em Baiminas, Cachoeiro de Itapemirim.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Graças
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-gracas-baiminas-cachoeiro-es'),
  'site-nossa-senhora-das-gracas-baiminas-cachoeiro-es',
  'Igreja Matriz Nossa Senhora das Graças',
  'parish_church',
  'R. Dr. Raulino de Oliveira, s/n - Baiminas',
  'Cachoeiro de Itapemirim',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.121, -20.858), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Consolação
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-consolacao-vila-rica-cachoeiro-es',
  'Paróquia Nossa Senhora da Consolação',
  'parish',
  'latin',
  'BR',
  'active',
  1990,
  'Paróquia Nossa Senhora da Consolação em Vila Rica, Cachoeiro.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Consolação
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-consolacao-vila-rica-cachoeiro-es'),
  'site-nossa-senhora-da-consolacao-vila-rica-cachoeiro-es',
  'Igreja Matriz Nossa Senhora da Consolação',
  'parish_church',
  'R. Valão, s/n - Vila Rica',
  'Cachoeiro de Itapemirim',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.135, -20.861), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Penha
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-penha-castelo-es',
  'Paróquia Nossa Senhora da Penha',
  'parish',
  'latin',
  'BR',
  'active',
  1928,
  'Paróquia Nossa Senhora da Penha em Castelo, famosa pelo tapete de Corpus Christi.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Penha
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-penha-castelo-es'),
  'site-nossa-senhora-da-penha-castelo-es',
  'Igreja Matriz Nossa Senhora da Penha',
  'parish_church',
  'Praça Três Irmãos, s/n - Centro',
  'Castelo',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.185, -20.603), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santo André
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santo-andre-aracui-castelo-es',
  'Paróquia Santo André',
  'parish',
  'latin',
  'BR',
  'active',
  1996,
  'Paróquia Santo André no distrito de Aracuí, Castelo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santo André
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santo-andre-aracui-castelo-es'),
  'site-santo-andre-aracui-castelo-es',
  'Igreja Matriz Santo André',
  'parish_church',
  'Rodovia Fued Nemer - Aracuí',
  'Castelo',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.171, -20.589), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Dores
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-dores-marataizes-es',
  'Paróquia Nossa Senhora das Dores',
  'parish',
  'latin',
  'BR',
  'active',
  1960,
  'Paróquia Nossa Senhora das Dores no balneário de Marataízes.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Dores
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-dores-marataizes-es'),
  'site-nossa-senhora-das-dores-marataizes-es',
  'Igreja Matriz Nossa Senhora das Dores',
  'parish_church',
  'Av. Simão Soares, s/n - Centro',
  'Marataízes',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.824, -21.0425), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora do Amparo
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-do-amparo-itapemirim-es',
  'Paróquia Nossa Senhora do Amparo',
  'parish',
  'latin',
  'BR',
  'active',
  1769,
  'Matriz histórica de Nossa Senhora do Amparo em Itapemirim.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora do Amparo
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-do-amparo-itapemirim-es'),
  'site-nossa-senhora-do-amparo-itapemirim-es',
  'Igreja Matriz Nossa Senhora do Amparo',
  'parish_church',
  'Praça Domingo José Martins, s/n - Centro',
  'Itapemirim',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.834, -21.011), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São João Batista
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-joao-batista-muqui-es',
  'Paróquia São João Batista',
  'parish',
  'latin',
  'BR',
  'active',
  1912,
  'Paróquia São João Batista em Muqui, cidade histórica do sul capixaba.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São João Batista
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-joao-batista-muqui-es'),
  'site-sao-joao-batista-muqui-es',
  'Igreja Matriz São João Batista',
  'parish_church',
  'Praça Salomão Freire, s/n - Centro',
  'Muqui',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.346, -20.952), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-mimoso-do-sul-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  1895,
  'Paróquia São José em Mimoso do Sul.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-mimoso-do-sul-es'),
  'site-sao-jose-mimoso-do-sul-es',
  'Igreja Matriz São José',
  'parish_church',
  'Praça das Mangueiras, s/n - Centro',
  'Mimoso do Sul',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.365, -21.064), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nosso Senhor Bom Jesus do Itabapoana
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-bom-jesus-bom-jesus-do-norte-es',
  'Paróquia Nosso Senhor Bom Jesus do Itabapoana',
  'parish',
  'latin',
  'BR',
  'active',
  1952,
  'Paróquia na divisa com o estado do Rio de Janeiro.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nosso Senhor Bom Jesus
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-bom-jesus-bom-jesus-do-norte-es'),
  'site-bom-jesus-bom-jesus-do-norte-es',
  'Igreja Matriz Nosso Senhor Bom Jesus',
  'parish_church',
  'Praça da Matriz, s/n - Centro',
  'Bom Jesus do Norte',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.673, -21.151), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José das Torres
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-das-torres-mimoso-es',
  'Paróquia São José das Torres',
  'parish',
  'latin',
  'BR',
  'active',
  1985,
  'Paróquia São José das Torres no distrito de Torres.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José das Torres
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-das-torres-mimoso-es'),
  'site-sao-jose-das-torres-mimoso-es',
  'Igreja Matriz São José das Torres',
  'parish_church',
  'Rodovia BR-101, Km 440 - Torres',
  'Mimoso do Sul',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.221, -21.091), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Dores
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-dores-presidente-kennedy-es',
  'Paróquia Nossa Senhora das Dores',
  'parish',
  'latin',
  'BR',
  'active',
  1968,
  'Paróquia em Presidente Kennedy no litoral sul do ES.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Dores
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-dores-presidente-kennedy-es'),
  'site-nossa-senhora-das-dores-presidente-kennedy-es',
  'Igreja Matriz Nossa Senhora das Dores',
  'parish_church',
  'Praça Átila Vivácqua, s/n - Centro',
  'Presidente Kennedy',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.045, -21.099), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Pedro dos Altos
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-pedro-alegre-es',
  'Paróquia São Pedro dos Altos',
  'parish',
  'latin',
  'BR',
  'active',
  1868,
  'Matriz histórica de São Pedro em Alegre na região do Caparaó.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Pedro dos Altos
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-pedro-alegre-es'),
  'site-sao-pedro-alegre-es',
  'Igreja Matriz São Pedro dos Altos',
  'parish_church',
  'Praça Ruy Barbosa, s/n - Centro',
  'Alegre',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.532, -20.763), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Miguel Arcanjo
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-miguel-arcanjo-guacui-es',
  'Paróquia São Miguel Arcanjo',
  'parish',
  'latin',
  'BR',
  'active',
  1871,
  'Paróquia São Miguel Arcanjo em Guaçuí.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Miguel Arcanjo
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-miguel-arcanjo-guacui-es'),
  'site-sao-miguel-arcanjo-guacui-es',
  'Igreja Matriz São Miguel Arcanjo',
  'parish_church',
  'Praça João Acacinho, s/n - Centro',
  'Guaçuí',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.679, -20.776), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Graças
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-gracas-iuna-es',
  'Paróquia Nossa Senhora das Graças',
  'parish',
  'latin',
  'BR',
  'active',
  1892,
  'Paróquia Nossa Senhora das Graças em Iúna, aos pés do Caparaó.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Graças
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-gracas-iuna-es'),
  'site-nossa-senhora-das-gracas-iuna-es',
  'Igreja Matriz Nossa Senhora das Graças',
  'parish_church',
  'Praça Coronel Silvino, s/n - Centro',
  'Iúna',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.535, -20.345), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora do Rosário
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-do-rosario-irupi-es',
  'Paróquia Nossa Senhora do Rosário',
  'parish',
  'latin',
  'BR',
  'active',
  1992,
  'Paróquia Nossa Senhora do Rosário em Irupi.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora do Rosário
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-do-rosario-irupi-es'),
  'site-nossa-senhora-do-rosario-irupi-es',
  'Igreja Matriz Nossa Senhora do Rosário',
  'parish_church',
  'Praça Central, s/n - Centro',
  'Irupi',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.642, -20.344), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Divino Espírito Santo
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-divino-espirito-santo-muniz-freire-es',
  'Paróquia Divino Espírito Santo',
  'parish',
  'latin',
  'BR',
  'active',
  1898,
  'Paróquia em Muniz Freire.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Divino Espírito Santo
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-divino-espirito-santo-muniz-freire-es'),
  'site-divino-espirito-santo-muniz-freire-es',
  'Igreja Matriz Divino Espírito Santo',
  'parish_church',
  'Praça Divino Espírito Santo, s/n - Centro',
  'Muniz Freire',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.413, -20.612), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora Auxiliadora
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-auxiliadora-jeronimo-monteiro-es',
  'Paróquia Nossa Senhora Auxiliadora',
  'parish',
  'latin',
  'BR',
  'active',
  1958,
  'Paróquia em Jerônimo Monteiro.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora Auxiliadora
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-auxiliadora-jeronimo-monteiro-es'),
  'site-nossa-senhora-auxiliadora-jeronimo-monteiro-es',
  'Igreja Matriz Nossa Senhora Auxiliadora',
  'parish_church',
  'Praça da Matriz, s/n - Centro',
  'Jerônimo Monteiro',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.395, -20.789), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santo Antônio de Pádua
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santo-antonio-atilio-vivacqua-es',
  'Paróquia Santo Antônio de Pádua',
  'parish',
  'latin',
  'BR',
  'active',
  1964,
  'Paróquia Santo Antônio de Pádua em Atílio Vivácqua.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santo Antônio
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santo-antonio-atilio-vivacqua-es'),
  'site-santo-antonio-atilio-vivacqua-es',
  'Igreja Matriz Santo Antônio',
  'parish_church',
  'Praça José Valentim, s/n - Centro',
  'Atílio Vivácqua',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.198, -20.915), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Dores
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-dores-dores-do-rio-preto-es',
  'Paróquia Nossa Senhora das Dores',
  'parish',
  'latin',
  'BR',
  'active',
  1890,
  'Paróquia na divisa com Minas Gerais no Parque Nacional do Caparaó.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Dores
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-dores-dores-do-rio-preto-es'),
  'site-nossa-senhora-das-dores-dores-do-rio-preto-es',
  'Igreja Matriz Nossa Senhora das Dores',
  'parish_church',
  'Praça Principal, s/n - Centro',
  'Dores do Rio Preto',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.845, -20.691), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Sagrado Coração de Jesus
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sagrado-coracao-divino-de-sao-lourenco-es',
  'Paróquia Sagrado Coração de Jesus',
  'parish',
  'latin',
  'BR',
  'active',
  1965,
  'Paróquia em Divino de São Lourenço.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Sagrado Coração de Jesus
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sagrado-coracao-divino-de-sao-lourenco-es'),
  'site-sagrado-coracao-divino-de-sao-lourenco-es',
  'Igreja Matriz Sagrado Coração de Jesus',
  'parish_church',
  'Praça Central, s/n - Centro',
  'Divino de São Lourenço',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.686, -20.621), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santa Bárbara
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santa-barbara-ibitirama-es',
  'Paróquia Santa Bárbara',
  'parish',
  'latin',
  'BR',
  'active',
  1988,
  'Paróquia Santa Bárbara em Ibitirama.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santa Bárbara
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santa-barbara-ibitirama-es'),
  'site-santa-barbara-ibitirama-es',
  'Igreja Matriz Santa Bárbara',
  'parish_church',
  'Praça Central, s/n - Centro',
  'Ibitirama',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.668, -20.541), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-sao-jose-do-calcado-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  1855,
  'Paróquia São José em São José do Calçado.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-sao-jose-do-calcado-es'),
  'site-sao-jose-sao-jose-do-calcado-es',
  'Igreja Matriz São José',
  'parish_church',
  'Praça Pedro de Alcântara, s/n - Centro',
  'São José do Calçado',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.654, -20.985), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Senhora de Santana
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-senhora-de-santana-apiaca-es',
  'Paróquia Senhora de Santana',
  'parish',
  'latin',
  'BR',
  'active',
  1916,
  'Paróquia Senhora de Santana em Apiacá.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Senhora de Santana
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-senhora-de-santana-apiaca-es'),
  'site-senhora-de-santana-apiaca-es',
  'Igreja Matriz Senhora de Santana',
  'parish_church',
  'Praça Senhora de Santana, s/n - Centro',
  'Apiacá',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.568, -21.154), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Sebastião
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-sebastiao-vargem-alta-es',
  'Paróquia São Sebastião',
  'parish',
  'latin',
  'BR',
  'active',
  1989,
  'Paróquia São Sebastião na região das montanhas de Vargem Alta.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Sebastião
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-sebastiao-vargem-alta-es'),
  'site-sao-sebastiao-vargem-alta-es',
  'Igreja Matriz São Sebastião',
  'parish_church',
  'Praça Alberto Rangel, s/n - Centro',
  'Vargem Alta',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.008, -20.672), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Penha
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-penha-jacigua-vargem-alta-es',
  'Paróquia Nossa Senhora da Penha',
  'parish',
  'latin',
  'BR',
  'active',
  1995,
  'Paróquia em Jaciguá, Vargem Alta.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Penha
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-penha-jacigua-vargem-alta-es'),
  'site-nossa-senhora-da-penha-jacigua-vargem-alta-es',
  'Igreja Matriz Nossa Senhora da Penha',
  'parish_church',
  'R. da Matriz, s/n - Jaciguá',
  'Vargem Alta',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.052, -20.642), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Sagradas Famílias
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sagradas-familias-soturno-cachoeiro-es',
  'Paróquia Sagradas Famílias',
  'parish',
  'latin',
  'BR',
  'active',
  1998,
  'Paróquia em Soturno, Cachoeiro de Itapemirim.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Sagradas Famílias
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sagradas-familias-soturno-cachoeiro-es'),
  'site-sagradas-familias-soturno-cachoeiro-es',
  'Igreja Matriz Sagradas Famílias',
  'parish_church',
  'Rodovia ES-482 - Soturno',
  'Cachoeiro de Itapemirim',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.112, -20.798), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Pedro
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-pedro-itaipava-itapemirim-es',
  'Paróquia São Pedro',
  'parish',
  'latin',
  'BR',
  'active',
  2000,
  'Paróquia São Pedro no balneário de Itaipava, Itapemirim.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Pedro
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-pedro-itaipava-itapemirim-es'),
  'site-sao-pedro-itaipava-itapemirim-es',
  'Igreja Matriz São Pedro',
  'parish_church',
  'Av. Beira Mar, s/n - Itaipava',
  'Itapemirim',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.801, -20.995), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Catedral Sagrado Coração de Jesus
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-sagrado-coracao-de-jesus-colatina-es',
  'Paróquia Catedral Sagrado Coração de Jesus',
  'parish',
  'latin',
  'BR',
  'active',
  1990,
  'Catedral Sagrado Coração de Jesus, sede da Diocese de Colatina.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral Sagrado Coração de Jesus
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-sagrado-coracao-de-jesus-colatina-es'),
  'site-catedral-sagrado-coracao-de-jesus-colatina-es',
  'Catedral Sagrado Coração de Jesus',
  'cathedral',
  'Praça Frei Silvestre, s/n - Centro',
  'Colatina',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.6275, -19.5398), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Glória
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-gloria-vila-lenira-colatina-es',
  'Paróquia Nossa Senhora da Glória',
  'parish',
  'latin',
  'BR',
  'active',
  1965,
  'Paróquia em Vila Lenira, Colatina.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Glória
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-gloria-vila-lenira-colatina-es'),
  'site-nossa-senhora-da-gloria-vila-lenira-colatina-es',
  'Igreja Matriz Nossa Senhora da Glória',
  'parish_church',
  'R. Fioravante Rossi, s/n - Vila Lenira',
  'Colatina',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.618, -19.531), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Imaculado Coração de Maria
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-imaculado-coracao-sao-silvano-colatina-es',
  'Paróquia Imaculado Coração de Maria',
  'parish',
  'latin',
  'BR',
  'active',
  1970,
  'Paróquia no bairro movimentado de São Silvano, Colatina.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Imaculado Coração de Maria
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-imaculado-coracao-sao-silvano-colatina-es'),
  'site-imaculado-coracao-sao-silvano-colatina-es',
  'Igreja Matriz Imaculado Coração de Maria',
  'parish_church',
  'Av. Silvio Avidos, s/n - São Silvano',
  'Colatina',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.639, -19.525), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santa Clara de Assis
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santa-clara-colatina-es',
  'Paróquia Santa Clara de Assis',
  'parish',
  'latin',
  'BR',
  'active',
  2005,
  'Paróquia Santa Clara de Assis em Colatina.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santa Clara de Assis
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santa-clara-colatina-es'),
  'site-santa-clara-colatina-es',
  'Igreja Matriz Santa Clara de Assis',
  'parish_church',
  'R. Carlos Germano Naumann, s/n',
  'Colatina',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.648, -19.551), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-maria-das-gracas-colatina-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  1980,
  'Paróquia São José no bairro Maria das Graças, Colatina.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-maria-das-gracas-colatina-es'),
  'site-sao-jose-maria-das-gracas-colatina-es',
  'Igreja Matriz São José',
  'parish_church',
  'R. Mafalda Galimberti, s/n - Maria das Graças',
  'Colatina',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.621, -19.542), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santuário Diocesano Nossa Senhora da Saúde
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-nossa-senhora-da-saude-ibiracu-es',
  'Paróquia Santuário Diocesano Nossa Senhora da Saúde',
  'parish',
  'latin',
  'BR',
  'active',
  1998,
  'Santuário Diocesano de Nossa Senhora da Saúde em Ibiraçu, importante centro de peregrinação da Diocese de Colatina.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Santuário Diocesano Nossa Senhora da Saúde
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-nossa-senhora-da-saude-ibiracu-es'),
  'site-santuario-nossa-senhora-da-saude-ibiracu-es',
  'Santuário Diocesano Nossa Senhora da Saúde',
  'shrine',
  'Rodovia BR-101, Km 216 - Ibiraçu',
  'Ibiraçu',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.37, -19.832), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Marcos
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-marcos-ibiracu-es',
  'Paróquia São Marcos',
  'parish',
  'latin',
  'BR',
  'active',
  1892,
  'Paróquia São Marcos em Ibiraçu Centro.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Marcos
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-marcos-ibiracu-es'),
  'site-sao-marcos-ibiracu-es',
  'Igreja Matriz São Marcos',
  'parish_church',
  'Praça São Marcos, s/n - Centro',
  'Ibiraçu',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.368, -19.834), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São João Batista
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-joao-batista-aracruz-es',
  'Paróquia São João Batista',
  'parish',
  'latin',
  'BR',
  'active',
  1848,
  'Matriz histórica de São João Batista em Aracruz.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São João Batista
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-joao-batista-aracruz-es'),
  'site-sao-joao-batista-aracruz-es',
  'Igreja Matriz São João Batista',
  'parish_church',
  'Praça Monsenhor Guilherme Schmitz, s/n - Centro',
  'Aracruz',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.274, -19.821), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Imaculada Conceição
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-imaculada-conceicao-coqueiral-aracruz-es',
  'Paróquia Imaculada Conceição',
  'parish',
  'latin',
  'BR',
  'active',
  1980,
  'Paróquia no balneário de Coqueiral de Aracruz.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Imaculada Conceição
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-imaculada-conceicao-coqueiral-aracruz-es'),
  'site-imaculada-conceicao-coqueiral-aracruz-es',
  'Igreja Matriz Imaculada Conceição',
  'parish_church',
  'Av. dos Coqueiros, s/n - Coqueiral',
  'Aracruz',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.185, -19.905), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Coração da Imaculada
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-coracao-da-imaculada-bela-vista-aracruz-es',
  'Paróquia Coração da Imaculada',
  'parish',
  'latin',
  'BR',
  'active',
  2010,
  'Paróquia no bairro Bela Vista, Aracruz.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Coração da Imaculada
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-coracao-da-imaculada-bela-vista-aracruz-es'),
  'site-coracao-da-imaculada-bela-vista-aracruz-es',
  'Igreja Matriz Coração da Imaculada',
  'parish_church',
  'R. Epaminondas de Almeida, s/n - Bela Vista',
  'Aracruz',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.268, -19.815), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Imaculada Conceição
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-imaculada-conceicao-linhares-es',
  'Paróquia Imaculada Conceição',
  'parish',
  'latin',
  'BR',
  'active',
  1954,
  'Paróquia Matriz Imaculada Conceição na Praça histórica de Linhares.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Imaculada Conceição
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-imaculada-conceicao-linhares-es'),
  'site-paroquia-imaculada-conceicao-linhares-es',
  'Igreja Matriz Imaculada Conceição',
  'parish_church',
  'Praça 22 de Agosto, s/n - Centro',
  'Linhares',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.068, -19.391), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santa Rita de Cássia
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santa-rita-de-cassia-araca-linhares-es',
  'Paróquia Santa Rita de Cássia',
  'parish',
  'latin',
  'BR',
  'active',
  1982,
  'Paróquia no bairro Araçá, Linhares.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santa Rita de Cássia
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santa-rita-de-cassia-araca-linhares-es'),
  'site-santa-rita-araca-linhares-es',
  'Igreja Matriz Santa Rita de Cássia',
  'parish_church',
  'Av. Filogônio Peixoto, s/n - Araçá',
  'Linhares',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.072, -19.395), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Bom Pastor
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-bom-pastor-interlagos-linhares-es',
  'Paróquia Bom Pastor',
  'parish',
  'latin',
  'BR',
  'active',
  1992,
  'Paróquia Bom Pastor no bairro Interlagos, Linhares.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Bom Pastor
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-bom-pastor-interlagos-linhares-es'),
  'site-bom-pastor-interlagos-linhares-es',
  'Igreja Matriz Bom Pastor',
  'parish_church',
  'Av. Maipú, s/n - Interlagos',
  'Linhares',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.055, -19.378), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-novo-horizonte-linhares-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  2004,
  'Paróquia no bairro Novo Horizonte, Linhares.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-novo-horizonte-linhares-es'),
  'site-sao-jose-novo-horizonte-linhares-es',
  'Igreja Matriz São José',
  'parish_church',
  'R. Hélio Martins, s/n - Novo Horizonte',
  'Linhares',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.082, -19.412), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santíssima Trindade
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santissima-trindade-avis-linhares-es',
  'Paróquia Santíssima Trindade',
  'parish',
  'latin',
  'BR',
  'active',
  1988,
  'Paróquia Santíssima Trindade em Linhares.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santíssima Trindade
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santissima-trindade-avis-linhares-es'),
  'site-santissima-trindade-avis-linhares-es',
  'Igreja Matriz Santíssima Trindade',
  'parish_church',
  'R. Monsenhor Pedrinha, s/n - AVIS',
  'Linhares',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.061, -19.385), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora do Rosário de Fátima
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-de-fatima-rio-bananal-es',
  'Paróquia Nossa Senhora do Rosário de Fátima',
  'parish',
  'latin',
  'BR',
  'active',
  1979,
  'Paróquia Nossa Senhora de Fátima em Rio Bananal.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora de Fátima
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-de-fatima-rio-bananal-es'),
  'site-nossa-senhora-de-fatima-rio-bananal-es',
  'Igreja Matriz Nossa Senhora de Fátima',
  'parish_church',
  'Av. 14 de Setembro, s/n - Centro',
  'Rio Bananal',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.332, -19.264), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Cristo Rei
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-cristo-rei-sooretama-es',
  'Paróquia Cristo Rei',
  'parish',
  'latin',
  'BR',
  'active',
  1994,
  'Paróquia Cristo Rei em Sooretama.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Cristo Rei
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-cristo-rei-sooretama-es'),
  'site-cristo-rei-sooretama-es',
  'Igreja Matriz Cristo Rei',
  'parish_church',
  'R. Vista Alegre, s/n - Centro',
  'Sooretama',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.098, -19.185), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-joao-neiva-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  1988,
  'Paróquia São José em João Neiva.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-joao-neiva-es'),
  'site-sao-jose-joao-neiva-es',
  'Igreja Matriz São José',
  'parish_church',
  'Praça Negri Orestes, s/n - Centro',
  'João Neiva',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.387, -19.757), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora Auxiliadora
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-auxiliadora-marilandia-es',
  'Paróquia Nossa Senhora Auxiliadora',
  'parish',
  'latin',
  'BR',
  'active',
  1980,
  'Paróquia em Marilândia.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora Auxiliadora
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-auxiliadora-marilandia-es'),
  'site-nossa-senhora-auxiliadora-marilandia-es',
  'Igreja Matriz Nossa Senhora Auxiliadora',
  'parish_church',
  'Praça Luiz de Camões, s/n - Centro',
  'Marilândia',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.542, -19.412), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Glória
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-gloria-baixo-guandu-es',
  'Paróquia Nossa Senhora da Glória',
  'parish',
  'latin',
  'BR',
  'active',
  1935,
  'Paróquia na divisa com Minas Gerais em Baixo Guandu.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Glória
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-gloria-baixo-guandu-es'),
  'site-nossa-senhora-da-gloria-baixo-guandu-es',
  'Igreja Matriz Nossa Senhora da Glória',
  'parish_church',
  'Praça São Pedro, s/n - Centro',
  'Baixo Guandu',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-41.015, -19.518), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santa Teresinha do Menino Jesus
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santa-teresinha-santa-teresa-es',
  'Paróquia Santa Teresinha do Menino Jesus',
  'parish',
  'latin',
  'BR',
  'active',
  1937,
  'Matriz histórica de Santa Teresa na região de colonização italiana.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santa Teresinha
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santa-teresinha-santa-teresa-es'),
  'site-paroquia-santa-teresinha-santa-teresa-es',
  'Igreja Matriz Santa Teresinha',
  'parish_church',
  'R. Jerônimo Verlato, s/n - Centro',
  'Santa Teresa',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.601, -19.935), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santo Antônio
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santo-antonio-itarana-es',
  'Paróquia Santo Antônio',
  'parish',
  'latin',
  'BR',
  'active',
  1964,
  'Paróquia Santo Antônio em Itarana.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santo Antônio
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santo-antonio-itarana-es'),
  'site-santo-antonio-itarana-es',
  'Igreja Matriz Santo Antônio',
  'parish_church',
  'Praça Fructuoso de Lima, s/n - Centro',
  'Itarana',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.875, -19.873), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora Medianeira
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-medianeira-itaguacu-es',
  'Paróquia Nossa Senhora Medianeira',
  'parish',
  'latin',
  'BR',
  'active',
  1958,
  'Paróquia em Itaguaçu.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora Medianeira
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-medianeira-itaguacu-es'),
  'site-nossa-senhora-medianeira-itaguacu-es',
  'Igreja Matriz Nossa Senhora Medianeira',
  'parish_church',
  'Praça da Matriz, s/n - Centro',
  'Itaguaçu',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.855, -19.802), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Graças
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-gracas-governador-lindenberg-es',
  'Paróquia Nossa Senhora das Graças',
  'parish',
  'latin',
  'BR',
  'active',
  1998,
  'Paróquia em Governador Lindenberg.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Graças
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-gracas-governador-lindenberg-es'),
  'site-nossa-senhora-das-gracas-governador-lindenberg-es',
  'Igreja Matriz Nossa Senhora das Graças',
  'parish_church',
  'Praça Central, s/n - Centro',
  'Governador Lindenberg',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.472, -19.288), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Sebastião
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-sebastiao-novo-brasil-governador-lindenberg-es',
  'Paróquia São Sebastião',
  'parish',
  'latin',
  'BR',
  'active',
  2002,
  'Paróquia em Novo Brasil, Governador Lindenberg.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Sebastião
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-sebastiao-novo-brasil-governador-lindenberg-es'),
  'site-sao-sebastiao-novo-brasil-governador-lindenberg-es',
  'Igreja Matriz São Sebastião',
  'parish_church',
  'R. Principal - Novo Brasil',
  'Governador Lindenberg',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.512, -19.321), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Domingos
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-domingos-sao-domingos-do-norte-es',
  'Paróquia São Domingos',
  'parish',
  'latin',
  'BR',
  'active',
  1990,
  'Paróquia em São Domingos do Norte.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Domingos
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-domingos-sao-domingos-do-norte-es'),
  'site-sao-domingos-sao-domingos-do-norte-es',
  'Igreja Matriz São Domingos',
  'parish_church',
  'Praça da Matriz, s/n - Centro',
  'São Domingos do Norte',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.635, -19.145), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Graças
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-gracas-sao-roque-do-canaa-es',
  'Paróquia Nossa Senhora das Graças',
  'parish',
  'latin',
  'BR',
  'active',
  1995,
  'Paróquia em São Roque do Canaã.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Graças
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-gracas-sao-roque-do-canaa-es'),
  'site-nossa-senhora-das-gracas-sao-roque-do-canaa-es',
  'Igreja Matriz Nossa Senhora das Graças',
  'parish_church',
  'Praça da Matriz, s/n - Centro',
  'São Roque do Canaã',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.658, -19.738), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Catedral São Mateus
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-sao-mateus-sao-mateus-es',
  'Paróquia Catedral São Mateus',
  'parish',
  'latin',
  'BR',
  'active',
  1958,
  'Catedral São Mateus, sede da Diocese de São Mateus no Norte do Espírito Santo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral São Mateus
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-sao-mateus-sao-mateus-es'),
  'site-catedral-sao-mateus-sao-mateus-es',
  'Catedral São Mateus',
  'cathedral',
  'Praça Anchieta, s/n - Centro',
  'São Mateus',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-39.8588, -18.7165), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santo Antônio
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santo-antonio-guriri-sao-mateus-es',
  'Paróquia Santo Antônio',
  'parish',
  'latin',
  'BR',
  'active',
  1990,
  'Paróquia Santo Antônio na ilha de Guriri, São Mateus.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santo Antônio
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santo-antonio-guriri-sao-mateus-es'),
  'site-santo-antonio-guriri-sao-mateus-es',
  'Igreja Matriz Santo Antônio',
  'parish_church',
  'Av. Oceano Atlântico, s/n - Guriri',
  'São Mateus',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-39.752, -18.742), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Daniel Comboni
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-daniel-comboni-sao-mateus-es',
  'Paróquia Daniel Comboni',
  'parish',
  'latin',
  'BR',
  'active',
  2005,
  'Paróquia dedicada ao missionário São Daniel Comboni em São Mateus.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Daniel Comboni
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-daniel-comboni-sao-mateus-es'),
  'site-daniel-comboni-sao-mateus-es',
  'Igreja Matriz Daniel Comboni',
  'parish_church',
  'R. Monsenhor Guilherme, s/n - Bairro Ideal',
  'São Mateus',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-39.782, -18.728), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Conceição
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-conceicao-conceicao-da-barra-es',
  'Paróquia Nossa Senhora da Conceição',
  'parish',
  'latin',
  'BR',
  'active',
  1596,
  'Matriz histórica de Nossa Senhora da Conceição em Conceição da Barra.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Conceição
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-conceicao-conceicao-da-barra-es'),
  'site-nossa-senhora-da-conceicao-conceicao-da-barra-es',
  'Igreja Matriz Nossa Senhora da Conceição',
  'parish_church',
  'Praça Matriz, s/n - Centro',
  'Conceição da Barra',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-39.732, -18.593), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Cipriano
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-cipriano-jaguare-es',
  'Paróquia São Cipriano',
  'parish',
  'latin',
  'BR',
  'active',
  1981,
  'Paróquia São Cipriano em Jaguaré.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Cipriano
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-cipriano-jaguare-es'),
  'site-sao-cipriano-jaguare-es',
  'Igreja Matriz São Cipriano',
  'parish_church',
  'Praça da Matriz, s/n - Centro',
  'Jaguaré',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.076, -18.907), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Graças
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-gracas-nova-venecia-es',
  'Paróquia Nossa Senhora das Graças',
  'parish',
  'latin',
  'BR',
  'active',
  1954,
  'Paróquia Nossa Senhora das Graças em Nova Venécia.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Graças
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-gracas-nova-venecia-es'),
  'site-paroquia-nossa-senhora-das-gracas-nova-venecia-es',
  'Igreja Matriz Nossa Senhora das Graças',
  'parish_church',
  'R. Eurico Salles, s/n - Centro',
  'Nova Venécia',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.401, -18.715), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Marcos
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-marcos-nova-venecia-es',
  'Paróquia São Marcos',
  'parish',
  'latin',
  'BR',
  'active',
  1985,
  'Paróquia São Marcos em Nova Venécia.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Marcos
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-marcos-nova-venecia-es'),
  'site-sao-marcos-nova-venecia-es',
  'Igreja Matriz São Marcos',
  'parish_church',
  'Av. São Mateus, s/n - Centro',
  'Nova Venécia',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.403, -18.712), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-pinheiros-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  1964,
  'Paróquia São José em Pinheiros.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-pinheiros-es'),
  'site-sao-jose-pinheiros-es',
  'Igreja Matriz São José',
  'parish_church',
  'Praça Baianão, s/n - Centro',
  'Pinheiros',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.217, -18.406), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santo Antônio
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santo-antonio-pedro-canario-es',
  'Paróquia Santo Antônio',
  'parish',
  'latin',
  'BR',
  'active',
  1983,
  'Paróquia Santo Antônio em Pedro Canário.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Santo Antônio
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santo-antonio-pedro-canario-es'),
  'site-santo-antonio-pedro-canario-es',
  'Igreja Matriz Santo Antônio',
  'parish_church',
  'Praça Castro Alves, s/n - Centro',
  'Pedro Canário',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.151, -18.252), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Francisco de Assis
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-francisco-de-assis-barra-de-sao-francisco-es',
  'Paróquia São Francisco de Assis',
  'parish',
  'latin',
  'BR',
  'active',
  1943,
  'Paróquia Matriz em Barra de São Francisco.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Francisco de Assis
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-francisco-de-assis-barra-de-sao-francisco-es'),
  'site-sao-francisco-de-assis-barra-de-sao-francisco-es',
  'Igreja Matriz São Francisco de Assis',
  'parish_church',
  'Praça Arlindo Pinto da Silva, s/n - Centro',
  'Barra de São Francisco',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.891, -18.755), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Penha
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-penha-boa-esperanca-es',
  'Paróquia Nossa Senhora da Penha',
  'parish',
  'latin',
  'BR',
  'active',
  1965,
  'Paróquia em Boa Esperança.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Penha
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-penha-boa-esperanca-es'),
  'site-nossa-senhora-da-penha-boa-esperanca-es',
  'Igreja Matriz Nossa Senhora da Penha',
  'parish_church',
  'Praça da Matriz, s/n - Centro',
  'Boa Esperança',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.383, -18.54), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-mucurici-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  1953,
  'Paróquia na divisa extrema norte do ES em Mucurici.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-mucurici-es'),
  'site-sao-jose-mucurici-es',
  'Igreja Matriz São José',
  'parish_church',
  'Praça São José, s/n - Centro',
  'Mucurici',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.518, -18.093), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-montanha-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  1955,
  'Paróquia São José em Montanha.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-montanha-es'),
  'site-sao-jose-montanha-es',
  'Igreja Matriz São José',
  'parish_church',
  'Praça Oswaldo Gutierrez, s/n - Centro',
  'Montanha',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.363, -18.126), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Penha
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-da-penha-ponto-belo-es',
  'Paróquia Nossa Senhora da Penha',
  'parish',
  'latin',
  'BR',
  'active',
  1994,
  'Paróquia em Ponto Belo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Penha
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-da-penha-ponto-belo-es'),
  'site-nossa-senhora-da-penha-ponto-belo-es',
  'Igreja Matriz Nossa Senhora da Penha',
  'parish_church',
  'Praça Central, s/n - Centro',
  'Ponto Belo',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.542, -18.122), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José Operário
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-operario-ecoporanga-es',
  'Paróquia São José Operário',
  'parish',
  'latin',
  'BR',
  'active',
  1955,
  'Paróquia São José Operário em Ecoporanga.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José Operário
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-operario-ecoporanga-es'),
  'site-sao-jose-operario-ecoporanga-es',
  'Igreja Matriz São José Operário',
  'parish_church',
  'Praça João Filho, s/n - Centro',
  'Ecoporanga',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.831, -18.373), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora de Lourdes
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-de-lourdes-agua-doce-do-norte-es',
  'Paróquia Nossa Senhora de Lourdes',
  'parish',
  'latin',
  'BR',
  'active',
  1988,
  'Paróquia em Água Doce do Norte.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora de Lourdes
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-de-lourdes-agua-doce-do-norte-es'),
  'site-nossa-senhora-de-lourdes-agua-doce-do-norte-es',
  'Igreja Matriz Nossa Senhora de Lourdes',
  'parish_church',
  'Praça da Matriz, s/n - Centro',
  'Água Doce do Norte',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.985, -18.545), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São José
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-jose-aguia-branca-es',
  'Paróquia São José',
  'parish',
  'latin',
  'BR',
  'active',
  1988,
  'Paróquia São José em Águia Branca.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São José
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-jose-aguia-branca-es'),
  'site-sao-jose-aguia-branca-es',
  'Igreja Matriz São José',
  'parish_church',
  'Praça Três de Maio, s/n - Centro',
  'Águia Branca',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.741, -18.984), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Graças
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-das-gracas-vila-valerio-es',
  'Paróquia Nossa Senhora das Graças',
  'parish',
  'latin',
  'BR',
  'active',
  1994,
  'Paróquia em Vila Valério.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora das Graças
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-das-gracas-vila-valerio-es'),
  'site-nossa-senhora-das-gracas-vila-valerio-es',
  'Igreja Matriz Nossa Senhora das Graças',
  'parish_church',
  'Praça da Matriz, s/n - Centro',
  'Vila Valério',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.389, -18.995), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Luiz Gonzaga
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-sao-luiz-gonzaga-vila-pavao-es',
  'Paróquia São Luiz Gonzaga',
  'parish',
  'latin',
  'BR',
  'active',
  1992,
  'Paróquia São Luiz Gonzaga em Vila Pavão.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Luiz Gonzaga
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-sao-luiz-gonzaga-vila-pavao-es'),
  'site-sao-luiz-gonzaga-vila-pavao-es',
  'Igreja Matriz São Luiz Gonzaga',
  'parish_church',
  'Praça do Bano, s/n - Centro',
  'Vila Pavão',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-40.612, -18.614), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora dos Navegantes
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-nossa-senhora-dos-navegantes-braco-do-rio-conceicao-da-barra-es',
  'Paróquia Nossa Senhora dos Navegantes',
  'parish',
  'latin',
  'BR',
  'active',
  1996,
  'Paróquia no distrito de Braço do Rio, Conceição da Barra.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora dos Navegantes
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-nossa-senhora-dos-navegantes-braco-do-rio-conceicao-da-barra-es'),
  'site-nossa-senhora-dos-navegantes-braco-do-rio-conceicao-da-barra-es',
  'Igreja Matriz Nossa Senhora dos Navegantes',
  'parish_church',
  'Av. Principal - Braço do Rio',
  'Conceição da Barra',
  'Espírito Santo',
  'BR',
  st_setsrid(st_makepoint(-39.852, -18.412), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

commit;
