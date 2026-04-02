# Rekomendasi Perbaikan Database HRIS

Dokumen ini menjelaskan perbaikan agar schema tidak "bulat" (campur aduk), lebih jelas, dan minim redundansi.

## Masalah Utama di Schema Lama

1. Duplikasi data pegawai
- Identitas pegawai tersebar: `NIP`, `FingerID`, `UnitKerja` tekstual di banyak tabel.
- Potensi inkonsistensi tinggi saat update.

2. Banyak tabel mirip/backup sebagai tabel aktif
- `Absensi`, `AbsensiTemp`, `Absensibackup`
- `LogActivity`, `LogActivityBackUp`

3. Relasi tidak ditegakkan dengan foreign key
- Secara konsep saling terkait, tetapi DB tidak menjaga integritas referensi.

4. Kolom status berbentuk string berulang
- Contoh `Y/N`, `-`, status transaksi teks, menyebabkan data kotor.

5. Tipe data kurang tepat
- Banyak numerik menggunakan `float` (berisiko rounding), sebaiknya `decimal`.
- Tanggal jam kerja bercampur `datetime` padahal hanya butuh `date/time` di beberapa tempat.

## Solusi Normalisasi (3NF)

Schema baru dibagi per domain:

1. Master data
- `RefUnitKerja`
- `RefJabatan`
- `RefGolongan`
- `RefStatusPegawai`
- `RefShift`

2. Core pegawai
- `PegawaiCore` (identitas inti)
- `PegawaiProfile` (detail profil)

3. Attendance
- `AbsensiCore` (header harian)
- `AbsensiEvent` (event in/out/manual)
- `FingerScanLog` (raw log mesin)
- `DinasLuarCore`

4. Authorization
- `OtorisasiCore`
- `OtorisasiHistoryCore`

5. Team operations
- `TimSiagaCore`
- `TimSiagaAnggota`

## File yang Disediakan

1. `script_normalized.sql`
- DDL schema hasil normalisasi.
- Sudah termasuk FK dan index dasar.

2. `migrasi_ke_schema_normalized.sql`
- Draft migrasi data dari tabel lama ke tabel baru.

## Manfaat yang Didapat

1. Redundansi berkurang
- Data pegawai tidak disalin berulang ke banyak tabel.

2. Integritas data meningkat
- FK menjaga referensi valid.

3. Query lebih jelas
- Entitas dan relasi lebih eksplisit.

4. Mudah pemeliharaan
- Perubahan master (jabatan/unit/shift) lebih terkontrol.

## Rekomendasi Implementasi Bertahap

1. Buat schema baru di environment staging.
2. Jalankan `script_normalized.sql`.
3. Jalankan `migrasi_ke_schema_normalized.sql`.
4. Validasi dengan checklist:
- jumlah pegawai lama vs baru
- jumlah absensi harian per tanggal
- jumlah dinas luar dan otorisasi
5. Ubah aplikasi menulis ke tabel baru.
6. Jadikan tabel lama sebagai read-only archive.

## Catatan Kompatibilitas

Jika aplikasi lama belum bisa langsung diubah, buat `VIEW` kompatibilitas dengan nama tabel lama yang membaca dari schema baru. Ini memungkinkan cutover bertahap tanpa downtime besar.
