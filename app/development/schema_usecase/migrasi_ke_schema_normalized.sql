/*
Data migration draft from legacy tables to normalized schema.
Run AFTER script_normalized.sql.

Important:
- Backup database first.
- Validate row counts after each block.
*/

USE [HRIS];
GO

/* 1) Master Unit Kerja */
INSERT INTO dbo.RefUnitKerja (UnitKerjaId, UnitKerjaName, IsActive)
SELECT DISTINCT
    COALESCE(NULLIF(LTRIM(RTRIM(IDUnitKerja)), ''), NULLIF(LTRIM(RTRIM(UnitKerjaName)), ''), 'UNKNOWN') AS UnitKerjaId,
    COALESCE(NULLIF(LTRIM(RTRIM(UnitKerjaName)), ''), NULLIF(LTRIM(RTRIM(IDUnitKerja)), ''), 'UNKNOWN') AS UnitKerjaName,
    1
FROM dbo.MFUnitKerja;
GO

/* 2) Master Jabatan */
INSERT INTO dbo.RefJabatan (JabatanId, NamaJabatan, ParentJabatanId, GroupJabatanId, SubGroupJabatanId, TypeJabatan, IsActive)
SELECT DISTINCT
    JabatanID,
    COALESCE(NULLIF(LTRIM(RTRIM(NamaJabatan)), ''), CONCAT('Jabatan-', JabatanID)),
    ParentID,
    IDGroupJabatan,
    IDSubGroupJabatan,
    TypeJabatan,
    CASE WHEN ISNULL(IsUse, 'Y') IN ('N','0') THEN 0 ELSE 1 END
FROM dbo.MFJabatan
WHERE JabatanID IS NOT NULL;
GO

/* 3) Master Golongan */
INSERT INTO dbo.RefGolongan (GolonganCode, Pangkat, Urutan, GroupGol)
SELECT DISTINCT
    LTRIM(RTRIM(Gol)),
    Pangkat,
    Urutan,
    GroupGol
FROM dbo.MFGol
WHERE NULLIF(LTRIM(RTRIM(Gol)), '') IS NOT NULL;
GO

/* 4) Master Status Pegawai */
INSERT INTO dbo.RefStatusPegawai (StatusPegawaiId, StatusPegawaiName)
SELECT DISTINCT
    StatusPeg,
    CONCAT('Status-', StatusPeg)
FROM dbo.Pegawai
WHERE StatusPeg IS NOT NULL;
GO

/* 5) Ref Shift */
INSERT INTO dbo.RefShift (ShiftId, NamaShift, StartTime, EndTime, TglMulaiBerlaku)
SELECT DISTINCT
    ShiftID,
    COALESCE(NULLIF(LTRIM(RTRIM(NamaShift)), ''), ShiftID),
    CAST(StartShift AS TIME(0)),
    CAST(EndShift AS TIME(0)),
    TglMulaiBerlaku
FROM dbo.MFShift
WHERE NULLIF(LTRIM(RTRIM(ShiftID)), '') IS NOT NULL;
GO

/* 6) Pegawai Core */
INSERT INTO dbo.PegawaiCore (
    NIP, FingerID, Nama, GolonganCode, JabatanId, UnitKerjaId, StatusPegawaiId,
    IsVip, IsKeluar, TglMasuk, TglKeluar, AlasanKeluar, UpdatedAt
)
SELECT
    p.NIP,
    LTRIM(RTRIM(CONVERT(NVARCHAR(10), p.FingerID))),
    p.Nama,
    NULLIF(LTRIM(RTRIM(p.Gol)), ''),
    p.JabatanID,
    COALESCE(NULLIF(LTRIM(RTRIM(u.IDUnitKerja)), ''), 'UNKNOWN'),
    p.StatusPeg,
    CASE WHEN ISNULL(p.IsVIP, 'N') = 'Y' THEN 1 ELSE 0 END,
    CASE WHEN ISNULL(p.isKeluar, 'N') = 'Y' THEN 1 ELSE 0 END,
    CAST(p.TglMasuk AS DATE),
    CAST(p.Tglkeluar AS DATE),
    p.AlasanKeluar,
    ISNULL(p.UpdateDate, SYSDATETIME())
