/*
Normalized schema proposal for HRIS (3NF-oriented)
Author: GitHub Copilot
Date: 2026-04-02

Goal:
- Reduce redundancy
- Clarify entity boundaries
- Enforce referential integrity with FK
- Keep backward migration possible
*/

USE [HRIS];
GO

/* =========================
   1) REFERENCE / MASTER
   ========================= */

IF OBJECT_ID('dbo.RefUnitKerja', 'U') IS NOT NULL DROP TABLE dbo.RefUnitKerja;
GO
CREATE TABLE dbo.RefUnitKerja (
    UnitKerjaId       NVARCHAR(50) NOT NULL PRIMARY KEY,
    UnitKerjaName     NVARCHAR(100) NOT NULL,
    IsActive          BIT NOT NULL CONSTRAINT DF_RefUnitKerja_IsActive DEFAULT(1),
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_RefUnitKerja_UpdatedAt DEFAULT(SYSDATETIME())
);
GO

IF OBJECT_ID('dbo.RefJabatan', 'U') IS NOT NULL DROP TABLE dbo.RefJabatan;
GO
CREATE TABLE dbo.RefJabatan (
    JabatanId         INT NOT NULL PRIMARY KEY,
    NamaJabatan       NVARCHAR(100) NOT NULL,
    ParentJabatanId   INT NULL,
    GroupJabatanId    INT NULL,
    SubGroupJabatanId INT NULL,
    TypeJabatan       NVARCHAR(20) NULL,
    IsActive          BIT NOT NULL CONSTRAINT DF_RefJabatan_IsActive DEFAULT(1),
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_RefJabatan_UpdatedAt DEFAULT(SYSDATETIME()),
    CONSTRAINT FK_RefJabatan_Parent FOREIGN KEY (ParentJabatanId) REFERENCES dbo.RefJabatan(JabatanId)
);
GO

IF OBJECT_ID('dbo.RefGolongan', 'U') IS NOT NULL DROP TABLE dbo.RefGolongan;
GO
CREATE TABLE dbo.RefGolongan (
    GolonganCode      NVARCHAR(10) NOT NULL PRIMARY KEY,
    Pangkat           NVARCHAR(50) NULL,
    Urutan            INT NULL,
    GroupGol          NVARCHAR(10) NULL
);
GO

IF OBJECT_ID('dbo.RefStatusPegawai', 'U') IS NOT NULL DROP TABLE dbo.RefStatusPegawai;
GO
CREATE TABLE dbo.RefStatusPegawai (
    StatusPegawaiId   INT NOT NULL PRIMARY KEY,
    StatusPegawaiName NVARCHAR(50) NOT NULL
);
GO

IF OBJECT_ID('dbo.RefShift', 'U') IS NOT NULL DROP TABLE dbo.RefShift;
GO
CREATE TABLE dbo.RefShift (
    ShiftId           NVARCHAR(10) NOT NULL PRIMARY KEY,
    NamaShift         NVARCHAR(50) NOT NULL,
    StartTime         TIME(0) NULL,
    EndTime           TIME(0) NULL,
    TglMulaiBerlaku   DATE NULL
);
GO

/* =========================
   2) CORE HR
   ========================= */

IF OBJECT_ID('dbo.PegawaiCore', 'U') IS NOT NULL DROP TABLE dbo.PegawaiCore;
GO
CREATE TABLE dbo.PegawaiCore (
    PegawaiId         BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NIP               NVARCHAR(50) NOT NULL UNIQUE,
    FingerID          NVARCHAR(10) NOT NULL UNIQUE,
    Nama              NVARCHAR(70) NOT NULL,
    GolonganCode      NVARCHAR(10) NULL,
    JabatanId         INT NULL,
    UnitKerjaId       NVARCHAR(50) NULL,
    StatusPegawaiId   INT NULL,
    IsVip             BIT NOT NULL CONSTRAINT DF_PegawaiCore_IsVip DEFAULT(0),
    IsKeluar          BIT NOT NULL CONSTRAINT DF_PegawaiCore_IsKeluar DEFAULT(0),
    TglMasuk          DATE NULL,
    TglKeluar         DATE NULL,
    AlasanKeluar      NVARCHAR(250) NULL,
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_PegawaiCore_UpdatedAt DEFAULT(SYSDATETIME()),
    CONSTRAINT FK_PegawaiCore_RefGolongan FOREIGN KEY (GolonganCode) REFERENCES dbo.RefGolongan(GolonganCode),
    CONSTRAINT FK_PegawaiCore_RefJabatan FOREIGN KEY (JabatanId) REFERENCES dbo.RefJabatan(JabatanId),
    CONSTRAINT FK_PegawaiCore_RefUnitKerja FOREIGN KEY (UnitKerjaId) REFERENCES dbo.RefUnitKerja(UnitKerjaId),
    CONSTRAINT FK_PegawaiCore_RefStatusPegawai FOREIGN KEY (StatusPegawaiId) REFERENCES dbo.RefStatusPegawai(StatusPegawaiId)
);
GO

