/* MariaDB-compatible fixed script generated from basarnas_db_3.sql */
SET FOREIGN_KEY_CHECKS = 0;

/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     14/04/2026 13:43:17                          */
/*==============================================================*/


DROP TABLE IF EXISTS ABSENSI;

DROP TABLE IF EXISTS ABSENSI_BACKUP;

DROP TABLE IF EXISTS ABSENSI_TEMP;

DROP TABLE IF EXISTS BUKU_HARIAN_HEAD;

DROP TABLE IF EXISTS DINAS_LUAR;

DROP TABLE IF EXISTS DRH;

DROP TABLE IF EXISTS HAK_AKSES_FORM;

DROP TABLE IF EXISTS HAK_AKSES_TYPE_SPRIN;

DROP TABLE IF EXISTS KALENDER;

DROP TABLE IF EXISTS LEMBUR;

DROP TABLE IF EXISTS LOG_ACTIVITIY;

DROP TABLE IF EXISTS LOG_ACTIVITIY_BACKUP;

DROP TABLE IF EXISTS LOG_TRANSAKSI;

DROP TABLE IF EXISTS LOG_TRANSAKSI_BACKUP;

DROP TABLE IF EXISTS MEDIA_INFORMASI;

DROP TABLE IF EXISTS MF_CLASS;

DROP TABLE IF EXISTS MF_CONFIG;

DROP TABLE IF EXISTS MF_EMAIL_SEND;

DROP TABLE IF EXISTS MF_ESELON;

DROP TABLE IF EXISTS MF_FIELD_CARI;

DROP TABLE IF EXISTS MF_FORM;

DROP TABLE IF EXISTS MF_FORM_NEW;

DROP TABLE IF EXISTS MF_GOL;

DROP TABLE IF EXISTS MF_GROUP_JABATAN;

DROP TABLE IF EXISTS MF_HOST_NAME_FP;

DROP TABLE IF EXISTS MF_JABATAN;

DROP TABLE IF EXISTS MF_JABATAN_KEGIATAN;

DROP TABLE IF EXISTS MF_JAM_KERJA;

DROP TABLE IF EXISTS MF_JOBLIST;

DROP TABLE IF EXISTS MF_KLASIFIKASI_SURAT;

DROP TABLE IF EXISTS MF_LOAD_FINGER;

DROP TABLE IF EXISTS MF_ORGZ_SIAGA;

DROP TABLE IF EXISTS MF_POT;

DROP TABLE IF EXISTS MF_POTONGAN;

DROP TABLE IF EXISTS MF_PRIORITY_TRANSAKSI;

DROP TABLE IF EXISTS MF_SATUAN;

DROP TABLE IF EXISTS MF_SHIFT;

DROP TABLE IF EXISTS MF_STATUS;

DROP TABLE IF EXISTS MF_SU;

DROP TABLE IF EXISTS MF_TIM_SIAGA;

DROP TABLE IF EXISTS MF_TIM_SIAGA_ANGGOTA;

DROP TABLE IF EXISTS MF_TR;

DROP TABLE IF EXISTS MF_TUNJANGAN;

DROP TABLE IF EXISTS MF_TYPE_SPRIN;

DROP TABLE IF EXISTS MF_UNIT_KERJA;

DROP TABLE IF EXISTS MF_UNSUR_KEGIATAN;

DROP TABLE IF EXISTS MF_SUB_GROUP_JABATAN;

DROP TABLE IF EXISTS MONITORING_APP;

DROP TABLE IF EXISTS OTORISASI;

DROP TABLE IF EXISTS OTORISASI_HISTORY;

DROP TABLE IF EXISTS PEGAWAI;

DROP TABLE IF EXISTS PEG_MUTASI_UNIT;

DROP TABLE IF EXISTS PERUBAHAN_JABATAN;

DROP TABLE IF EXISTS SARAN;

DROP TABLE IF EXISTS SKP_PEGAWAI;

DROP TABLE IF EXISTS SKP_PEGAWAI_HEAD;

DROP TABLE IF EXISTS SPRIN_HEADER;

DROP TABLE IF EXISTS TIME_RECORDER;

DROP TABLE IF EXISTS USER_ACCOUNT;

/*==============================================================*/
/* Table: ABSENSI                                               */
/*==============================================================*/
CREATE TABLE ABSENSI 
(
   ABSENSI_ID           INTEGER                        NOT NULL,
   POTONGAN_ID          INTEGER                        NOT NULL,
   TGL_KERJA            TIMESTAMP                      NOT NULL,
   ABSENSI_BACKUP_ID    INTEGER                        NOT NULL,
   ABSENSI_TEMP_ID      INTEGER                        NOT NULL,
   FINGER_ID            INTEGER                        NOT NULL,
   TGL_JAM_IN           TIMESTAMP                      NULL,
   TGL_JAM_OUT          TIMESTAMP                      NULL,
   KET_IN               VARCHAR(850)                   NULL,
   TRANSAKSI_IN         CHAR(50)                       NULL,
   UPDATE_IN_BY         VARCHAR(50)                    NULL,
   UPDATE_IN_DATE       TIMESTAMP                      NULL,
   KET_OUT              VARCHAR(850)                   NULL,
   TRANSAKSI_OUT        VARCHAR(50)                    NULL,
   UPDATE_OUT_BY        VARCHAR(50)                    NULL,
   UPDATE_OUT_DATE      TIMESTAMP                      NULL,
   TINGKAT_TLM          VARCHAR(50)                    NULL,
   TOTAL_TLM            FLOAT                          NULL,
   TOTAL_PSW            FLOAT                          NULL,
   TINGKAT_PSW          VARCHAR(50)                    NULL,
   IS_INVALID           VARCHAR(1)                     NULL,
   IS_OUTVALID          VARCHAR(1)                     NULL,
   AWAL_TLM             FLOAT                          NULL,
   PERSEN_POT_TLM       FLOAT                          NULL,
   PERSEN_POT_PSW       FLOAT                          NULL,
   TGL_JAM_BAKU_IN      TIMESTAMP                      NULL,
   TGL_JAM_BAKU_OUT     TIMESTAMP                      NULL,
   TRAKSAKSI_ID_FROM    VARCHAR(250)                   NULL,
   PENDUKUNG_IN         VARCHAR(50)                    NULL,
   PENDUKUNG_OUT        VARCHAR(50)                    NULL,
   HISTORY_TRANSAKSI_IN VARCHAR(450)                   NULL,
   HISTORY_TRANSAKSI_OUT VARCHAR(450)                   NULL,
   STATUS_UM            INTEGER                        NULL,
   CONSTRAINT PK_ABSENSI PRIMARY KEY (ABSENSI_ID)
);

/*==============================================================*/
/* Index: ABSENSI_PK                                            */
/*==============================================================*/
CREATE UNIQUE INDEX ABSENSI_PK ON ABSENSI (
ABSENSI_ID ASC
);

/*==============================================================*/
/* Index: MENJADI_SUMBER_DATA_FK                                */
/*==============================================================*/
CREATE INDEX MENJADI_SUMBER_DATA_FK ON ABSENSI (
FINGER_ID ASC
);

/*==============================================================*/
/* Index: TERJADI_PADA_TANGGAL_FK                               */
/*==============================================================*/
CREATE INDEX TERJADI_PADA_TANGGAL_FK ON ABSENSI (
TGL_KERJA ASC
);

/*==============================================================*/
/* Index: DITERAPKAN_PADA_FK                                    */
/*==============================================================*/
CREATE INDEX DITERAPKAN_PADA_FK ON ABSENSI (
POTONGAN_ID ASC
);

/*==============================================================*/
/* Index: DATA_BACKUP_ABSENSI_FK                                */
/*==============================================================*/
CREATE INDEX DATA_BACKUP_ABSENSI_FK ON ABSENSI (
ABSENSI_BACKUP_ID ASC
);

/*==============================================================*/
/* Index: DATA_TEMP_ABSENSI_FK                                  */
/*==============================================================*/
CREATE INDEX DATA_TEMP_ABSENSI_FK ON ABSENSI (
ABSENSI_TEMP_ID ASC
);

/*==============================================================*/
/* Table: ABSENSI_BACKUP                                        */
/*==============================================================*/
CREATE TABLE ABSENSI_BACKUP 
(
   ABSENSI_BACKUP_ID    INTEGER                        NOT NULL,
   ABSENSI_ID           INTEGER                        NULL,
   TGL_JAM_IN           TIMESTAMP                      NULL,
   TGL_JAM_OUT          TIMESTAMP                      NULL,
   KET_IN               VARCHAR(850)                   NULL,
   TRANSAKSI_IN         CHAR(50)                       NULL,
   UPDATE_IN_BY         VARCHAR(50)                    NULL,
   UPDATE_IN_DATE       TIMESTAMP                      NULL,
   KET_OUT              VARCHAR(850)                   NULL,
   TRANSAKSI_OUT        VARCHAR(50)                    NULL,
   UPDATE_OUT_BY        VARCHAR(50)                    NULL,
   UPDATE_OUT_DATE      TIMESTAMP                      NULL,
   TINGKAT_TLM          VARCHAR(50)                    NULL,
   TOTAL_TLM            FLOAT                          NULL,
   TOTAL_PSW            FLOAT                          NULL,
   TINGKAT_PSW          VARCHAR(50)                    NULL,
   IS_INVALID           VARCHAR(1)                     NULL,
   IS_OUTVALID          VARCHAR(1)                     NULL,
   AWAL_TLM             FLOAT                          NULL,
   PERSEN_POT_TLM       FLOAT                          NULL,
   PERSEN_POT_PSW       FLOAT                          NULL,
   TGL_JAM_BAKU_IN      TIMESTAMP                      NULL,
   TGL_JAM_BAKU_OUT     TIMESTAMP                      NULL,
   TRAKSAKSI_ID_FROM    VARCHAR(250)                   NULL,
   PENDUKUNG_IN         VARCHAR(50)                    NULL,
   PENDUKUNG_OUT        VARCHAR(50)                    NULL,
   HISTORY_TRANSAKSI_IN VARCHAR(450)                   NULL,
   HISTORY_TRANSAKSI_OUT VARCHAR(450)                   NULL,
   STATUS_UM            INTEGER                        NULL,
   CONSTRAINT PK_ABSENSI_BACKUP PRIMARY KEY (ABSENSI_BACKUP_ID)
);

/*==============================================================*/
/* Index: ABSENSI_BACKUP_PK                                     */
/*==============================================================*/
CREATE UNIQUE INDEX ABSENSI_BACKUP_PK ON ABSENSI_BACKUP (
ABSENSI_BACKUP_ID ASC
);

/*==============================================================*/
/* Index: DATA_BACKUP_ABSENSI2_FK                               */
/*==============================================================*/
CREATE INDEX DATA_BACKUP_ABSENSI2_FK ON ABSENSI_BACKUP (
ABSENSI_ID ASC
);

/*==============================================================*/
/* Table: ABSENSI_TEMP                                          */
/*==============================================================*/
CREATE TABLE ABSENSI_TEMP 
(
   ABSENSI_TEMP_ID      INTEGER                        NOT NULL,
   ABSENSI_ID           INTEGER                        NULL,
   TGL_JAM_IN           TIMESTAMP                      NULL,
   TGL_JAM_OUT          TIMESTAMP                      NULL,
   KET_IN               VARCHAR(850)                   NULL,
   TRANSAKSI_IN         CHAR(50)                       NULL,
   UPDATE_IN_BY         VARCHAR(50)                    NULL,
   UPDATE_IN_DATE       TIMESTAMP                      NULL,
   KET_OUT              VARCHAR(850)                   NULL,
   TRANSAKSI_OUT        VARCHAR(50)                    NULL,
   UPDATE_OUT_BY        VARCHAR(50)                    NULL,
   UPDATE_OUT_DATE      TIMESTAMP                      NULL,
   TINGKAT_TLM          VARCHAR(50)                    NULL,
   TOTAL_TLM            FLOAT                          NULL,
   TOTAL_PSW            FLOAT                          NULL,
   TINGKAT_PSW          VARCHAR(50)                    NULL,
   IS_INVALID           VARCHAR(1)                     NULL,
   IS_OUTVALID          VARCHAR(1)                     NULL,
   AWAL_TLM             FLOAT                          NULL,
   PERSEN_POT_TLM       FLOAT                          NULL,
   PERSEN_POT_PSW       FLOAT                          NULL,
   TGL_JAM_BAKU_IN      TIMESTAMP                      NULL,
   TGL_JAM_BAKU_OUT     TIMESTAMP                      NULL,
   TRAKSAKSI_ID_FROM    VARCHAR(250)                   NULL,
   PENDUKUNG_IN         VARCHAR(50)                    NULL,
   PENDUKUNG_OUT        VARCHAR(50)                    NULL,
   HISTORY_TRANSAKSI_IN VARCHAR(450)                   NULL,
   HISTORY_TRANSAKSI_OUT VARCHAR(450)                   NULL,
   STATUS_UM            INTEGER                        NULL,
   CONSTRAINT PK_ABSENSI_TEMP PRIMARY KEY (ABSENSI_TEMP_ID)
);