FROM dbo.Pegawai p
LEFT JOIN dbo.MFUnitKerja u
    ON u.UnitKerjaName = p.UnitKerja;
GO

/* 7) Pegawai Profile */
INSERT INTO dbo.PegawaiProfile (
    PegawaiId, TempatLahir, TglLahir, JenisKelamin, Agama, StatusPerkawinan,
    Alamat, Kelurahan, Kecamatan, Kota, NoTelp, Email, NoKTP, NoNPWP, Hobi
)
SELECT
    pc.PegawaiId,
    p.TempatLahir,
    CAST(p.TglLahir AS DATE),
    p.JenisKel,
    p.Agama,
    p.StatusPerkawinan,
    p.Alamat,
    p.Kelurahan,
    p.Kecamatan,
    p.Kota,
    p.NoTelp,
    p.Mail,
    p.NoKTP,
    p.NoNPWP,
    p.Hobi
FROM dbo.Pegawai p
INNER JOIN dbo.PegawaiCore pc
    ON pc.NIP = p.NIP;
GO

/* 8) Absensi Core */
INSERT INTO dbo.AbsensiCore (
    PegawaiId, TglKerja, JamIn, JamOut, JamBakuIn, JamBakuOut,
    TingkatTLM, TotalTLM, TingkatPSW, TotalPSW,
    PersenPotTLM, PersenPotPSW, IsInValid, IsOutValid, StatusUM, UpdatedAt
)
SELECT
    pc.PegawaiId,
    CAST(a.TglKerja AS DATE),
    a.TglJamIn,
    a.TglJamOut,
    a.TglJamBakuIn,
    a.TglJamBakuOut,
    a.TingkatTLM,
    CONVERT(DECIMAL(10,2), ISNULL(a.TotalTLM, 0)),
    a.TingkatPSW,
    CONVERT(DECIMAL(10,2), ISNULL(a.TotalPSW, 0)),
    CONVERT(DECIMAL(5,2), ISNULL(a.PersenPotTLM, 0)),
    CONVERT(DECIMAL(5,2), ISNULL(a.PersenPotPSW, 0)),
    CASE WHEN ISNULL(a.IsInValid, 'N') = 'Y' THEN 1 ELSE 0 END,
    CASE WHEN ISNULL(a.isOutValid, 'N') = 'Y' THEN 1 ELSE 0 END,
    ISNULL(a.StatusUM, 1),
    ISNULL(a.UpdateOutDate, SYSDATETIME())
FROM dbo.Absensi a
INNER JOIN dbo.PegawaiCore pc
    ON pc.FingerID = LTRIM(RTRIM(a.FingerID));
GO

/* 9) Finger scan log */
INSERT INTO dbo.FingerScanLog (
    PegawaiId, ScanTime, ScanStatus, Mesin, SumberTransaksi, KetInject, ReffInject, UpdatedAt
)
SELECT
    pc.PegawaiId,
    tr.Waktu,
    tr.Status,
    tr.Mesin,
    tr.Transaksi,
    tr.KetInject,
    tr.ReffInject,
    ISNULL(tr.UpdateDate, SYSDATETIME())
FROM dbo.TimeRecorder tr
INNER JOIN dbo.PegawaiCore pc
    ON pc.FingerID = LTRIM(RTRIM(tr.FingerID));
GO

/* 10) Dinas luar */
INSERT INTO dbo.DinasLuarCore (
    PegawaiId, TransaksiID, GUIDSprin, TglAwal, TglAkhir,
    Keterangan, Penempatan, NoSurat, Jenis, Tipe,
    Pendukung, StatusUM, UpdatedBy, UpdatedAt
)
SELECT
    pc.PegawaiId,
    dl.TransaksiID,
    dl.GUIDSprin,
    dl.TglAwaldinasLuar,
    dl.TglAkhirDinasLuar,
    dl.KeteranganDinasLuar,
    dl.PenempatanDinasLuar,
    dl.Nosurat,
    dl.Jenis,
    dl.Tipe,
    CASE WHEN ISNULL(dl.Pendukung, 'N') = 'Y' THEN 1 ELSE 0 END,
    ISNULL(dl.StatusUM, 1),
    dl.UpdateBy,
    ISNULL(dl.UpdateDate, SYSDATETIME())