IF OBJECT_ID('dbo.PegawaiProfile', 'U') IS NOT NULL DROP TABLE dbo.PegawaiProfile;
GO
CREATE TABLE dbo.PegawaiProfile (
    PegawaiId         BIGINT NOT NULL PRIMARY KEY,
    TempatLahir       NVARCHAR(100) NULL,
    TglLahir          DATE NULL,
    JenisKelamin      NVARCHAR(15) NULL,
    Agama             NVARCHAR(100) NULL,
    StatusPerkawinan  NVARCHAR(20) NULL,
    Alamat            NVARCHAR(250) NULL,
    Kelurahan         NVARCHAR(50) NULL,
    Kecamatan         NVARCHAR(50) NULL,
    Kota              NVARCHAR(50) NULL,
    NoTelp            NVARCHAR(50) NULL,
    Email             NVARCHAR(100) NULL,
    NoKTP             NVARCHAR(50) NULL,
    NoNPWP            NVARCHAR(50) NULL,
    Hobi              NVARCHAR(150) NULL,
    CONSTRAINT FK_PegawaiProfile_PegawaiCore FOREIGN KEY (PegawaiId) REFERENCES dbo.PegawaiCore(PegawaiId)
);
GO

/* =========================
   3) ATTENDANCE
   ========================= */

IF OBJECT_ID('dbo.AbsensiCore', 'U') IS NOT NULL DROP TABLE dbo.AbsensiCore;
GO
CREATE TABLE dbo.AbsensiCore (
    AbsensiId         BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    PegawaiId         BIGINT NOT NULL,
    TglKerja          DATE NOT NULL,
    JamIn             DATETIME2(0) NULL,
    JamOut            DATETIME2(0) NULL,
    JamBakuIn         DATETIME2(0) NULL,
    JamBakuOut        DATETIME2(0) NULL,
    TingkatTLM        NVARCHAR(50) NULL,
    TotalTLM          DECIMAL(10,2) NOT NULL CONSTRAINT DF_AbsensiCore_TotalTLM DEFAULT(0),
    TingkatPSW        NVARCHAR(50) NULL,
    TotalPSW          DECIMAL(10,2) NOT NULL CONSTRAINT DF_AbsensiCore_TotalPSW DEFAULT(0),
    PersenPotTLM      DECIMAL(5,2) NOT NULL CONSTRAINT DF_AbsensiCore_PersenPotTLM DEFAULT(0),
    PersenPotPSW      DECIMAL(5,2) NOT NULL CONSTRAINT DF_AbsensiCore_PersenPotPSW DEFAULT(0),
    IsInValid         BIT NOT NULL CONSTRAINT DF_AbsensiCore_IsInValid DEFAULT(0),
    IsOutValid        BIT NOT NULL CONSTRAINT DF_AbsensiCore_IsOutValid DEFAULT(0),
    StatusUM          INT NOT NULL CONSTRAINT DF_AbsensiCore_StatusUM DEFAULT(1),
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_AbsensiCore_UpdatedAt DEFAULT(SYSDATETIME()),
    CONSTRAINT UQ_AbsensiCore UNIQUE (PegawaiId, TglKerja),
    CONSTRAINT FK_AbsensiCore_PegawaiCore FOREIGN KEY (PegawaiId) REFERENCES dbo.PegawaiCore(PegawaiId)
);
GO

IF OBJECT_ID('dbo.AbsensiEvent', 'U') IS NOT NULL DROP TABLE dbo.AbsensiEvent;
GO
CREATE TABLE dbo.AbsensiEvent (
    EventId           BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    AbsensiId         BIGINT NOT NULL,
    EventType         NVARCHAR(20) NOT NULL, -- IN, OUT, MANUAL, INJECT
    EventTime         DATETIME2(0) NOT NULL,
    Mesin             NVARCHAR(100) NULL,
    Transaksi         NVARCHAR(50) NULL,
    Keterangan        NVARCHAR(850) NULL,
    Pendukung         BIT NOT NULL CONSTRAINT DF_AbsensiEvent_Pendukung DEFAULT(0),
    UpdatedBy         NVARCHAR(50) NULL,
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_AbsensiEvent_UpdatedAt DEFAULT(SYSDATETIME()),
    CONSTRAINT FK_AbsensiEvent_AbsensiCore FOREIGN KEY (AbsensiId) REFERENCES dbo.AbsensiCore(AbsensiId)
);
GO

