-- PENALTITO · táboa do ranking (proxecto "xogos", prefixo pt_)
create table if not exists pt_reto (
  id bigint generated always as identity primary key,
  dia date not null,
  uid text not null check (char_length(uid) between 8 and 40),
  nome text not null check (char_length(nome) between 1 and 16),
  gf int not null check (gf between 0 and 15),
  gc int not null check (gc between 0 and 15),
  paradas int not null check (paradas between 0 and 15),
  tiros int not null check (tiros between 1 and 15),
  resultado text not null check (resultado in ('gana','perde','empate')),
  puntos int not null check (puntos between 0 and 200),
  creado timestamptz not null default now(),
  unique (dia, uid)
);
create index if not exists pt_reto_dia on pt_reto (dia);

alter table pt_reto enable row level security;

drop policy if exists "pt_reto ler" on pt_reto;
create policy "pt_reto ler" on pt_reto for select using (true);

drop policy if exists "pt_reto engadir" on pt_reto;
create policy "pt_reto engadir" on pt_reto for insert
  with check (dia between current_date - 1 and current_date + 1);

-- ===== Para ver o ranking dende outras webs (por exemplo, "cagando") =====
-- Vista só de lectura cos datos públicos do ranking de PENALTITO
create or replace view pt_ranking with (security_invoker = on) as
  select dia, uid, nome, puntos, gf, paradas, resultado, creado from pt_reto;

-- Vista común para xuntar os rankings de varios xogos (engade aquí outros co mesmo formato)
create or replace view ranking_xogos with (security_invoker = on) as
  select 'penaltito'::text as xogo, dia, uid, nome, puntos, creado from pt_reto;

grant select on pt_ranking, ranking_xogos to anon, authenticated;
