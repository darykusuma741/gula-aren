-- =============================================================
-- Tabel pengaturan gambar situs (hero, galeri, tentang)
-- =============================================================
create table if not exists settings (
  key text primary key,
  value text not null
);

insert into settings (key, value) values
('hero_img',  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Gula_aren_semut.jpg/960px-Gula_aren_semut.jpg'),
('about_img', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Sang_pembuat_gula_aren.jpg/960px-Sang_pembuat_gula_aren.jpg'),
('gallery_1', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Gula_aren_semut.jpg/960px-Gula_aren_semut.jpg'),
('gallery_2', 'https://upload.wikimedia.org/wikipedia/commons/d/d9/Gula_semut.jpg'),
('gallery_3', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Gula_semut_ranau.jpg/960px-Gula_semut_ranau.jpg'),
('gallery_4', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Ginger_palm_sugar.jpg/960px-Ginger_palm_sugar.jpg')
on conflict (key) do nothing;

alter table settings enable row level security;

drop policy if exists "public read settings" on settings;
drop policy if exists "admin manage settings" on settings;
create policy "public read settings" on settings for select using (true);
create policy "admin manage settings" on settings
  for all using (auth.uid() = 'bc67379b-eefd-4333-a6ad-5a4ff9edad66')
  with check (auth.uid() = 'bc67379b-eefd-4333-a6ad-5a4ff9edad66');