/*==============================================================*/
/* Index: ABSENSI_TEMP_PK                                       */
/*==============================================================*/
CREATE UNIQUE INDEX ABSENSI_TEMP_PK ON ABSENSI_TEMP (
ABSENSI_TEMP_ID ASC
);

/*==============================================================*/
/* Index: DATA_TEMP_ABSENSI2_FK                                 */
/*==============================================================*/
CREATE INDEX DATA_TEMP_ABSENSI2_FK ON ABSENSI_TEMP (
ABSENSI_ID ASC
);

/*==============================================================*/
/* Table: BUKU_HARIAN_HEAD                                      */
/*==============================================================*/
CREATE TABLE BUKU_HARIAN_HEAD 
(
   GUID                 VARCHAR(100)                   NOT NULL,
   JABATAN_ID           INTEGER                        NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   ITEM_ID              VARCHAR(50)                    NOT NULL,
   GUID_SKP_PEG         VARCHAR(100)                   NOT NULL,
   DESKRIPSI            VARCHAR(350)                   NULL,
   AK                   FLOAT                          NULL,
   QTY                  FLOAT                          NULL,
   GOL                  VARCHAR(10)                    NULL,
   GOL_PARENT           VARCHAR(10)                    NULL,
   BIAYA                FLOAT                          NULL,
   UNSUR                VARCHAR(50)                    NULL,
   TGL_MULAI            DATE                           NULL,
   SATUAN_QTY           VARCHAR(50)                    NULL,
   KETERANGAN           VARCHAR(350)                   NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   CREATE_DATE          TIMESTAMP                      NULL,
   NIP_PARENT           VARCHAR(50)                    NULL,
   JABATAN_ID_PARENT    INTEGER                        NULL,
   STATUS               INTEGER                        NULL,
   KETERANGAN_PENGAJUAN VARCHAR(150)                   NULL,
   CONSTRAINT PK_BUKU_HARIAN_HEAD PRIMARY KEY (GUID)
);

/*==============================================================*/
/* Index: BUKU_HARIAN_HEAD_PK                                   */
/*==============================================================*/
CREATE UNIQUE INDEX BUKU_HARIAN_HEAD_PK ON BUKU_HARIAN_HEAD (
GUID ASC
);

/*==============================================================*/
/* Index: DIBUAT_OLEH_FK                                        */
/*==============================================================*/
CREATE INDEX DIBUAT_OLEH_FK ON BUKU_HARIAN_HEAD (
NIP ASC
);

