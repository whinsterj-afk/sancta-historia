alter table saints
  add column if not exists birth_lat double precision,
  add column if not exists birth_lng double precision,
  add column if not exists death_lat double precision,
  add column if not exists death_lng double precision;