IF OBJECT_ID('dbo.FingerScanLog', 'U') IS NOT NULL DROP TABLE dbo.FingerScanLog;
GO
CREATE TABLE dbo.FingerScanLog (
    FingerScanId      BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    PegawaiId         BIGINT NOT NULL,
    ScanTime          DATETIME2(0) NOT NULL,
    ScanStatus        NVARCHAR(3) NOT NULL,
    Mesin             NVARCHAR(100) NOT NULL,
    SumberTransaksi   NVARCHAR(50) NULL,
    KetInject         NVARCHAR(150) NULL,
    ReffInject        NVARCHAR(150) NULL,
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_FingerScanLog_UpdatedAt DEFAULT(SYSDATETIME()),
    CONSTRAINT FK_FingerScanLog_PegawaiCore FOREIGN KEY (PegawaiId) REFERENCES dbo.PegawaiCore(PegawaiId)
);
GO

IF OBJECT_ID('dbo.DinasLuarCore', 'U') IS NOT NULL DROP TABLE dbo.DinasLuarCore;
GO
CREATE TABLE dbo.DinasLuarCore (
    DinasLuarId       BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    PegawaiId         BIGINT NOT NULL,
    TransaksiID       NVARCHAR(50) NOT NULL UNIQUE,
    GUIDSprin         NVARCHAR(100) NULL,
    TglAwal           DATETIME2(0) NULL,
    TglAkhir          DATETIME2(0) NULL,
    Keterangan        NVARCHAR(450) NULL,
    Penempatan        NVARCHAR(350) NULL,
    NoSurat           NVARCHAR(250) NULL,
    Jenis             NVARCHAR(20) NULL,
    Tipe              INT NULL,
    Pendukung         BIT NOT NULL CONSTRAINT DF_DinasLuarCore_Pendukung DEFAULT(0),
    StatusUM          INT NOT NULL CONSTRAINT DF_DinasLuarCore_StatusUM DEFAULT(1),
    UpdatedBy         NVARCHAR(50) NULL,
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_DinasLuarCore_UpdatedAt DEFAULT(SYSDATETIME()),
    CONSTRAINT FK_DinasLuarCore_PegawaiCore FOREIGN KEY (PegawaiId) REFERENCES dbo.PegawaiCore(PegawaiId)
);
GO

/* =========================
   4) AUTHORIZATION
   ========================= */

IF OBJECT_ID('dbo.OtorisasiCore', 'U') IS NOT NULL DROP TABLE dbo.OtorisasiCore;
GO
CREATE TABLE dbo.OtorisasiCore (
    OtorisasiId       BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    GUIDOto           NVARCHAR(100) NOT NULL,
    Trx               NVARCHAR(50) NOT NULL,
    LevelOto          INT NOT NULL,
    PegawaiId         BIGINT NULL,
    JabatanText       NVARCHAR(100) NULL,
    Act               INT NULL,
    IDUnitKerja       NVARCHAR(25) NULL,
    Bulan             INT NULL,
    Tahun             INT NULL,
    Perihal           NVARCHAR(150) NULL,
    Keterangan        NVARCHAR(150) NULL,
    TglPengajuan      DATETIME2(0) NOT NULL CONSTRAINT DF_OtorisasiCore_TglPengajuan DEFAULT(SYSDATETIME()),
    UpdatedBy         NVARCHAR(50) NULL,
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_OtorisasiCore_UpdatedAt DEFAULT(SYSDATETIME()),
    CONSTRAINT FK_OtorisasiCore_PegawaiCore FOREIGN KEY (PegawaiId) REFERENCES dbo.PegawaiCore(PegawaiId)
);
GO