/*==============================================================*/
/* Index: TERKAIT_JABATAN_FK                                    */
/*==============================================================*/
CREATE INDEX TERKAIT_JABATAN_FK ON BUKU_HARIAN_HEAD (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: TERKAIT_JABATAN_KEGIATAN_FK                           */
/*==============================================================*/
CREATE INDEX TERKAIT_JABATAN_KEGIATAN_FK ON BUKU_HARIAN_HEAD (
ITEM_ID ASC
);

/*==============================================================*/
/* Index: TERKAIT_DENGAN_FK                                     */
/*==============================================================*/
CREATE INDEX TERKAIT_DENGAN_FK ON BUKU_HARIAN_HEAD (
GUID_SKP_PEG ASC
);

/*==============================================================*/
/* Table: DINAS_LUAR                                            */
/*==============================================================*/
CREATE TABLE DINAS_LUAR 
(
   DINAS_TRANSAKSI_ID   VARCHAR(50)                    NOT NULL,
   GUID_SPRIN           VARCHAR(50)                    NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   TGL_AWAL_DINAS_LUAR  TIMESTAMP                      NULL,
   TGL_AKHIR_DINAS_LUAR TIMESTAMP                      NULL,
   KETERANGAN_DINAS_LUAR VARCHAR(450)                   NULL,
   PENEMPATAN_DINAS_LUAR VARCHAR(350)                   NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   TRANSAKSI            VARCHAR(50)                    NULL,
   PENDUKUNG            VARCHAR(50)                    NULL,
   NO_SURAT             VARCHAR(250)                   NULL,
   STATUS_UM            INTEGER                        NULL,
   JENIS                VARCHAR(10)                    NULL,
   TGL_AWAL_SURAT       DATE                           NULL,
   TGL_AKHIR_SURAT      DATE                           NULL,
   NAMA_FILE            VARCHAR(100)                   NULL,
   TGL_EMAIL            TIMESTAMP                      NULL,
   TIPE                 INTEGER                        NULL,
   CONSTRAINT PK_DINAS_LUAR PRIMARY KEY (DINAS_TRANSAKSI_ID)
);

/*==============================================================*/
/* Index: DINAS_LUAR_PK                                         */
/*==============================================================*/
CREATE UNIQUE INDEX DINAS_LUAR_PK ON DINAS_LUAR (
DINAS_TRANSAKSI_ID ASC
);

/*==============================================================*/
/* Index: BERDASARKAN_SPRIN_FK                                  */
/*==============================================================*/
CREATE INDEX BERDASARKAN_SPRIN_FK ON DINAS_LUAR (
GUID_SPRIN ASC
);

/*==============================================================*/
/* Index: MELAKUKAN_FK                                          */
/*==============================================================*/
CREATE INDEX MELAKUKAN_FK ON DINAS_LUAR (
NIP ASC
);

/*==============================================================*/
/* Table: DRH                                                   */
/*==============================================================*/
CREATE TABLE DRH 
(
   NIP                  VARCHAR(50)                    NOT NULL,
   JABATAN_ID           INTEGER                        NOT NULL,
   TRAKSAKSI_ID         INTEGER                        NOT NULL,
   GUID_TRANSAKSI       VARCHAR(50)                    NULL,
   TGL_MULAI            DATE                           NULL,
   NO_SK                VARCHAR(150)                   NULL
);

/*==============================================================*/
/* Index: JABATAN_DRH_FK                                        */
/*==============================================================*/
CREATE INDEX JABATAN_DRH_FK ON DRH (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: MEREKAM_DRH_FK                                        */
/*==============================================================*/
CREATE INDEX MEREKAM_DRH_FK ON DRH (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Index: PEGAWAI_DRH_FK                                        */
/*==============================================================*/
CREATE INDEX PEGAWAI_DRH_FK ON DRH (
NIP ASC
);

/*==============================================================*/
/* Table: HAK_AKSES_FORM                                        */
/*==============================================================*/
CREATE TABLE HAK_AKSES_FORM 
(
   FORM_ID              VARCHAR(50)                    NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   IS_AKSES             VARCHAR(5)                     NULL,
   TYPE_AKSES           VARCHAR(5)                     NULL,
   MODUL                VARCHAR(50)                    NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL
);

/*==============================================================*/
/* Index: DIBERIKAN_KEPADA_FK                                   */
/*==============================================================*/
CREATE INDEX DIBERIKAN_KEPADA_FK ON HAK_AKSES_FORM (
NIP ASC
);

/*==============================================================*/
/* Index: UNTUK_FORM_FK                                         */
/*==============================================================*/
CREATE INDEX UNTUK_FORM_FK ON HAK_AKSES_FORM (
FORM_ID ASC
);

/*==============================================================*/
/* Table: HAK_AKSES_TYPE_SPRIN                                  */
/*==============================================================*/
CREATE TABLE HAK_AKSES_TYPE_SPRIN 
(
   TYPE_SPRIN_ID        CHAR(20)                       NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   TYPE_AKSES           CHAR(10)                       NULL,
   UPDATE_BY            CHAR(10)                       NULL,
   UPDATE_DATE          CHAR(10)                       NULL
);

/*==============================================================*/
/* Index: USER_SPRIN_FK                                         */
/*==============================================================*/
CREATE INDEX USER_SPRIN_FK ON HAK_AKSES_TYPE_SPRIN (
NIP ASC
);

/*==============================================================*/
/* Index: AKSES_SPRIN_FK                                        */
/*==============================================================*/
CREATE INDEX AKSES_SPRIN_FK ON HAK_AKSES_TYPE_SPRIN (
TYPE_SPRIN_ID ASC
);

/*==============================================================*/
/* Table: KALENDER                                              */
/*==============================================================*/
CREATE TABLE KALENDER 
(
   TGL_KERJA            TIMESTAMP                      NOT NULL,
   IS_LIBUR             VARCHAR(1)                     NULL,
   KET                  VARCHAR(50)                    NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   CONSTRAINT PK_KALENDER PRIMARY KEY (TGL_KERJA)
);

/*==============================================================*/
/* Index: KALENDER_PK                                           */
/*==============================================================*/
CREATE UNIQUE INDEX KALENDER_PK ON KALENDER (
TGL_KERJA ASC
);

/*==============================================================*/
/* Table: LEMBUR                                                */
/*==============================================================*/
CREATE TABLE LEMBUR 
(
   NIP                  VARCHAR(50)                    NULL,
   TGL_KERJA            TIMESTAMP                      NULL,
   JAM_IN               TIMESTAMP                      NULL,
   JAM_OUT              TIMESTAMP                      NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   KETERANGAN           VARCHAR(50)                    NULL,
   NO_SURAT             VARCHAR(250)                   NULL,
   JAM_BAKU_IN          TIMESTAMP                      NULL,
   JAM_BAKU_OUT         TIMESTAMP                      NULL
);

/*==============================================================*/
/* Index: TERJADI_TANGGAL_LEMBUR_FK                             */
/*==============================================================*/
CREATE INDEX TERJADI_TANGGAL_LEMBUR_FK ON LEMBUR (
TGL_KERJA ASC
);

/*==============================================================*/
/* Index: DILAKUKAN_LEMBUR_FK                                   */
/*==============================================================*/
CREATE INDEX DILAKUKAN_LEMBUR_FK ON LEMBUR (
NIP ASC
);

/*==============================================================*/
/* Table: LOG_ACTIVITIY                                         */
/*==============================================================*/
CREATE TABLE LOG_ACTIVITIY 
(
   GUID_LOG             VARCHAR(50)                    NOT NULL,
   TRAKSAKSI_ID         INTEGER                        NOT NULL,
   UNIT_KERJA_ID        INTEGER                        NOT NULL,
   GUID_LOG_BACKUP      VARCHAR(50)                    NOT NULL,
   GUID_TIM             VARCHAR(50)                    NOT NULL,
   STATUS_ID            INTEGER                        NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   TRX                  VARCHAR(50)                    NULL,
   ACTIVITY             VARCHAR(50)                    NULL,
   ACTIVITY_DATE        DATE                           NULL,
   NOTE                 VARCHAR(150)                   NULL,
   TEMPAT               VARCHAR(150)                   NULL,
   PERIHAL              VARCHAR(150)                   NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   FUNGSIONAL           VARCHAR(50)                    NULL,
   TGL_CLOSING          DATE                           NULL,
   SHIFT_1              INTEGER                        NULL,
   SHIFT_2              INTEGER                        NULL,
   PENGGANTI            INTEGER                        NULL,
   STATUS_TRX           VARCHAR(50)                    NULL,
   KET_UPDATE           VARCHAR(250)                   NULL,
   NIP_PENGGANTI        VARCHAR(50)                    NULL,
   BIAYA                FLOAT                          NULL,
   QTY                  FLOAT                          NULL,
   SATUAN_QTY           VARCHAR(50)                    NULL,
   SHIFT                VARCHAR(5)                     NULL,
   TRANSAKSI_FORM       VARCHAR(50)                    NULL,
   TGL_JAM_IN           TIMESTAMP                      NULL,
   TGL_JAM_OUT          TIMESTAMP                      NULL,
   TGL_JAM_BAKU_IN      TIMESTAMP                      NULL,
   TGL_JAM_BAKU_OUT     TIMESTAMP                      NULL,
   CONSTRAINT PK_LOG_ACTIVITIY PRIMARY KEY (GUID_LOG)
);

/*==============================================================*/
/* Index: LOG_ACTIVITIY_PK                                      */
/*==============================================================*/
CREATE UNIQUE INDEX LOG_ACTIVITIY_PK ON LOG_ACTIVITIY (
GUID_LOG ASC
);

/*==============================================================*/
/* Index: DILAKUKAN_OLEH_USER_FK                                */
/*==============================================================*/
CREATE INDEX DILAKUKAN_OLEH_USER_FK ON LOG_ACTIVITIY (
NIP ASC
);

/*==============================================================*/
/* Index: MEMILIKI_STATUS_FK                                    */
/*==============================================================*/
CREATE INDEX MEMILIKI_STATUS_FK ON LOG_ACTIVITIY (
STATUS_ID ASC
);

/*==============================================================*/
/* Index: DILAKUKAN_TIM_FK                                      */
/*==============================================================*/
CREATE INDEX DILAKUKAN_TIM_FK ON LOG_ACTIVITIY (
GUID_TIM ASC
);

/*==============================================================*/
/* Index: UNIT_MELAKUKAN_FK                                     */
/*==============================================================*/
CREATE INDEX UNIT_MELAKUKAN_FK ON LOG_ACTIVITIY (
UNIT_KERJA_ID ASC
);

/*==============================================================*/
/* Index: TRANSAKSI_TEREKAM_FK                                  */
/*==============================================================*/
CREATE INDEX TRANSAKSI_TEREKAM_FK ON LOG_ACTIVITIY (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Index: MEMBACKUP_LOG_ACTIVITIY_FK                            */
/*==============================================================*/
CREATE INDEX MEMBACKUP_LOG_ACTIVITIY_FK ON LOG_ACTIVITIY (
GUID_LOG_BACKUP ASC
);

/*==============================================================*/
/* Table: LOG_ACTIVITIY_BACKUP                                  */
/*==============================================================*/
CREATE TABLE LOG_ACTIVITIY_BACKUP 
(
   GUID_LOG_BACKUP      VARCHAR(50)                    NOT NULL,
   GUID_LOG             VARCHAR(50)                    NULL,
   TRX                  VARCHAR(50)                    NULL,
   ACTIVITY             VARCHAR(50)                    NULL,
   ACTIVITY_DATE        DATE                           NULL,
   NOTE                 VARCHAR(150)                   NULL,
   TEMPAT               VARCHAR(150)                   NULL,
   PERIHAL              VARCHAR(150)                   NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   FUNGSIONAL           VARCHAR(50)                    NULL,
   TGL_CLOSING          DATE                           NULL,
   SHIFT_1              INTEGER                        NULL,
   SHIFT_2              INTEGER                        NULL,
   PENGGANTI            INTEGER                        NULL,
   STATUS_TRX           VARCHAR(50)                    NULL,
   KET_UPDATE           VARCHAR(250)                   NULL,
   NIP_PENGGANTI        VARCHAR(50)                    NULL,
   BIAYA                FLOAT                          NULL,
   QTY                  FLOAT                          NULL,
   SATUAN_QTY           VARCHAR(50)                    NULL,
   SHIFT                VARCHAR(5)                     NULL,
   TRANSAKSI_FORM       VARCHAR(50)                    NULL,
   TGL_JAM_IN           TIMESTAMP                      NULL,
   TGL_JAM_OUT          TIMESTAMP                      NULL,
   TGL_JAM_BAKU_IN      TIMESTAMP                      NULL,
   TGL_JAM_BAKU_OUT     TIMESTAMP                      NULL,
   CONSTRAINT PK_LOG_ACTIVITIY_BACKUP PRIMARY KEY (GUID_LOG_BACKUP)
);

/*==============================================================*/
/* Index: LOG_ACTIVITIY_BACKUP_PK                               */
/*==============================================================*/
CREATE UNIQUE INDEX LOG_ACTIVITIY_BACKUP_PK ON LOG_ACTIVITIY_BACKUP (
GUID_LOG_BACKUP ASC
);

/*==============================================================*/
/* Index: MEMBACKUP_LOG_ACTIVITIY2_FK                           */
/*==============================================================*/
CREATE INDEX MEMBACKUP_LOG_ACTIVITIY2_FK ON LOG_ACTIVITIY_BACKUP (
GUID_LOG ASC
);

/*==============================================================*/
/* Table: LOG_TRANSAKSI                                         */
/*==============================================================*/
CREATE TABLE LOG_TRANSAKSI 
(
   TRAKSAKSI_ID         INTEGER                        NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   TRAKSAKSI_BACKUP_ID  INTEGER                        NOT NULL,
   GUID_SKP_PEG         VARCHAR(100)                   NULL,
   TRANSAKSI            VARCHAR(50)                    NULL,
   ACTIVITY             VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   CONSTRAINT PK_LOG_TRANSAKSI PRIMARY KEY (TRAKSAKSI_ID)
);

/*==============================================================*/
/* Index: LOG_TRANSAKSI_PK                                      */
/*==============================================================*/
CREATE UNIQUE INDEX LOG_TRANSAKSI_PK ON LOG_TRANSAKSI (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Index: TRANSAKSI_DILAKUKAN_OLEH_FK                           */
/*==============================================================*/
CREATE INDEX TRANSAKSI_DILAKUKAN_OLEH_FK ON LOG_TRANSAKSI (
NIP ASC
);

/*==============================================================*/
/* Index: DATA_BACKUP_TRANSAKSI_FK                              */
/*==============================================================*/
CREATE INDEX DATA_BACKUP_TRANSAKSI_FK ON LOG_TRANSAKSI (
TRAKSAKSI_BACKUP_ID ASC
);

/*==============================================================*/
/* Table: LOG_TRANSAKSI_BACKUP                                  */
/*==============================================================*/
CREATE TABLE LOG_TRANSAKSI_BACKUP 
(
   TRAKSAKSI_BACKUP_ID  INTEGER                        NOT NULL,
   TRAKSAKSI_ID         INTEGER                        NULL,
   GUID_SKP_PEG         VARCHAR(100)                   NULL,
   TRANSAKSI            VARCHAR(50)                    NULL,
   ACTIVITY             VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   CONSTRAINT PK_LOG_TRANSAKSI_BACKUP PRIMARY KEY (TRAKSAKSI_BACKUP_ID)
);

/*==============================================================*/
/* Index: LOG_TRANSAKSI_BACKUP_PK                               */
/*==============================================================*/
CREATE UNIQUE INDEX LOG_TRANSAKSI_BACKUP_PK ON LOG_TRANSAKSI_BACKUP (
TRAKSAKSI_BACKUP_ID ASC
);

/*==============================================================*/
/* Index: DATA_BACKUP_TRANSAKSI2_FK                             */
/*==============================================================*/
CREATE INDEX DATA_BACKUP_TRANSAKSI2_FK ON LOG_TRANSAKSI_BACKUP (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MEDIA_INFORMASI                                       */
/*==============================================================*/
CREATE TABLE MEDIA_INFORMASI 
(
   MED_INFOR_ID         INTEGER                        NOT NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   TRX                  VARCHAR(50)                    NULL,
   NAMA_FILE            VARCHAR(100)                   NULL,
   DESKRIPSI            VARCHAR(250)                   NULL,
   PUBLISH_DATE_START   DATE                           NULL,
   PUBLISH_DATE_END     DATE                           NULL,
   IS_AKTIF             VARCHAR(5)                     NULL,
   PIC                  VARCHAR(150)                   NULL,
   ALAMAT               VARCHAR(250)                   NULL,
   CONSTRAINT PK_MEDIA_INFORMASI PRIMARY KEY (MED_INFOR_ID)
);

/*==============================================================*/
/* Index: MEDIA_INFORMASI_PK                                    */
/*==============================================================*/
CREATE UNIQUE INDEX MEDIA_INFORMASI_PK ON MEDIA_INFORMASI (
MED_INFOR_ID ASC
);

/*==============================================================*/
/* Table: MF_CLASS                                              */
/*==============================================================*/
CREATE TABLE MF_CLASS 
(
   CLASS_ID             INTEGER                        NOT NULL,
   TUNJANGAN            FLOAT                          NULL,
   ID                   INTEGER                        NULL,
   TGL_MULAI            TIMESTAMP                      NULL,
   UPDATE_IN_BY         VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   DOKREFF              VARCHAR(250)                   NULL,
   CONSTRAINT PK_MF_CLASS PRIMARY KEY (CLASS_ID)
);

/*==============================================================*/
/* Index: MF_CLASS_PK                                           */
/*==============================================================*/
CREATE UNIQUE INDEX MF_CLASS_PK ON MF_CLASS (
CLASS_ID ASC
);

/*==============================================================*/
/* Table: MF_CONFIG                                             */
/*==============================================================*/
CREATE TABLE MF_CONFIG 
(
   TRAKSAKSI_ID         INTEGER                        NOT NULL,
   CONFIG_NAME          VARCHAR(50)                    NULL,
   TGL_JAM1             TIMESTAMP                      NULL,
   TGL_JAM2             TIMESTAMP                      NULL
);

/*==============================================================*/
/* Index: MENCATAT_CONFIG_FK                                    */
/*==============================================================*/
CREATE INDEX MENCATAT_CONFIG_FK ON MF_CONFIG (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MF_EMAIL_SEND                                         */
/*==============================================================*/
CREATE TABLE MF_EMAIL_SEND 
(
   EMAIL_SEND           VARCHAR(50)                    NULL,
   PASS_SEND            VARCHAR(50)                    NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   SMTP_SEND            VARCHAR(50)                    NULL,
   PORT_SENT            VARCHAR(10)                    NULL
);

/*==============================================================*/
/* Table: MF_ESELON                                             */
/*==============================================================*/
CREATE TABLE MF_ESELON 
(
   ESELON               VARCHAR(50)                    NOT NULL,
   URUT_ESELON          INTEGER                        NULL,
   CONSTRAINT PK_MF_ESELON PRIMARY KEY (ESELON)
);

/*==============================================================*/
/* Index: MF_ESELON_PK                                          */
/*==============================================================*/
CREATE UNIQUE INDEX MF_ESELON_PK ON MF_ESELON (
ESELON ASC
);

/*==============================================================*/
/* Table: MF_FIELD_CARI                                         */
/*==============================================================*/
CREATE TABLE MF_FIELD_CARI 
(
   FIELD_ID             VARCHAR(50)                    NOT NULL,
   TRAKSAKSI_ID         INTEGER                        NOT NULL,
   FIELD_NAME           VARCHAR(50)                    NULL,
   TYPE_CARI            VARCHAR(50)                    NULL,
   IS_CMB               VARCHAR(5)                     NULL,
   NO_URUT              INTEGER                        NULL,
   APLIKASI             VARCHAR(50)                    NULL,
   CONSTRAINT PK_MF_FIELD_CARI PRIMARY KEY (FIELD_ID)
);

/*==============================================================*/
/* Index: MF_FIELD_CARI_PK                                      */
/*==============================================================*/
CREATE UNIQUE INDEX MF_FIELD_CARI_PK ON MF_FIELD_CARI (
FIELD_ID ASC
);

/*==============================================================*/
/* Index: MENCATAT_PENCARIAN_FK                                 */
/*==============================================================*/
CREATE INDEX MENCATAT_PENCARIAN_FK ON MF_FIELD_CARI (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MF_FORM                                               */
/*==============================================================*/
CREATE TABLE MF_FORM 
(
   FORM_ID              VARCHAR(50)                    NOT NULL,
   FORM_NAME            VARCHAR(70)                    NULL,
   FORM_TYPE            VARCHAR(20)                    NULL,
   NO_URUT              INTEGER                        NULL,
   BERKAS               VARCHAR(50)                    NULL,
   PANEL_PAGE           VARCHAR(50)                    NULL,
   IMG_URL              VARCHAR(50)                    NULL,
   NO_URUT_PANEL        INTEGER                        NULL,
   MODUL                VARCHAR(50)                    NULL,
   PARENT_FORM          VARCHAR(50)                    NULL,
   MODEL                INTEGER                        NULL,
   ICON_FA              VARCHAR(50)                    NULL,
   HIRARKI_LV           INTEGER                        NULL,
   TRANSAKSI_ID         INTEGER                        NULL,
   CONSTRAINT PK_MF_FORM PRIMARY KEY (FORM_ID)
);

/*==============================================================*/
/* Index: MF_FORM_PK                                            */
/*==============================================================*/
CREATE UNIQUE INDEX MF_FORM_PK ON MF_FORM (
FORM_ID ASC
);

/*==============================================================*/
/* Table: MF_FORM_NEW                                           */
/*==============================================================*/
CREATE TABLE MF_FORM_NEW 
(
   NEW_FORM_ID          VARCHAR(50)                    NOT NULL,
   NEW_FORM_NAME        VARCHAR(70)                    NULL,
   NEW_FORM_TYPE        VARCHAR(20)                    NULL,
   NO_URUT              INTEGER                        NULL,
   BERKAS               VARCHAR(50)                    NULL,
   PANEL_PAGE           VARCHAR(50)                    NULL,
   IMG_URL              VARCHAR(50)                    NULL,
   NO_URUT_PANEL        INTEGER                        NULL,
   MODUL                VARCHAR(50)                    NULL,
   PARENT_FORM          VARCHAR(50)                    NULL,
   MODEL                INTEGER                        NULL,
   ICONFA               VARCHAR(50)                    NULL,
   HIRARKI_LV           INTEGER                        NULL,
   CONSTRAINT PK_MF_FORM_NEW PRIMARY KEY (NEW_FORM_ID)
);

/*==============================================================*/
/* Index: MF_FORM_NEW_PK                                        */
/*==============================================================*/
CREATE UNIQUE INDEX MF_FORM_NEW_PK ON MF_FORM_NEW (
NEW_FORM_ID ASC
);

/*==============================================================*/
/* Table: MF_GOL                                                */
/*==============================================================*/
CREATE TABLE MF_GOL 
(
   GOL_ID               INTEGER                        NOT NULL,
   NAMA_GOL             VARCHAR(50)                    NULL,
   PANGKAT_GOL          VARCHAR(50)                    NULL,
   URUT_GOL             INTEGER                        NULL,
   TRANSAC_ID           INTEGER                        NULL,
   GROUP_GOL            VARCHAR(2)                     NULL,
   CONSTRAINT PK_MF_GOL PRIMARY KEY (GOL_ID)
);

/*==============================================================*/
/* Index: MF_GOL_PK                                             */
/*==============================================================*/
CREATE UNIQUE INDEX MF_GOL_PK ON MF_GOL (
GOL_ID ASC
);

/*==============================================================*/
/* Table: MF_GROUP_JABATAN                                      */
/*==============================================================*/
CREATE TABLE MF_GROUP_JABATAN 
(
   GROUP_JABATAN_ID     INTEGER                        NOT NULL,
   NAMA_GROUP_JABATAN   VARCHAR(50)                    NOT NULL,
   CONSTRAINT PK_MF_GROUP_JABATAN PRIMARY KEY (GROUP_JABATAN_ID)
);

/*==============================================================*/
/* Index: MF_GROUP_JABATAN_PK                                   */
/*==============================================================*/
CREATE UNIQUE INDEX MF_GROUP_JABATAN_PK ON MF_GROUP_JABATAN (
GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Table: MF_HOST_NAME_FP                                       */
/*==============================================================*/
CREATE TABLE MF_HOST_NAME_FP 
(
   UNIT_KERJA_ID        INTEGER                        NOT NULL,
   HOST_NAME_FP         VARCHAR(50)                    NULL
);

/*==============================================================*/
/* Index: HOST_DARI_UNIT_FK                                     */
/*==============================================================*/
CREATE INDEX HOST_DARI_UNIT_FK ON MF_HOST_NAME_FP (
UNIT_KERJA_ID ASC
);

/*==============================================================*/
/* Table: MF_JABATAN                                            */
/*==============================================================*/
CREATE TABLE MF_JABATAN 
(
   JABATAN_ID           INTEGER                        NOT NULL,
   JABATAN_ID_BARU      INTEGER                        NOT NULL,
   GROUP_JABATAN_ID     INTEGER                        NOT NULL,
   SUB_GROUP_JABATAN_ID INTEGER                        NOT NULL,
   JABATAN_MANAGE       INTEGER                        NULL,
   JABATAN_ID_OLD       INTEGER                        NULL,
   NAMA_JABATAN         VARCHAR(100)                   NOT NULL,
   URUT_JABATAN         INTEGER                        NOT NULL,
   TYPE_JABATAN         VARCHAR(10)                    NOT NULL,
   IS_USE               SMALLINT                       NOT NULL,
   UPDATE_IN_BY         VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   CONSTRAINT PK_MF_JABATAN PRIMARY KEY (JABATAN_ID)
);

/*==============================================================*/
/* Index: MF_JABATAN_PK                                         */
/*==============================================================*/
CREATE UNIQUE INDEX MF_JABATAN_PK ON MF_JABATAN (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: TERMASUK_DALAM_GROUP_FK                               */
/*==============================================================*/
CREATE INDEX TERMASUK_DALAM_GROUP_FK ON MF_JABATAN (
GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Index: TERMASUK_DALAM_SUBGROUP_FK                            */
/*==============================================================*/
CREATE INDEX TERMASUK_DALAM_SUBGROUP_FK ON MF_JABATAN (
SUB_GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Index: MERUBAH_JABATAN_FK                                    */
/*==============================================================*/
CREATE INDEX MERUBAH_JABATAN_FK ON MF_JABATAN (
JABATAN_ID_BARU ASC
);

/*==============================================================*/
/* Table: MF_JABATAN_KEGIATAN                                   */
/*==============================================================*/
CREATE TABLE MF_JABATAN_KEGIATAN 
(
   ITEM_ID              VARCHAR(50)                    NOT NULL,
   JABATAN_ID           INTEGER                        NOT NULL,
   DESKRIPSI            VARCHAR(500)                   NULL,
   AK                   FLOAT                          NULL,
   QTY                  FLOAT                          NULL,
   MUTU                 FLOAT                          NULL,
   WAKTU                TIMESTAMP                      NULL,
   BIAYA                FLOAT                          NULL,
   TYPE                 INTEGER                        NULL,
   UNSUR                VARCHAR(50)                    NULL,
   SATUAN_QTY           VARCHAR(50)                    NULL,
   SATUAN_MUTU          VARCHAR(50)                    NULL,
   SATUAN_WAKTU         VARCHAR(50)                    NULL,
   CONSTRAINT PK_MF_JABATAN_KEGIATAN PRIMARY KEY (ITEM_ID)
);

/*==============================================================*/
/* Index: MF_JABATAN_KEGIATAN_PK                                */
/*==============================================================*/
CREATE UNIQUE INDEX MF_JABATAN_KEGIATAN_PK ON MF_JABATAN_KEGIATAN (
ITEM_ID ASC
);

/*==============================================================*/
/* Index: DIBUAT_UNTUK_FK                                       */
/*==============================================================*/
CREATE INDEX DIBUAT_UNTUK_FK ON MF_JABATAN_KEGIATAN (
JABATAN_ID ASC
);

/*==============================================================*/
/* Table: MF_JAM_KERJA                                          */
/*==============================================================*/
CREATE TABLE MF_JAM_KERJA 
(
   JAM_KERJA_ID         INTEGER                        NOT NULL,
   STD_JAM_IN           TIMESTAMP                      NULL,
   STD_JAM_OUT          TIMESTAMP                      NULL,
   TGL_MULAI_BERLAKU    TIMESTAMP                      NULL,
   SHIFT                VARCHAR(50)                    NULL,
   AGENDA               VARCHAR(50)                    NULL,
   PENGGANTIAN_TLM1     VARCHAR(5)                     NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   SHIFT_KERJA          VARCHAR(2)                     NULL,
   CONSTRAINT PK_MF_JAM_KERJA PRIMARY KEY (JAM_KERJA_ID)
);

/*==============================================================*/
/* Index: MF_JAM_KERJA_PK                                       */
/*==============================================================*/
CREATE UNIQUE INDEX MF_JAM_KERJA_PK ON MF_JAM_KERJA (
JAM_KERJA_ID ASC
);

/*==============================================================*/
/* Table: MF_JOBLIST                                            */
/*==============================================================*/
CREATE TABLE MF_JOBLIST 
(
   GROUP_JABATAN_ID     INTEGER                        NOT NULL,
   ITEM_ID              VARCHAR(50)                    NOT NULL,
   DESKRIPSI            VARCHAR(500)                   NULL,
   AK                   FLOAT                          NULL,
   QTY                  FLOAT                          NULL,
   MUTU                 FLOAT                          NULL,
   WAKTU                TIMESTAMP                      NULL,
   BIAYA                FLOAT                          NULL,
   CONSTRAINT PK_MF_JOBLIST PRIMARY KEY (GROUP_JABATAN_ID, ITEM_ID)
);

/*==============================================================*/
/* Index: MF_JOBLIST_PK                                         */
/*==============================================================*/
CREATE UNIQUE INDEX MF_JOBLIST_PK ON MF_JOBLIST (
GROUP_JABATAN_ID ASC,
ITEM_ID ASC
);

/*==============================================================*/
/* Index: MEMILIKI_JOB_FK                                       */
/*==============================================================*/
CREATE INDEX MEMILIKI_JOB_FK ON MF_JOBLIST (
GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Index: MENGACU_KE_FK                                         */
/*==============================================================*/
CREATE INDEX MENGACU_KE_FK ON MF_JOBLIST (
ITEM_ID ASC
);

/*==============================================================*/
/* Table: MF_KLASIFIKASI_SURAT                                  */
/*==============================================================*/
CREATE TABLE MF_KLASIFIKASI_SURAT 
(
   KLASIFIKASI_ID       VARCHAR(5)                     NOT NULL,
   TYPE_SPRIN_ID        CHAR(20)                       NOT NULL,
   KLASIFIKASI_NAME     VARCHAR(50)                    NULL,
   CONSTRAINT PK_MF_KLASIFIKASI_SURAT PRIMARY KEY (KLASIFIKASI_ID)
);

/*==============================================================*/
/* Index: MF_KLASIFIKASI_SURAT_PK                               */
/*==============================================================*/
CREATE UNIQUE INDEX MF_KLASIFIKASI_SURAT_PK ON MF_KLASIFIKASI_SURAT (
KLASIFIKASI_ID ASC
);

/*==============================================================*/
/* Index: MENGAKLSIFIKASI_SURAT_FK                              */
/*==============================================================*/
CREATE INDEX MENGAKLSIFIKASI_SURAT_FK ON MF_KLASIFIKASI_SURAT (
TYPE_SPRIN_ID ASC
);

/*==============================================================*/
/* Table: MF_LOAD_FINGER                                        */
/*==============================================================*/
CREATE TABLE MF_LOAD_FINGER 
(
   TRAKSAKSI_ID         INTEGER                        NOT NULL,
   START_FINGER         TIMESTAMP                      NULL,
   END_FINGER           TIMESTAMP                      NULL,
   TGL_MULAI_BERLAKU    DATE                           NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   SHIFT_KERJA          VARCHAR(2)                     NULL,
   START_FINGER_OUT     TIMESTAMP                      NULL,
   END_FINGER_OUT       TIMESTAMP                      NULL
);

/*==============================================================*/
/* Index: MENCATAT_FINGER_FK                                    */
/*==============================================================*/
CREATE INDEX MENCATAT_FINGER_FK ON MF_LOAD_FINGER (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MF_ORGZ_SIAGA                                         */
/*==============================================================*/
CREATE TABLE MF_ORGZ_SIAGA 
(
   ORGZ_SIAGA_ID        INTEGER                        NOT NULL,
   FUNGSIONAL           VARCHAR(50)                    NULL,
   PARENT_ID            INTEGER                        NULL,
   URUT_FUNGSIONAL      FLOAT                          NULL,
   DESKRIPSI            VARCHAR(50)                    NULL,
   INISIAL              VARCHAR(2)                     NULL,
   FLAG                 VARCHAR(50)                    NULL,
   CONSTRAINT PK_MF_ORGZ_SIAGA PRIMARY KEY (ORGZ_SIAGA_ID)
);

/*==============================================================*/
/* Index: MF_ORGZ_SIAGA_PK                                      */
/*==============================================================*/
CREATE UNIQUE INDEX MF_ORGZ_SIAGA_PK ON MF_ORGZ_SIAGA (
ORGZ_SIAGA_ID ASC
);

/*==============================================================*/
/* Table: MF_POT                                                */
/*==============================================================*/
CREATE TABLE MF_POT 
(
   POTONGAN_ID          INTEGER                        NOT NULL,
   KATEGORI             VARCHAR(50)                    NULL,
   TINGKAT              VARCHAR(50)                    NULL,
   PERSEN_POT           FLOAT                          NULL,
   TGL_MULAI            TIMESTAMP                      NULL,
   RANGE_AWAL           FLOAT                          NULL,
   RANGE_AKHIR          FLOAT                          NULL,
   NAMA_POT             VARCHAR(50)                    NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   IS_PENDUKUNG         VARCHAR(2)                     NULL,
   TINDAKAN             VARCHAR(250)                   NULL,
   DURASI_POT           FLOAT                          NULL,
   SATUAN_DURASI        VARCHAR(10)                    NULL,
   CONSTRAINT PK_MF_POT PRIMARY KEY (POTONGAN_ID)
);

/*==============================================================*/
/* Index: MF_POT_PK                                             */
/*==============================================================*/
CREATE UNIQUE INDEX MF_POT_PK ON MF_POT (
POTONGAN_ID ASC
);

/*==============================================================*/
/* Table: MF_POTONGAN                                           */
/*==============================================================*/
CREATE TABLE MF_POTONGAN 
(
   POT_ID               INTEGER                        NOT NULL,
   KATEGORI             VARCHAR(50)                    NULL,
   TINGKAT              VARCHAR(50)                    NULL,
   PERSEN_POT           FLOAT                          NULL,
   TGL_MULAI            TIMESTAMP                      NULL,
   RANGE_AWAL           FLOAT                          NULL,
   RANGE_AKHIR          FLOAT                          NULL,
   NAMA_POT             VARCHAR(50)                    NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   IS_PENDUKUNG         VARCHAR(2)                     NULL,
   CONSTRAINT PK_MF_POTONGAN PRIMARY KEY (POT_ID)
);

/*==============================================================*/
/* Index: MF_POTONGAN_PK                                        */
/*==============================================================*/
CREATE UNIQUE INDEX MF_POTONGAN_PK ON MF_POTONGAN (
POT_ID ASC
);

/*==============================================================*/
/* Table: MF_PRIORITY_TRANSAKSI                                 */
/*==============================================================*/
CREATE TABLE MF_PRIORITY_TRANSAKSI 
(
   MODUL                VARCHAR(50)                    NULL,
   PRIORITY_TRANSAKSI   INTEGER                        NULL,
   TRANSAKSI            VARCHAR(50)                    NULL,
   INISIAL_TRANSAKSI    VARCHAR(5)                     NULL
);

/*==============================================================*/
/* Table: MF_SATUAN                                             */
/*==============================================================*/
CREATE TABLE MF_SATUAN 
(
   SATUAN_ID            INTEGER                        NOT NULL,
   ACTIVITY             VARCHAR(50)                    NULL,
   SATUAN               VARCHAR(50)                    NULL,
   PARAMETER            VARCHAR(50)                    NULL,
   URUT_SATUAN          INTEGER                        NULL,
   CONSTRAINT PK_MF_SATUAN PRIMARY KEY (SATUAN_ID)
);

/*==============================================================*/
/* Index: MF_SATUAN_PK                                          */
/*==============================================================*/
CREATE UNIQUE INDEX MF_SATUAN_PK ON MF_SATUAN (
SATUAN_ID ASC
);

/*==============================================================*/
/* Table: MF_SHIFT                                              */
/*==============================================================*/
CREATE TABLE MF_SHIFT 
(
   SHIFT_ID             VARCHAR(10)                    NOT NULL,
   TRAKSAKSI_ID         INTEGER                        NOT NULL,
   NAMA_SHIFT           VARCHAR(50)                    NULL,
   JADWAL               VARCHAR(50)                    NULL,
   START_SHIFT          TIMESTAMP                      NULL,
   END_SHIFT            TIMESTAMP                      NULL,
   TGL_MULAI_BERLAKU    DATE                           NULL,
   CONSTRAINT PK_MF_SHIFT PRIMARY KEY (SHIFT_ID)
);

/*==============================================================*/
/* Index: MF_SHIFT_PK                                           */
/*==============================================================*/
CREATE UNIQUE INDEX MF_SHIFT_PK ON MF_SHIFT (
SHIFT_ID ASC
);

/*==============================================================*/
/* Index: MENCATAT_SHIFT_FK                                     */
/*==============================================================*/
CREATE INDEX MENCATAT_SHIFT_FK ON MF_SHIFT (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MF_STATUS                                             */
/*==============================================================*/
CREATE TABLE MF_STATUS 
(
   STATUS_ID            INTEGER                        NOT NULL,
   STATUS               VARCHAR(50)                    NULL,
   BG_STATUS            VARCHAR(50)                    NULL,
   ALERT_STATUS         VARCHAR(50)                    NULL,
   SPAN_STATUS_LOG_JOB  VARCHAR(50)                    NULL,
   STATUS_LOG_JOB       VARCHAR(50)                    NULL,
   CONSTRAINT PK_MF_STATUS PRIMARY KEY (STATUS_ID)
);

/*==============================================================*/
/* Index: MF_STATUS_PK                                          */
/*==============================================================*/
CREATE UNIQUE INDEX MF_STATUS_PK ON MF_STATUS (
STATUS_ID ASC
);

/*==============================================================*/
/* Table: MF_SU                                                 */
/*==============================================================*/
CREATE TABLE MF_SU 
(
   NIP                  VARCHAR(50)                    NOT NULL,
   NAMA                 VARCHAR(50)                    NULL,
   PASS                 VARCHAR(50)                    NULL
);

/*==============================================================*/
/* Index: MENYIMPAN_USER_FK                                     */
/*==============================================================*/
CREATE INDEX MENYIMPAN_USER_FK ON MF_SU (
NIP ASC
);

/*==============================================================*/
/* Table: MF_TIM_SIAGA                                          */
/*==============================================================*/
CREATE TABLE MF_TIM_SIAGA 
(
   GUID_TIM             VARCHAR(50)                    NOT NULL,
   NO_URUT_TIM          INTEGER                        NULL,
   NAMA_TIM             VARCHAR(50)                    NULL,
   ID_UNIT_KERJA        VARCHAR(50)                    NULL,
   BULAN_PERIODE        VARCHAR(2)                     NULL,
   TAHUN_PERIODE        VARCHAR(4)                     NULL,
   FUNGSIONAL_TIM       VARCHAR(50)                    NULL,
   SHIFT                VARCHAR(5)                     NULL,
   IS_AKTIF             VARCHAR(1)                     NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   CONSTRAINT PK_MF_TIM_SIAGA PRIMARY KEY (GUID_TIM)
);

/*==============================================================*/
/* Index: MF_TIM_SIAGA_PK                                       */
/*==============================================================*/
CREATE UNIQUE INDEX MF_TIM_SIAGA_PK ON MF_TIM_SIAGA (
GUID_TIM ASC
);

/*==============================================================*/
/* Table: MF_TIM_SIAGA_ANGGOTA                                  */
/*==============================================================*/
CREATE TABLE MF_TIM_SIAGA_ANGGOTA 
(
   NIP                  VARCHAR(50)                    NOT NULL,
   GUID_TIM             VARCHAR(50)                    NOT NULL,
   FUNGSIONAL           VARCHAR(50)                    NULL,
   IS_AKTIF             VARCHAR(1)                     NULL,
   ID_UNIT_KERJA        VARCHAR(50)                    NULL,
   NO_URUT              INTEGER                        NULL,
   BULAN_PERIODE        VARCHAR(2)                     NULL,
   TAHUN_PERIODE        VARCHAR(4)                     NULL,
   SHIFT                VARCHAR(5)                     NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL
);

/*==============================================================*/
/* Index: BERANGGOTAKAN_FK                                      */
/*==============================================================*/
CREATE INDEX BERANGGOTAKAN_FK ON MF_TIM_SIAGA_ANGGOTA (
GUID_TIM ASC
);

/*==============================================================*/
/* Index: DIISI_OLEH_FK                                         */
/*==============================================================*/
CREATE INDEX DIISI_OLEH_FK ON MF_TIM_SIAGA_ANGGOTA (
NIP ASC
);

/*==============================================================*/
/* Table: MF_TR                                                 */
/*==============================================================*/
CREATE TABLE MF_TR 
(
   TRAKSAKSI_ID         INTEGER                        NOT NULL,
   JAM_LOAD             TIMESTAMP                      NULL
);

/*==============================================================*/
/* Index: MENCATAT_TR_FK                                        */
/*==============================================================*/
CREATE INDEX MENCATAT_TR_FK ON MF_TR (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MF_TUNJANGAN                                          */
/*==============================================================*/
CREATE TABLE MF_TUNJANGAN 
(
   TUNJANGAN_ID         INTEGER                        NOT NULL,
   JENIS_TUNJANGAN      VARCHAR(50)                    NULL,
   ACTIVITY             VARCHAR(50)                    NULL,
   NOMINAL              FLOAT                          NULL,
   TGL_MULAI            DATE                           NULL,
   HARI_KERJA           INTEGER                        NULL,
   FUNGSIONAL           VARCHAR(50)                    NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   DOKREFF              VARCHAR(250)                   NULL,
   STATUS_PEG           INTEGER                        NULL,
   SHIFT                VARCHAR(5)                     NULL,
   UNIT_KERJA_ID        VARCHAR(50)                    NULL,
   CONSTRAINT PK_MF_TUNJANGAN PRIMARY KEY (TUNJANGAN_ID)
);

/*==============================================================*/
/* Index: MF_TUNJANGAN_PK                                       */
/*==============================================================*/
CREATE UNIQUE INDEX MF_TUNJANGAN_PK ON MF_TUNJANGAN (
TUNJANGAN_ID ASC
);

/*==============================================================*/
/* Table: MF_TYPE_SPRIN                                         */
/*==============================================================*/
CREATE TABLE MF_TYPE_SPRIN 
(
   TYPE_SPRIN_ID        CHAR(20)                       NOT NULL,
   TYPE_SPRIN_NAME      VARCHAR(50)                    NULL,
   CONSTRAINT PK_MF_TYPE_SPRIN PRIMARY KEY (TYPE_SPRIN_ID)
);

/*==============================================================*/
/* Index: MF_TYPE_SPRIN_PK                                      */
/*==============================================================*/
CREATE UNIQUE INDEX MF_TYPE_SPRIN_PK ON MF_TYPE_SPRIN (
TYPE_SPRIN_ID ASC
);

/*==============================================================*/
/* Table: MF_UNIT_KERJA                                         */
/*==============================================================*/
CREATE TABLE MF_UNIT_KERJA 
(
   UNIT_KERJA_ID        INTEGER                        NOT NULL,
   NAMA_UNIT_KERJA      VARCHAR(50)                    NULL,
   URUT_REPORT          INTEGER                        NULL,
   IS_PUSAT             INTEGER                        NULL,
   TRANSAC_ID           INTEGER                        NULL,
   UPDATE_IN_BY         VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   CONSTRAINT PK_MF_UNIT_KERJA PRIMARY KEY (UNIT_KERJA_ID)
);

/*==============================================================*/
/* Index: MF_UNIT_KERJA_PK                                      */
/*==============================================================*/
CREATE UNIQUE INDEX MF_UNIT_KERJA_PK ON MF_UNIT_KERJA (
UNIT_KERJA_ID ASC
);

/*==============================================================*/
/* Table: MF_UNSUR_KEGIATAN                                     */
/*==============================================================*/
CREATE TABLE MF_UNSUR_KEGIATAN 
(
   UNSUR_ID             INTEGER                        NOT NULL,
   DESKRIPSI_UNSUR      VARCHAR(50)                    NULL,
   CONSTRAINT PK_MF_UNSUR_KEGIATAN PRIMARY KEY (UNSUR_ID)
);

/*==============================================================*/
/* Index: MF_UNSUR_KEGIATAN_PK                                  */
/*==============================================================*/
CREATE UNIQUE INDEX MF_UNSUR_KEGIATAN_PK ON MF_UNSUR_KEGIATAN (
UNSUR_ID ASC
);

/*==============================================================*/
/* Table: MF_SUB_GROUP_JABATAN                                 */
/*==============================================================*/
CREATE TABLE MF_SUB_GROUP_JABATAN 
(
   SUB_GROUP_JABATAN_ID INTEGER                        NOT NULL,
   NAMA_SUB_GROUP_JABATAN VARCHAR(150)                   NOT NULL,
   CONSTRAINT PK_MF_SUB_GROUP_JABATAN PRIMARY KEY (SUB_GROUP_JABATAN_ID)
);

/*==============================================================*/
/* Index: MF_SUB_GROUP_JABATAN_PK                              */
/*==============================================================*/
CREATE UNIQUE INDEX MF_SUB_GROUP_JABATAN_PK ON MF_SUB_GROUP_JABATAN (
SUB_GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Table: MONITORING_APP                                        */
/*==============================================================*/
CREATE TABLE MONITORING_APP 
(
   TRAKSAKSI_ID         INTEGER                        NOT NULL,
   APLICATION           VARCHAR(50)                    NULL,
   USER_NAME            VARCHAR(50)                    NULL,
   COMPUTER_IP          VARCHAR(50)                    NULL,
   LOGIN_TIME           TIMESTAMP                      NULL,
   LOGIN_DATE           TIMESTAMP                      NULL,
   IS_ON                VARCHAR(5)                     NULL
);

/*==============================================================*/
/* Index: MENCATAT_LOG_APP_FK                                   */
/*==============================================================*/
CREATE INDEX MENCATAT_LOG_APP_FK ON MONITORING_APP (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: OTORISASI                                             */
/*==============================================================*/
CREATE TABLE OTORISASI 
(
   GUID_OTO             VARCHAR(100)                   NOT NULL,
   NIP                  VARCHAR(50)                    NULL,
   TRX                  VARCHAR(50)                    NULL,
   LEVEL_OTO            INTEGER                        NULL,
   JABATAN              VARCHAR(100)                   NULL,
   ACT                  INTEGER                        NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   PERIHAL              VARCHAR(150)                   NULL,
   KETERANGAN           VARCHAR(150)                   NULL,
   BULAN                INTEGER                        NULL,
   TAHUN                INTEGER                        NULL,
   TGL_PENGAJUAN        TIMESTAMP                      NULL,
   CONSTRAINT PK_OTORISASI PRIMARY KEY (GUID_OTO)
);

/*==============================================================*/
/* Index: OTORISASI_PK                                          */
/*==============================================================*/
CREATE UNIQUE INDEX OTORISASI_PK ON OTORISASI (
GUID_OTO ASC
);

/*==============================================================*/
/* Index: DIAJUKAN_OLEH_FK                                      */
/*==============================================================*/
CREATE INDEX DIAJUKAN_OLEH_FK ON OTORISASI (
NIP ASC
);

/*==============================================================*/
/* Table: OTORISASI_HISTORY                                     */
/*==============================================================*/
CREATE TABLE OTORISASI_HISTORY 
(
   OTO_HISTORY_ID       INTEGER                        NOT NULL,
   GUID_OTO             VARCHAR(100)                   NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   UNIT_KERJA_ID        INTEGER                        NOT NULL,
   TRX                  VARCHAR(50)                    NULL,
   LEVEL_OTO            INTEGER                        NULL,
   JABATAN              VARCHAR(100)                   NULL,
   ACT                  INTEGER                        NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   PERIHAL              VARCHAR(150)                   NULL,
   KETERANGAN           VARCHAR(150)                   NULL,
   BULAN                INTEGER                        NULL,
   TAHUN                INTEGER                        NULL,
   SHIFT_1              INTEGER                        NULL,
   SHIFT_2              INTEGER                        NULL,
   REC_DATE             TIMESTAMP                      NULL,
   TGL_PENGAJUAN        TIMESTAMP                      NULL,
   CONSTRAINT PK_OTORISASI_HISTORY PRIMARY KEY (OTO_HISTORY_ID)
);

/*==============================================================*/
/* Index: OTORISASI_HISTORY_PK                                  */
/*==============================================================*/
CREATE UNIQUE INDEX OTORISASI_HISTORY_PK ON OTORISASI_HISTORY (
OTO_HISTORY_ID ASC
);

/*==============================================================*/
/* Index: USER_OTORISASI_HISTORY_FK                             */
/*==============================================================*/
CREATE INDEX USER_OTORISASI_HISTORY_FK ON OTORISASI_HISTORY (
NIP ASC
);

/*==============================================================*/
/* Index: OTORISASI_HISTORY_UNIT_FK                             */
/*==============================================================*/
CREATE INDEX OTORISASI_HISTORY_UNIT_FK ON OTORISASI_HISTORY (
UNIT_KERJA_ID ASC
);

/*==============================================================*/
/* Index: OTORISASI_SEBELUMNYA_FK                               */
/*==============================================================*/
CREATE INDEX OTORISASI_SEBELUMNYA_FK ON OTORISASI_HISTORY (
GUID_OTO ASC
);

/*==============================================================*/
/* Table: PEGAWAI                                               */
/*==============================================================*/
CREATE TABLE PEGAWAI 
(
   NIP                  VARCHAR(50)                    NOT NULL,
   ABSENSI_ID           INTEGER                        NOT NULL,
   ESELON               VARCHAR(50)                    NOT NULL,
   TUNJANGAN_ID         INTEGER                        NOT NULL,
   CLASS_ID             INTEGER                        NOT NULL,
   UNIT_KERJA_ID        INTEGER                        NOT NULL,
   JABATAN_ID           INTEGER                        NOT NULL,
   GOL_ID               INTEGER                        NOT NULL,
   NIP_MANAGER          VARCHAR(50)                    NULL,
   NAMA                 VARCHAR(70)                    NOT NULL,
   NO_TELP              VARCHAR(50)                    NOT NULL,
   PANGKAT              VARCHAR(50)                    NULL,
   JABATAN              VARCHAR(50)                    NULL,
   MAIL                 VARCHAR(100)                   NULL,
   PASS                 VARCHAR(50)                    NOT NULL,
   ALAMAT               VARCHAR(50)                    NULL,
   JENIS_KEL            VARCHAR(15)                    NULL,
   TGL_LAHIR            TIMESTAMP                      NULL,
   KELURAHAN            VARCHAR(50)                    NULL,
   KECAMATAN            VARCHAR(50)                    NULL,
   KOTA                 VARCHAR(50)                    NULL,
   TEMPAT_LAHIR         VARCHAR(100)                   NULL,
   AGAMA                VARCHAR(100)                   NULL,
   STATUS_PERKAWINAN    SMALLINT                       NULL,
   NO_KTP               VARCHAR(50)                    NULL,
   NO_NPWP              VARCHAR(50)                    NULL,
   HOBI                 VARCHAR(150)                   NULL,
   IS_VIP               SMALLINT                       NULL,
   TMT_PANGKAT          TIMESTAMP                      NULL,
   IS_KELUAR            SMALLINT                       NULL,
   TGL_KELUAR           TIMESTAMP                      NULL,
   ALASAN_KELUAR        VARCHAR(250)                   NULL,
   TGL_MASUK            TIMESTAMP                      NULL,
   TMT_PNS              DATE                           NULL,
   TMT_CPNS             DATE                           NULL,
   GOL_RECRUIT          VARCHAR(10)                    NULL,
   STATUS_PEG           SMALLINT                       NULL,
   TMT_CLASS            DATE                           NULL,
   TMT_JABATAN          DATE                           NULL,
   UPDATE_IN_BY         VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   CONSTRAINT PK_PEGAWAI PRIMARY KEY (NIP)
);

/*==============================================================*/
/* Index: PEGAWAI_PK                                            */
/*==============================================================*/
CREATE UNIQUE INDEX PEGAWAI_PK ON PEGAWAI (
NIP ASC
);

/*==============================================================*/
/* Index: MENDUDUKI_JABATAN_FK                                  */
/*==============================================================*/
CREATE INDEX MENDUDUKI_JABATAN_FK ON PEGAWAI (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: MEMILIKI_GOLONGAN_FK                                  */
/*==============================================================*/
CREATE INDEX MEMILIKI_GOLONGAN_FK ON PEGAWAI (
GOL_ID ASC
);

/*==============================================================*/
/* Index: BEKERJA_DI_UNIT_FK                                    */
/*==============================================================*/
CREATE INDEX BEKERJA_DI_UNIT_FK ON PEGAWAI (
UNIT_KERJA_ID ASC
);

/*==============================================================*/
/* Index: TERMASUK_KELAS_FK                                     */
/*==============================================================*/
CREATE INDEX TERMASUK_KELAS_FK ON PEGAWAI (
CLASS_ID ASC
);

/*==============================================================*/
/* Index: DILAKUKAN_OLEH_FK                                     */
/*==============================================================*/
CREATE INDEX DILAKUKAN_OLEH_FK ON PEGAWAI (
ABSENSI_ID ASC
);

/*==============================================================*/
/* Index: MEMILIKI_ESELON_FK                                    */
/*==============================================================*/
CREATE INDEX MEMILIKI_ESELON_FK ON PEGAWAI (
ESELON ASC
);

/*==============================================================*/
/* Index: UNTUK_STATUS_TUNJANGAN_FK                             */
/*==============================================================*/
CREATE INDEX UNTUK_STATUS_TUNJANGAN_FK ON PEGAWAI (
TUNJANGAN_ID ASC
);

/*==============================================================*/
/* Table: PEG_MUTASI_UNIT                                       */
/*==============================================================*/
CREATE TABLE PEG_MUTASI_UNIT 
(
   TRAKSAKSI_ID         INTEGER                        NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   TGL_MUTASI           DATE                           NULL,
   UNIT_KERJA           VARCHAR(50)                    NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   NO_SK                VARCHAR(50)                    NULL,
   KETERANGAN           VARCHAR(250)                   NULL
);

/*==============================================================*/
/* Index: USER_PINDAH_UNIT_FK                                   */
/*==============================================================*/
CREATE INDEX USER_PINDAH_UNIT_FK ON PEG_MUTASI_UNIT (
NIP ASC
);

/*==============================================================*/
/* Index: MENCATAT_MUTASI_UNIT_FK                               */
/*==============================================================*/
CREATE INDEX MENCATAT_MUTASI_UNIT_FK ON PEG_MUTASI_UNIT (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: PERUBAHAN_JABATAN                                     */
/*==============================================================*/
CREATE TABLE PERUBAHAN_JABATAN 
(
   JABATAN_ID_BARU      INTEGER                        NOT NULL,
   JABATAN_ID           INTEGER                        NULL,
   CONSTRAINT PK_PERUBAHAN_JABATAN PRIMARY KEY (JABATAN_ID_BARU)
);

/*==============================================================*/
/* Index: PERUBAHAN_JABATAN_PK                                  */
/*==============================================================*/
CREATE UNIQUE INDEX PERUBAHAN_JABATAN_PK ON PERUBAHAN_JABATAN (
JABATAN_ID_BARU ASC
);

/*==============================================================*/
/* Index: MERUBAH_JABATAN2_FK                                   */
/*==============================================================*/
CREATE INDEX MERUBAH_JABATAN2_FK ON PERUBAHAN_JABATAN (
JABATAN_ID ASC
);

/*==============================================================*/
/* Table: SARAN                                                 */
/*==============================================================*/
CREATE TABLE SARAN 
(
   ID_SARAN             INTEGER                        NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   SARAN                VARCHAR(350)                   NOT NULL,
   INSTANSI             VARCHAR(100)                   NOT NULL,
   CONSTRAINT PK_SARAN PRIMARY KEY (ID_SARAN)
);

/*==============================================================*/
/* Index: SARAN_PK                                              */
/*==============================================================*/
CREATE UNIQUE INDEX SARAN_PK ON SARAN (
ID_SARAN ASC
);

/*==============================================================*/
/* Index: MENYAMPAIKAN_FK                                       */
/*==============================================================*/
CREATE INDEX MENYAMPAIKAN_FK ON SARAN (
NIP ASC
);

/*==============================================================*/
/* Table: SKP_PEGAWAI                                           */
/*==============================================================*/
CREATE TABLE SKP_PEGAWAI 
(
   GUID_SKP_PEG         VARCHAR(100)                   NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   JABATAN_ID           INTEGER                        NOT NULL,
   DESKRIPSI            VARCHAR(500)                   NULL,
   AK                   FLOAT                          NULL,
   QTY                  FLOAT                          NULL,
   MUTU                 FLOAT                          NULL,
   WAKTU                TIMESTAMP                      NULL,
   BIAYA                FLOAT                          NULL,
   UNSUR                VARCHAR(50)                    NULL,
   TYPE                 INTEGER                        NULL,
   TGL_MULAI            TIMESTAMP                      NULL,
   SATUAN_QTY           VARCHAR(50)                    NULL,
   SATUAN_MUTU          VARCHAR(50)                    NULL,
   SATUAN_WAKTU         VARCHAR(50)                    NULL,
   CONSTRAINT PK_SKP_PEGAWAI PRIMARY KEY (GUID_SKP_PEG)
);

/*==============================================================*/
/* Index: SKP_PEGAWAI_PK                                        */
/*==============================================================*/
CREATE UNIQUE INDEX SKP_PEGAWAI_PK ON SKP_PEGAWAI (
GUID_SKP_PEG ASC
);

/*==============================================================*/
/* Index: DILAKSANAKAN_DI_FK                                    */
/*==============================================================*/
CREATE INDEX DILAKSANAKAN_DI_FK ON SKP_PEGAWAI (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: TERKAIT_OLEH_FK                                       */
/*==============================================================*/
CREATE INDEX TERKAIT_OLEH_FK ON SKP_PEGAWAI (
NIP ASC
);

/*==============================================================*/
/* Table: SKP_PEGAWAI_HEAD                                      */
/*==============================================================*/
CREATE TABLE SKP_PEGAWAI_HEAD 
(
   SKP_PEGAWAI_HEAD_ID  INTEGER                        NOT NULL,
   GUID_SKP_PEG         VARCHAR(100)                   NOT NULL,
   NIP                  VARCHAR(50)                    NOT NULL,
   GOL_ID               INTEGER                        NOT NULL,
   JABATAN_ID           INTEGER                        NOT NULL,
   TGL_MULAI            TIMESTAMP                      NULL,
   NIP_PARENT           VARCHAR(50)                    NULL,
   JABATAN_ID_PARENT    VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   TGL_PEMBUATAN        TIMESTAMP                      NULL,
   GOL_PARENT           VARCHAR(10)                    NULL,
   CONSTRAINT PK_SKP_PEGAWAI_HEAD PRIMARY KEY (SKP_PEGAWAI_HEAD_ID)
);

/*==============================================================*/
/* Index: SKP_PEGAWAI_HEAD_PK                                   */
/*==============================================================*/
CREATE UNIQUE INDEX SKP_PEGAWAI_HEAD_PK ON SKP_PEGAWAI_HEAD (
SKP_PEGAWAI_HEAD_ID ASC
);

/*==============================================================*/
/* Index: JABATAN_PEGAWAI_HEAD_FK                               */
/*==============================================================*/
CREATE INDEX JABATAN_PEGAWAI_HEAD_FK ON SKP_PEGAWAI_HEAD (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: USER_HEAD_FK                                          */
/*==============================================================*/
CREATE INDEX USER_HEAD_FK ON SKP_PEGAWAI_HEAD (
NIP ASC
);

/*==============================================================*/
/* Index: GOL_PEGAWAI_HEAD_FK                                   */
/*==============================================================*/
CREATE INDEX GOL_PEGAWAI_HEAD_FK ON SKP_PEGAWAI_HEAD (
GOL_ID ASC
);

/*==============================================================*/
/* Index: BAWAHAN_USER_SKP_FK                                   */
/*==============================================================*/
CREATE INDEX BAWAHAN_USER_SKP_FK ON SKP_PEGAWAI_HEAD (
GUID_SKP_PEG ASC
);

/*==============================================================*/
/* Table: SPRIN_HEADER                                          */
/*==============================================================*/
CREATE TABLE SPRIN_HEADER 
(
   GUID_SPRIN           VARCHAR(50)                    NOT NULL,
   TYPE_SPRIN_ID        CHAR(20)                       NOT NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   ROLE_NUMBER          INTEGER                        NULL,
   ABSENSI_FINGER       VARCHAR(2)                     NULL,
   TGL_SPRIN            DATE                           NULL,
   PERIHAL_SPRIN        VARCHAR(250)                   NULL,
   MENIMBANG_1          VARCHAR(250)                   NULL,
   MENIMBANG_2          VARCHAR(250)                   NULL,
   MENIMBANG_3          VARCHAR(250)                   NULL,
   DASAR_1              VARCHAR(250)                   NULL,
   DASAR_2              VARCHAR(250)                   NULL,
   DASAR_3              VARCHAR(250)                   NULL,
   UNTUK_1              VARCHAR(250)                   NULL,
   UNTUK_2              VARCHAR(250)                   NULL,
   UNTUK_3              VARCHAR(250)                   NULL,
   UNTUK_4              VARCHAR(250)                   NULL,
   UNTUK_5              VARCHAR(250)                   NULL,
   JABATAN_OTO          VARCHAR(100)                   NULL,
   NIP_OTO              VARCHAR(50)                    NULL,
   NO_URUT_SPRIN        VARCHAR(5)                     NULL,
   NO_SISIPAN           VARCHAR(50)                    NULL,
   NO_SPRIN             VARCHAR(50)                    NULL,
   TGL_AWAL_SPRIN       DATE                           NULL,
   TGL_AKHIR_SPRIN      VARCHAR(50)                    NULL,
   PENEMPATAN           VARCHAR(150)                   NULL,
   STATUS_UM            INTEGER                        NULL,
   CONSTRAINT PK_SPRIN_HEADER PRIMARY KEY (GUID_SPRIN)
);

/*==============================================================*/
/* Index: SPRIN_HEADER_PK                                       */
/*==============================================================*/
CREATE UNIQUE INDEX SPRIN_HEADER_PK ON SPRIN_HEADER (
GUID_SPRIN ASC
);

/*==============================================================*/
/* Index: BERTIPE_FK                                            */
/*==============================================================*/
CREATE INDEX BERTIPE_FK ON SPRIN_HEADER (
TYPE_SPRIN_ID ASC
);

/*==============================================================*/
/* Table: TIME_RECORDER                                         */
/*==============================================================*/
CREATE TABLE TIME_RECORDER 
(
   FINGER_ID            INTEGER                        NOT NULL,
   WAKTU                TIMESTAMP                      NULL,
   STATUS               VARCHAR(3)                     NULL,
   MESIN                VARCHAR(100)                   NULL,
   KET                  VARCHAR(50)                    NULL,
   TRANSAKSI            VARCHAR(50)                    NULL,
   KET_INJECT           VARCHAR(150)                   NULL,
   REF_INJECT           VARCHAR(150)                   NULL,
   TRX                  VARCHAR(50)                    NULL,
   UPDATE_IN_BY         VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL,
   CONSTRAINT PK_TIME_RECORDER PRIMARY KEY (FINGER_ID)
);

/*==============================================================*/
/* Index: TIME_RECORDER_PK                                      */
/*==============================================================*/
CREATE UNIQUE INDEX TIME_RECORDER_PK ON TIME_RECORDER (
FINGER_ID ASC
);

/*==============================================================*/
/* Table: USER_ACCOUNT                                          */
/*==============================================================*/
CREATE TABLE USER_ACCOUNT 
(
   NIP                  VARCHAR(50)                    NOT NULL,
   INIT_LEVEL           INTEGER                        NULL,
   MODUL                VARCHAR(50)                    NULL,
   UPDATE_BY            VARCHAR(50)                    NULL,
   UPDATE_DATE          TIMESTAMP                      NULL
);

/*==============================================================*/
/* Index: DIMILIKI_OLEH_USER_FK                                 */
/*==============================================================*/
CREATE INDEX DIMILIKI_OLEH_USER_FK ON USER_ACCOUNT (
NIP ASC
);

ALTER TABLE ABSENSI
   ADD CONSTRAINT FK_ABSENSI_DATA_BACK_ABSENSI_ FOREIGN KEY (ABSENSI_BACKUP_ID)
      REFERENCES ABSENSI_BACKUP (ABSENSI_BACKUP_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE ABSENSI
   ADD CONSTRAINT FK_ABSENSI_DATA_TEMP_ABSENSI_ FOREIGN KEY (ABSENSI_TEMP_ID)
      REFERENCES ABSENSI_TEMP (ABSENSI_TEMP_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE ABSENSI
   ADD CONSTRAINT FK_ABSENSI_DITERAPKA_MF_POT FOREIGN KEY (POTONGAN_ID)
      REFERENCES MF_POT (POTONGAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE ABSENSI
   ADD CONSTRAINT FK_ABSENSI_MENJADI_S_TIME_REC FOREIGN KEY (FINGER_ID)
      REFERENCES TIME_RECORDER (FINGER_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE ABSENSI
   ADD CONSTRAINT FK_ABSENSI_TERJADI_P_KALENDER FOREIGN KEY (TGL_KERJA)
      REFERENCES KALENDER (TGL_KERJA)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE ABSENSI_BACKUP
   ADD CONSTRAINT FK_ABSENSI__DATA_BACK_ABSENSI FOREIGN KEY (ABSENSI_ID)
      REFERENCES ABSENSI (ABSENSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE ABSENSI_TEMP
   ADD CONSTRAINT FK_ABSENSI__DATA_TEMP_ABSENSI FOREIGN KEY (ABSENSI_ID)
      REFERENCES ABSENSI (ABSENSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE BUKU_HARIAN_HEAD
   ADD CONSTRAINT FK_BUKU_HAR_DIBUAT_OL_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE BUKU_HARIAN_HEAD
   ADD CONSTRAINT FK_BUKU_HAR_TERKAIT_D_SKP_PEGA FOREIGN KEY (GUID_SKP_PEG)
      REFERENCES SKP_PEGAWAI (GUID_SKP_PEG)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE BUKU_HARIAN_HEAD
   ADD CONSTRAINT FK_BUKU_HAR_TERKAIT_J_MF_JABAT2 FOREIGN KEY (JABATAN_ID)
      REFERENCES MF_JABATAN (JABATAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE BUKU_HARIAN_HEAD
   ADD CONSTRAINT FK_BUKU_HAR_TERKAIT_J_MF_JABAT FOREIGN KEY (ITEM_ID)
      REFERENCES MF_JABATAN_KEGIATAN (ITEM_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE DINAS_LUAR
   ADD CONSTRAINT FK_DINAS_LU_BERDASARK_SPRIN_HE FOREIGN KEY (GUID_SPRIN)
      REFERENCES SPRIN_HEADER (GUID_SPRIN)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE DINAS_LUAR
   ADD CONSTRAINT FK_DINAS_LU_MELAKUKAN_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE DRH
   ADD CONSTRAINT FK_DRH_JABATAN_D_MF_JABAT FOREIGN KEY (JABATAN_ID)
      REFERENCES MF_JABATAN (JABATAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE DRH
   ADD CONSTRAINT FK_DRH_MEREKAM_D_LOG_TRAN FOREIGN KEY (TRAKSAKSI_ID)
      REFERENCES LOG_TRANSAKSI (TRAKSAKSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE DRH
   ADD CONSTRAINT FK_DRH_PEGAWAI_D_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE HAK_AKSES_FORM
   ADD CONSTRAINT FK_HAK_AKSE_DIBERIKAN_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE HAK_AKSES_FORM
   ADD CONSTRAINT FK_HAK_AKSE_UNTUK_FOR_MF_FORM FOREIGN KEY (FORM_ID)
      REFERENCES MF_FORM (FORM_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE HAK_AKSES_TYPE_SPRIN
   ADD CONSTRAINT FK_HAK_AKSE_AKSES_SPR_MF_TYPE_ FOREIGN KEY (TYPE_SPRIN_ID)
      REFERENCES MF_TYPE_SPRIN (TYPE_SPRIN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE HAK_AKSES_TYPE_SPRIN
   ADD CONSTRAINT FK_HAK_AKSE_USER_SPRI_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LEMBUR
   ADD CONSTRAINT FK_LEMBUR_DILAKUKAN_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LEMBUR
   ADD CONSTRAINT FK_LEMBUR_TERJADI_T_KALENDER FOREIGN KEY (TGL_KERJA)
      REFERENCES KALENDER (TGL_KERJA)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LOG_ACTIVITIY
   ADD CONSTRAINT FK_LOG_ACTI_DILAKUKAN_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LOG_ACTIVITIY
   ADD CONSTRAINT FK_LOG_ACTI_DILAKUKAN_MF_TIM_S FOREIGN KEY (GUID_TIM)
      REFERENCES MF_TIM_SIAGA (GUID_TIM)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LOG_ACTIVITIY
   ADD CONSTRAINT FK_LOG_ACTI_MEMBACKUP_LOG_ACTI FOREIGN KEY (GUID_LOG_BACKUP)
      REFERENCES LOG_ACTIVITIY_BACKUP (GUID_LOG_BACKUP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LOG_ACTIVITIY
   ADD CONSTRAINT FK_LOG_ACTI_MEMILIKI__MF_STATU FOREIGN KEY (STATUS_ID)
      REFERENCES MF_STATUS (STATUS_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LOG_ACTIVITIY
   ADD CONSTRAINT FK_LOG_ACTI_TRANSAKSI_LOG_TRAN FOREIGN KEY (TRAKSAKSI_ID)
      REFERENCES LOG_TRANSAKSI (TRAKSAKSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LOG_ACTIVITIY
   ADD CONSTRAINT FK_LOG_ACTI_UNIT_MELA_MF_UNIT_ FOREIGN KEY (UNIT_KERJA_ID)
      REFERENCES MF_UNIT_KERJA (UNIT_KERJA_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LOG_ACTIVITIY_BACKUP
   ADD CONSTRAINT FK_LOG_ACTI_MEMBACKUP_LOG_BKP FOREIGN KEY (GUID_LOG)
      REFERENCES LOG_ACTIVITIY (GUID_LOG)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LOG_TRANSAKSI
   ADD CONSTRAINT FK_LOG_TRAN_DATA_BACK_LOG_TRAN FOREIGN KEY (TRAKSAKSI_BACKUP_ID)
      REFERENCES LOG_TRANSAKSI_BACKUP (TRAKSAKSI_BACKUP_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LOG_TRANSAKSI
   ADD CONSTRAINT FK_LOG_TRAN_TRANSAKSI_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE LOG_TRANSAKSI_BACKUP
   ADD CONSTRAINT FK_LOG_TRAN_DATA_BACK_LOG_BKP FOREIGN KEY (TRAKSAKSI_ID)
      REFERENCES LOG_TRANSAKSI (TRAKSAKSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_CONFIG
   ADD CONSTRAINT FK_MF_CONFI_MENCATAT__LOG_TRAN FOREIGN KEY (TRAKSAKSI_ID)
      REFERENCES LOG_TRANSAKSI (TRAKSAKSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_FIELD_CARI
   ADD CONSTRAINT FK_MF_FIELD_MENCATAT__LOG_TRAN FOREIGN KEY (TRAKSAKSI_ID)
      REFERENCES LOG_TRANSAKSI (TRAKSAKSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_HOST_NAME_FP
   ADD CONSTRAINT FK_MF_HOST__HOST_DARI_MF_UNIT_ FOREIGN KEY (UNIT_KERJA_ID)
      REFERENCES MF_UNIT_KERJA (UNIT_KERJA_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_JABATAN
   ADD CONSTRAINT FK_MF_JABAT_MERUBAH_J_PERUBAHA FOREIGN KEY (JABATAN_ID_BARU)
      REFERENCES PERUBAHAN_JABATAN (JABATAN_ID_BARU)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_JABATAN
   ADD CONSTRAINT FK_MF_JABAT_TERMASUK__MF_GROUP FOREIGN KEY (GROUP_JABATAN_ID)
      REFERENCES MF_GROUP_JABATAN (GROUP_JABATAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_JABATAN
   ADD CONSTRAINT FK_MF_JABAT_TERMASUK__MF__SUB_ FOREIGN KEY (SUB_GROUP_JABATAN_ID)
      REFERENCES MF_SUB_GROUP_JABATAN (SUB_GROUP_JABATAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_JABATAN_KEGIATAN
   ADD CONSTRAINT FK_MF_JABAT_DIBUAT_UN_MF_JABAT FOREIGN KEY (JABATAN_ID)
      REFERENCES MF_JABATAN (JABATAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_JOBLIST
   ADD CONSTRAINT FK_MF_JOBLI_MEMILIKI__MF_GROUP FOREIGN KEY (GROUP_JABATAN_ID)
      REFERENCES MF_GROUP_JABATAN (GROUP_JABATAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_JOBLIST
   ADD CONSTRAINT FK_MF_JOBLI_MENGACU_K_MF_JABAT FOREIGN KEY (ITEM_ID)
      REFERENCES MF_JABATAN_KEGIATAN (ITEM_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_KLASIFIKASI_SURAT
   ADD CONSTRAINT FK_MF_KLASI_MENGAKLSI_MF_TYPE_ FOREIGN KEY (TYPE_SPRIN_ID)
      REFERENCES MF_TYPE_SPRIN (TYPE_SPRIN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_LOAD_FINGER
   ADD CONSTRAINT FK_MF_LOAD__MENCATAT__LOG_TRAN FOREIGN KEY (TRAKSAKSI_ID)
      REFERENCES LOG_TRANSAKSI (TRAKSAKSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_SHIFT
   ADD CONSTRAINT FK_MF_SHIFT_MENCATAT__LOG_TRAN FOREIGN KEY (TRAKSAKSI_ID)
      REFERENCES LOG_TRANSAKSI (TRAKSAKSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_SU
   ADD CONSTRAINT FK_MF_SU_MENYIMPAN_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_TIM_SIAGA_ANGGOTA
   ADD CONSTRAINT FK_MF_TIM_S_BERANGGOT_MF_TIM_S FOREIGN KEY (GUID_TIM)
      REFERENCES MF_TIM_SIAGA (GUID_TIM)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_TIM_SIAGA_ANGGOTA
   ADD CONSTRAINT FK_MF_TIM_S_DIISI_OLE_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MF_TR
   ADD CONSTRAINT FK_MF_TR_MENCATAT__LOG_TRAN FOREIGN KEY (TRAKSAKSI_ID)
      REFERENCES LOG_TRANSAKSI (TRAKSAKSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE MONITORING_APP
   ADD CONSTRAINT FK_MONITORI_MENCATAT__LOG_TRAN FOREIGN KEY (TRAKSAKSI_ID)
      REFERENCES LOG_TRANSAKSI (TRAKSAKSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE OTORISASI
   ADD CONSTRAINT FK_OTORISAS_DIAJUKAN__PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE OTORISASI_HISTORY
   ADD CONSTRAINT FK_OTORISAS_OTORISASI_MF_UNIT_ FOREIGN KEY (UNIT_KERJA_ID)
      REFERENCES MF_UNIT_KERJA (UNIT_KERJA_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE OTORISASI_HISTORY
   ADD CONSTRAINT FK_OTORISAS_OTORISASI_OTORISAS FOREIGN KEY (GUID_OTO)
      REFERENCES OTORISASI (GUID_OTO)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE OTORISASI_HISTORY
   ADD CONSTRAINT FK_OTORISAS_USER_OTOR_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE PEGAWAI
   ADD CONSTRAINT FK_PEGAWAI_BEKERJA_D_MF_UNIT_ FOREIGN KEY (UNIT_KERJA_ID)
      REFERENCES MF_UNIT_KERJA (UNIT_KERJA_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE PEGAWAI
   ADD CONSTRAINT FK_PEGAWAI_DILAKUKAN_ABSENSI FOREIGN KEY (ABSENSI_ID)
      REFERENCES ABSENSI (ABSENSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE PEGAWAI
   ADD CONSTRAINT FK_PEGAWAI_MEMILIKI__MF_ESELO FOREIGN KEY (ESELON)
      REFERENCES MF_ESELON (ESELON)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE PEGAWAI
   ADD CONSTRAINT FK_PEGAWAI_MEMILIKI__MF_GOL FOREIGN KEY (GOL_ID)
      REFERENCES MF_GOL (GOL_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE PEGAWAI
   ADD CONSTRAINT FK_PEGAWAI_MENDUDUKI_MF_JABAT FOREIGN KEY (JABATAN_ID)
      REFERENCES MF_JABATAN (JABATAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE PEGAWAI
   ADD CONSTRAINT FK_PEGAWAI_TERMASUK__MF_CLASS FOREIGN KEY (CLASS_ID)
      REFERENCES MF_CLASS (CLASS_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE PEGAWAI
   ADD CONSTRAINT FK_PEGAWAI_UNTUK_STA_MF_TUNJA FOREIGN KEY (TUNJANGAN_ID)
      REFERENCES MF_TUNJANGAN (TUNJANGAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE PEG_MUTASI_UNIT
   ADD CONSTRAINT FK_PEG_MUTA_MENCATAT__LOG_TRAN FOREIGN KEY (TRAKSAKSI_ID)
      REFERENCES LOG_TRANSAKSI (TRAKSAKSI_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE PEG_MUTASI_UNIT
   ADD CONSTRAINT FK_PEG_MUTA_USER_PIND_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE PERUBAHAN_JABATAN
   ADD CONSTRAINT FK_PERUBAHA_MERUBAH_J_MF_JABAT FOREIGN KEY (JABATAN_ID)
      REFERENCES MF_JABATAN (JABATAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE SARAN
   ADD CONSTRAINT FK_SARAN_MENYAMPAI_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE SKP_PEGAWAI
   ADD CONSTRAINT FK_SKP_PEGA_DILAKSANA_MF_JABAT FOREIGN KEY (JABATAN_ID)
      REFERENCES MF_JABATAN (JABATAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE SKP_PEGAWAI
   ADD CONSTRAINT FK_SKP_PEGA_TERKAIT_O_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE SKP_PEGAWAI_HEAD
   ADD CONSTRAINT FK_SKP_PEGA_BAWAHAN_U_SKP_PEGA FOREIGN KEY (GUID_SKP_PEG)
      REFERENCES SKP_PEGAWAI (GUID_SKP_PEG)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE SKP_PEGAWAI_HEAD
   ADD CONSTRAINT FK_SKP_PEGA_GOL_PEGAW_MF_GOL FOREIGN KEY (GOL_ID)
      REFERENCES MF_GOL (GOL_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE SKP_PEGAWAI_HEAD
   ADD CONSTRAINT FK_SKP_PEGA_JABATAN_P_MF_JABAT FOREIGN KEY (JABATAN_ID)
      REFERENCES MF_JABATAN (JABATAN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE SKP_PEGAWAI_HEAD
   ADD CONSTRAINT FK_SKP_PEGA_USER_HEAD_PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE SPRIN_HEADER
   ADD CONSTRAINT FK_SPRIN_HE_BERTIPE_MF_TYPE_ FOREIGN KEY (TYPE_SPRIN_ID)
      REFERENCES MF_TYPE_SPRIN (TYPE_SPRIN_ID)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

ALTER TABLE USER_ACCOUNT
   ADD CONSTRAINT FK_USER_ACC_DIMILIKI__PEGAWAI FOREIGN KEY (NIP)
      REFERENCES PEGAWAI (NIP)
      ON UPDATE RESTRICT
      ON DELETE RESTRICT;

SET FOREIGN_KEY_CHECKS = 1;

SELECT COUNT(*) AS jumlah_tabel 
FROM information_schema.tables 
WHERE table_schema = 'basarnas_db';

-- =============================================================
-- INSERT DATA DUMMY UNTUK SEMUA TABEL
-- =============================================================

-- Nonaktifkan foreign key check sementara agar bisa insert dengan urutan bebas
SET FOREIGN_KEY_CHECKS = 0;



-- Aktifkan kembali foreign key check
SET FOREIGN_KEY_CHECKS = 1;

