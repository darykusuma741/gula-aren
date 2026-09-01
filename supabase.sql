-- =============================================================
-- Gula Areng — Setup Database Supabase
-- Jalankan seluruh script ini di Supabase: SQL Editor → New query
-- =============================================================

-- 1. Buat tabel produk
create table if not exists products (
  id bigint generated always as identity primary key,
  sort_order int not null default 0,
  badge_id text,          -- label kecil (ID), contoh 'Terlaris' (boleh kosong)
  badge_en text,          -- label kecil (EN), contoh 'Best Seller'
  image text,             -- URL foto produk
  title_id text not null, -- judul produk (ID)
  title_en text not null, -- judul produk (EN)
  desc_id text not null,  -- deskripsi (ID)
  desc_en text not null,  -- deskripsi (EN)
  price_idr int not null, -- harga Rupiah (angka, tanpa titik)
  price_usd numeric(10,2) not null, -- harga USD
  unit_id text not null,  -- satuan (ID), contoh '/ kg'
  unit_en text not null   -- satuan (EN), contoh '/ 35.3 oz'
);

-- 2. Izinkan publik membaca (website tanpa login)
alter table products enable row level security;
create policy "public read" on products for select using (true);

-- 3. Isi data awal (3 produk)
insert into products (sort_order, badge_id, badge_en, image, title_id, title_en, desc_id, desc_en, price_idr, price_usd, unit_id, unit_en) values
(1, 'Terlaris', 'Best Seller',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Gula_aren_semut.jpg/960px-Gula_aren_semut.jpg',
 'Gula Aren Bubuk · 1 Kg', 'Palm Sugar Powder · 1 kg',
 'Bubuk aren murni kemasan besar untuk kebutuhan dapur & produksi usaha. Paling hemat.',
 'Pure palm sugar in a large pack for the kitchen and business production. Best value.',
 35000, 2.20, '/ kg', '/ 35.3 oz'),
(2, null, null,
 'https://upload.wikimedia.org/wikipedia/commons/d/d9/Gula_semut.jpg',
 'Gula Aren Bubuk · 500 gr', 'Palm Sugar Powder · 500 g',
 'Setengah kilo bubuk aren murni, pas untuk stok rumah tangga harian.',
 'Half a kilo of pure palm sugar, perfect for daily household use.',
 20000, 1.25, '/ 500 gr', '/ 17.6 oz'),
(3, null, null,
 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Gula_semut_ranau.jpg/960px-Gula_semut_ranau.jpg',
 'Gula Aren Bubuk · 330 gr', 'Palm Sugar Powder · 330 g',
 'Kemasan kecil bubuk aren murni, cocok untuk mencoba atau oleh-oleh.',
 'Small pack of pure palm sugar, great for trying out or as a gift.',
 15000, 0.95, '/ 330 gr', '/ 11.6 oz');

-- =============================================================
-- Cara update harga / produk nanti:
--   update products set price_idr = 40000, price_usd = 2.50 where id = 1;
--   (atau edit langsung lewat tabel di Dashboard Supabase)
-- =============================================================