FROM dbo.DinasLuar dl
INNER JOIN dbo.PegawaiCore pc
    ON pc.FingerID = LTRIM(RTRIM(dl.FingerID));
GO

/* 11) Otorisasi */
INSERT INTO dbo.OtorisasiCore (
    GUIDOto, Trx, LevelOto, PegawaiId, JabatanText, Act, IDUnitKerja,
    Bulan, Tahun, Perihal, Keterangan, TglPengajuan, UpdatedBy, UpdatedAt
)
SELECT
    o.GUIDOto,
    o.Trx,
    ISNULL(o.LevelOto, 0),
    pc.PegawaiId,
    o.Jabatan,
    o.Act,
    o.IDUnitKerja,
    o.Bulan,
    o.Tahun,
    o.Perihal,
    o.Keterangan,
    ISNULL(o.TglPengajuan, SYSDATETIME()),
    o.UpdateBy,
    ISNULL(o.UpdateDate, SYSDATETIME())
FROM dbo.Otorisasi o
LEFT JOIN dbo.PegawaiCore pc
    ON pc.NIP = o.NIP;
GO

/* 12) Otorisasi history */
INSERT INTO dbo.OtorisasiHistoryCore (
    OtorisasiId, Act, Shift1, Shift2, Perihal, Keterangan, ChangedAt, ChangedBy
)
SELECT
    oc.OtorisasiId,
    oh.Act,
    oh.Shift1,
    oh.shift2,
    oh.Perihal,
    oh.Keterangan,
    ISNULL(oh.RecDate, SYSDATETIME()),
    oh.UpdateBy
FROM dbo.OtorisasiHistory oh
INNER JOIN dbo.OtorisasiCore oc
    ON oc.GUIDOto = oh.GUIDOto
   AND oc.Trx = oh.Trx;
GO

/* 13) Team core */
INSERT INTO dbo.TimSiagaCore (
    GUIDTim, NamaTim, IDUnitKerja, ShiftId, BulanPeriode, TahunPeriode, IsActive, UpdatedBy, UpdatedAt
)
SELECT DISTINCT
    t.GUIDTim,
    COALESCE(NULLIF(LTRIM(RTRIM(t.NamaTim)), ''), t.GUIDTim),
    t.IDUnitKerja,
    NULLIF(LTRIM(RTRIM(t.Shift)), ''),
    TRY_CONVERT(TINYINT, t.BulanPeriode),
    TRY_CONVERT(SMALLINT, t.TahunPeriode),
    CASE WHEN ISNULL(t.IsAktif, 'Y') = 'Y' THEN 1 ELSE 0 END,
    t.UpdateBy,
    ISNULL(t.UpdateDate, SYSDATETIME())
FROM dbo.MFTimSiaga t;
GO

/* 14) Team anggota */
INSERT INTO dbo.TimSiagaAnggota (
    GUIDTim, PegawaiId, Fungsional, IsActive, NoUrut, UpdatedBy, UpdatedAt
)
SELECT
    a.GUIDTim,
    pc.PegawaiId,
    a.Fungsional,
    CASE WHEN ISNULL(a.IsAktif, 'Y') = 'Y' THEN 1 ELSE 0 END,
    a.Nourut,
    a.UpdateBy,
    ISNULL(a.UpdateDate, SYSDATETIME())
FROM dbo.MFTimSiagaAnggota a
INNER JOIN dbo.PegawaiCore pc
    ON pc.NIP = a.NIP;
GO

/* Optional cleanup policy suggestion:
- Keep old backup tables as archive only (read-only)
- Stop writing to: AbsensiTemp, Absensibackup, LogActivityBackUp
*/
