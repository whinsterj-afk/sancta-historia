delete from public.historical_events
where id = 23
  and year = 1517
  and title = 'Reforma Protestante';

update public.historical_events
set description = 'Concílio ecumênico que reafirmou a doutrina católica e promoveu a renovação da vida da Igreja.'
where id = 8
  and year = 1545
  and title = 'Concílio de Trento';