IF OBJECT_ID('dbo.OtorisasiHistoryCore', 'U') IS NOT NULL DROP TABLE dbo.OtorisasiHistoryCore;
GO
CREATE TABLE dbo.OtorisasiHistoryCore (
    OtorisasiHistoryId BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OtorisasiId        BIGINT NOT NULL,
    Act                INT NULL,
    Shift1             INT NULL,
    Shift2             INT NULL,
    Perihal            NVARCHAR(150) NULL,
    Keterangan         NVARCHAR(150) NULL,
    ChangedAt          DATETIME2(0) NOT NULL CONSTRAINT DF_OtorisasiHistoryCore_ChangedAt DEFAULT(SYSDATETIME()),
    ChangedBy          NVARCHAR(50) NULL,
    CONSTRAINT FK_OtorisasiHistoryCore_OtorisasiCore FOREIGN KEY (OtorisasiId) REFERENCES dbo.OtorisasiCore(OtorisasiId)
);
GO

/* =========================
   5) TEAM / OPERATIONS
   ========================= */

IF OBJECT_ID('dbo.TimSiagaCore', 'U') IS NOT NULL DROP TABLE dbo.TimSiagaCore;
GO
CREATE TABLE dbo.TimSiagaCore (
    GUIDTim           NVARCHAR(50) NOT NULL PRIMARY KEY,
    NamaTim           NVARCHAR(50) NOT NULL,
    IDUnitKerja       NVARCHAR(50) NULL,
    ShiftId           NVARCHAR(10) NULL,
    BulanPeriode      TINYINT NULL,
    TahunPeriode      SMALLINT NULL,
    IsActive          BIT NOT NULL CONSTRAINT DF_TimSiagaCore_IsActive DEFAULT(1),
    UpdatedBy         NVARCHAR(50) NULL,
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_TimSiagaCore_UpdatedAt DEFAULT(SYSDATETIME()),
    CONSTRAINT FK_TimSiagaCore_Shift FOREIGN KEY (ShiftId) REFERENCES dbo.RefShift(ShiftId)
);
GO

IF OBJECT_ID('dbo.TimSiagaAnggota', 'U') IS NOT NULL DROP TABLE dbo.TimSiagaAnggota;
GO
CREATE TABLE dbo.TimSiagaAnggota (
    TimAnggotaId      BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    GUIDTim           NVARCHAR(50) NOT NULL,
    PegawaiId         BIGINT NOT NULL,
    Fungsional        NVARCHAR(50) NULL,
    IsActive          BIT NOT NULL CONSTRAINT DF_TimSiagaAnggota_IsActive DEFAULT(1),
    NoUrut            INT NULL,
    UpdatedBy         NVARCHAR(50) NULL,
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_TimSiagaAnggota_UpdatedAt DEFAULT(SYSDATETIME()),
    CONSTRAINT UQ_TimSiagaAnggota UNIQUE (GUIDTim, PegawaiId),
    CONSTRAINT FK_TimSiagaAnggota_Tim FOREIGN KEY (GUIDTim) REFERENCES dbo.TimSiagaCore(GUIDTim),
    CONSTRAINT FK_TimSiagaAnggota_Pegawai FOREIGN KEY (PegawaiId) REFERENCES dbo.PegawaiCore(PegawaiId)
);
GO

/* =========================
   6) ACCESS CONTROL
   ========================= */

IF OBJECT_ID('dbo.AclForm', 'U') IS NOT NULL DROP TABLE dbo.AclForm;
GO
CREATE TABLE dbo.AclForm (
    AclFormId         BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    PegawaiId         BIGINT NOT NULL,
    FormId            NVARCHAR(50) NOT NULL,
    TypeAkses         NVARCHAR(10) NULL,
    IsAkses           BIT NOT NULL CONSTRAINT DF_AclForm_IsAkses DEFAULT(0),
    IdUnitKerja       NVARCHAR(50) NULL,
    Modul             NVARCHAR(50) NULL,
    UpdatedBy         NVARCHAR(50) NULL,
    UpdatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_AclForm_UpdatedAt DEFAULT(SYSDATETIME()),
    CONSTRAINT UQ_AclForm UNIQUE (PegawaiId, FormId),
    CONSTRAINT FK_AclForm_PegawaiCore FOREIGN KEY (PegawaiId) REFERENCES dbo.PegawaiCore(PegawaiId)
);
GO

/* Helpful indexes */
CREATE INDEX IX_AbsensiCore_TglKerja ON dbo.AbsensiCore (TglKerja);
CREATE INDEX IX_FingerScanLog_ScanTime ON dbo.FingerScanLog (ScanTime);
CREATE INDEX IX_DinasLuarCore_TglAwalTglAkhir ON dbo.DinasLuarCore (TglAwal, TglAkhir);
CREATE INDEX IX_OtorisasiCore_GUIDOto ON dbo.OtorisasiCore (GUIDOto);
GO
