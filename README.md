# Absensi & Manajemen Operasional — SAR Surabaya

Repository ini berisi aplikasi web berbasis Flask untuk manajemen kepegawaian dan operasional SAR Surabaya. Aplikasi menyediakan fungsionalitas utama seperti pencatatan absensi, pengelolaan data pegawai, jadwal siaga, pengumuman, serta rekapitulasi laporan.

---

## Ringkasan Fitur

- Dashboard informasi dan rekapitulasi
- Manajemen data pegawai (CRUD)
- Sistem absensi (check-in / check-out / import fingerprint)
- Pengelolaan jadwal siaga
- Pengajuan dan pencatatan izin (sakit, cuti)
- Media informasi / pengumuman internal
- Arsip data personal pegawai dan histori aktivitas

## Teknologi

- Backend: Python 3.12, Flask
- Database: MySQL / MariaDB
- Templating: Jinja2
- Frontend: HTML, CSS, JavaScript
- Dependency management: pip (requirements.txt)

## Struktur Proyek (ringkasan)

Root repo:

```
absensi-sar-surabaya/
├── app/                        # Aplikasi Flask (controllers, models, routes, templates, static)
│   ├── development/            # Folder khusus untuk artefak pengembangan
│   │   ├── frontend/           # Halaman static / mockup frontend (HTML/CSS/JS)
│   │   └── schema_usecase/     # CDM / PDM / gambar struktur DB / file .sql
│   ├── controllers/            # Controller / handler
│   ├── models/                 # Model database (ORM/akses DB)
│   ├── routes/                 # Definisi endpoint
│   ├── utils/                  # Fungsi utilitas
│   ├── templates/              # Template Jinja2
│   └── static/                 # Static assets untuk template
├── testing/                    # Skrip pengujian
├── .env.example                # Contoh variabel lingkungan
├── config.py                   # Konfigurasi aplikasi (DB uri, dsb)
├── app.py                      # Entry point aplikasi
├── requirements.txt            # Ketergantungan Python
└── README.md                   # Dokumen ini
```

---

## Development folder (penting)

Folder `development/` berfungsi sebagai tempat menyimpan artefak yang berguna untuk pengembangan dan dokumentasi desain database. Susunan yang direkomendasikan:

- development/frontend/
  - berisi halaman statis (HTML/CSS/JS) yang digunakan sebagai mockup atau referensi tampilan aplikasi.
  - cocok untuk menyimpan prototype UI, assets, dan dokumentasi frontend.

- development/schema_usecase/
  - cdm/ -> file gambar/diagram CDM (Conceptual Data Model) dalam format PNG/SVG
  - pdm/ -> file gambar/diagram PDM (Physical Data Model) dalam format PNG/SVG
  - images/ -> gambar pendukung (mis. diagram ERD, skema relasi)
  - sql/ -> file SQL untuk membuat skema (create tables, indices) dan seed data
  - README.md -> penjelasan singkat tentang isi folder schema_usecase dan instruksi impor

Contoh isi folder `development/`:

```
development/
├── frontend/
│   ├── index.html
│   ├── css/
│   └── js/
└── schema_usecase/
    ├── cdm/
    │   └── cdm_absensi.png
    ├── pdm/
    │   └── pdm_absensi.png
    ├── images/
    │   └── erd.png
    └── sql/
        ├── schema_basarnas.sql
        └── seed_sample_data.sql
```

---

## Instalasi & Pengaturan (lokal)

1. Clone repository

   git clone https://github.com/GhandiZero0X/absensi-sar-surabaya.git
   cd absensi-sar-surabaya

2. (Opsional) Buat virtual environment dan aktifkan

   python -m venv .venv
   .\.venv\Scripts\activate

3. Install dependency

   pip install -r requirements.txt

4. Buat file lingkungan dari contoh

   copy .env.example .env

   Buka `.env` dan atur variabel yang diperlukan (contoh di .env.example). Biasanya yang perlu diisi:
   - DATABASE_HOST
   - DATABASE_PORT
   - DATABASE_USER
   - DATABASE_PASSWORD
   - DATABASE_NAME
   - SECRET_KEY

5. Buat database di MySQL / MariaDB

   -- di MySQL:
   CREATE DATABASE basarnas_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

6. Impor skema dan data awal

   Jika ada file SQL di development/schema_usecase/sql/schema_basarnas.sql, jalankan:

   mysql -u <user> -p basarnas_db < development\schema_usecase\sql\schema_basarnas.sql

   Jika ada seed data, impor juga file seed:

   mysql -u <user> -p basarnas_db < development\schema_usecase\sql\seed_sample_data.sql

7. Konfigurasi koneksi database di `config.py` atau menggunakan variabel lingkungan pada `.env`.

8. Menjalankan aplikasi (development)

   python app.py

   Setelah berjalan, buka http://localhost:5000 (atau port yang dikonfigurasi).

---

## Ringkasan modul penting

- app/controllers/ — logika permintaan dan endpoint level aplikasi
- app/models/ — kelas-kelas akses dan definisi tabel yang dipakai aplikasi
- app/routes/routes.py — peta route (banyak route ada di file ini)
- app/templates/ — template Jinja2 untuk tampilan
- app/static/ — aset statis (CSS, JS, gambar)
- config.py — konfigurasi koneksi dan opsi aplikasi
- app.py — entry point aplikasi (inisialisasi Flask dan run server)

---

## Database & Model

Model dan tabel yang ada di `app/models/` mencakup entitas utama kebutuhan absensi dan pegawai (mis. pegawai, absensi, jadwal, tim siaga, otorisasi, media informasi, dsb). Untuk informasi detail struktur, buka diagram PDM/CDM di `development/schema_usecase/` atau buka file SQL schema.

Jika perlu mengubah struktur DB, lakukan di file SQL PDM lalu jalankan migrasi/impor ulang pada environment development.

---

## Menjalankan Tes

Jika ada skrip pengujian di folder `testing/` atau `tests/`, jalankan langsung skrip tersebut atau menggunakan pytest (jika terpasang):

pytest -q

Atau jalankan tes spesifik:

python testing\test_connection.py

---

## Kontribusi

- Buat branch baru: feature/<nama-fitur>
- Kerjakan perubahan dan tambahkan unit test bila perlu
- Pastikan tidak menambahkan kredensial atau secrets ke repo
- Ajukan Pull Request ke branch `main` dengan deskripsi perubahan

---

## Catatan Operasional

- Pastikan backup database sebelum menjalankan skrip migrasi di lingkungan produksi.
- Simpan diagram CDM/PDM dan file .sql di `development/schema_usecase/` untuk dokumentasi perubahan skema.
- Jika sistem absensi memakai perangkat fingerprint atau integrasi hardware lain, simpan konfigurasi/hostnames di tabel `hostNameFpModel` atau dokumentasikan pada `development/schema_usecase/README.md`.

---

## Kontak

Untuk pertanyaan pengembangan atau pengaturan lingkungan, hubungi pemilik repo atau maintainer internal tim SAR Surabaya.

---

Lisensi

Lisensi proyek ditetapkan oleh pemilik repo. Jika belum ada file LICENSE, tambahkan sesuai kebijakan organisasi.
