/* MariaDB-compatible fixed script generated from basarnas_db_3.sql */
SET FOREIGN_KEY_CHECKS = 0;

/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     14/04/2026 13:43:17                          */
/*==============================================================*/


drop table if exists ABSENSI;

drop table if exists ABSENSI_BACKUP;

drop table if exists ABSENSI_TEMP;

drop table if exists BUKU_HARIAN_HEAD;

drop table if exists DINAS_LUAR;

drop table if exists DRH;

drop table if exists HAK_AKSES_FORM;

drop table if exists HAK_AKSES_TYPE_SPRIN;

drop table if exists KALENDER;

drop table if exists LEMBUR;

drop table if exists LOG_ACTIVITIY;

drop table if exists LOG_ACTIVITIY_BACKUP;

drop table if exists LOG_TRANSAKSI;

drop table if exists LOG_TRANSAKSI_BACKUP;

drop table if exists MEDIA_INFORMASI;

drop table if exists MF_CLASS;

drop table if exists MF_CONFIG;

drop table if exists MF_EMAIL_SEND;

drop table if exists MF_ESELON;

drop table if exists MF_FIELD_CARI;

drop table if exists MF_FORM;

drop table if exists MF_FORM_NEW;

drop table if exists MF_GOL;

drop table if exists MF_GROUP_JABATAN;

drop table if exists MF_HOST_NAME_FP;

drop table if exists MF_JABATAN;

drop table if exists MF_JABATAN_KEGIATAN;

drop table if exists MF_JAM_KERJA;

drop table if exists MF_JOBLIST;

drop table if exists MF_KLASIFIKASI_SURAT;

drop table if exists MF_LOAD_FINGER;

drop table if exists MF_ORGZ_SIAGA;

drop table if exists MF_POT;

drop table if exists MF_POTONGAN;

drop table if exists MF_PRIORITY_TRANSAKSI;

drop table if exists MF_SATUAN;

drop table if exists MF_SHIFT;

drop table if exists MF_STATUS;

drop table if exists MF_SU;

drop table if exists MF_TIM_SIAGA;

drop table if exists MF_TIM_SIAGA_ANGGOTA;

drop table if exists MF_TR;

drop table if exists MF_TUNJANGAN;

drop table if exists MF_TYPE_SPRIN;

drop table if exists MF_UNIT_KERJA;

drop table if exists MF_UNSUR_KEGIATAN;

drop table if exists MF_SUB_GROUP_JABATAN;

drop table if exists MONITORING_APP;

drop table if exists OTORISASI;

drop table if exists OTORISASI_HISTORY;

drop table if exists PEGAWAI;

drop table if exists PEG_MUTASI_UNIT;

drop table if exists PERUBAHAN_JABATAN;

drop table if exists SARAN;

drop table if exists SKP_PEGAWAI;

drop table if exists SKP_PEGAWAI_HEAD;

drop table if exists SPRIN_HEADER;

drop table if exists TIME_RECORDER;

drop table if exists USER_ACCOUNT;

/*==============================================================*/
/* Table: ABSENSI                                               */
/*==============================================================*/
create table ABSENSI 
(
   ABSENSI_ID           integer                        not null,
   POTONGAN_ID          integer                        not null,
   TGL_KERJA            timestamp                      not null,
   ABSENSI_BACKUP_ID    integer                        not null,
   ABSENSI_TEMP_ID      integer                        not null,
   FINGER_ID            integer                        not null,
   TGL_JAM_IN           timestamp                      null,
   TGL_JAM_OUT          timestamp                      null,
   KET_IN               varchar(850)                   null,
   TRANSAKSI_IN         char(50)                       null,
   UPDATE_IN_BY         varchar(50)                    null,
   UPDATE_IN_DATE       timestamp                      null,
   KET_OUT              varchar(850)                   null,
   TRANSAKSI_OUT        varchar(50)                    null,
   UPDATE_OUT_BY        varchar(50)                    null,
   UPDATE_OUT_DATE      timestamp                      null,
   TINGKAT_TLM          varchar(50)                    null,
   TOTAL_TLM            float                          null,
   TOTAL_PSW            float                          null,
   TINGKAT_PSW          varchar(50)                    null,
   IS_INVALID           varchar(1)                     null,
   IS_OUTVALID          varchar(1)                     null,
   AWAL_TLM             float                          null,
   PERSEN_POT_TLM       float                          null,
   PERSEN_POT_PSW       float                          null,
   TGL_JAM_BAKU_IN      timestamp                      null,
   TGL_JAM_BAKU_OUT     timestamp                      null,
   TRAKSAKSI_ID_FROM    varchar(250)                   null,
   PENDUKUNG_IN         varchar(50)                    null,
   PENDUKUNG_OUT        varchar(50)                    null,
   HISTORY_TRANSAKSI_IN varchar(450)                   null,
   HISTORY_TRANSAKSI_OUT varchar(450)                   null,
   STATUS_UM            integer                        null,
   constraint PK_ABSENSI primary key (ABSENSI_ID)
);

/*==============================================================*/
/* Index: ABSENSI_PK                                            */
/*==============================================================*/
create unique index ABSENSI_PK on ABSENSI (
ABSENSI_ID ASC
);

/*==============================================================*/
/* Index: MENJADI_SUMBER_DATA_FK                                */
/*==============================================================*/
create index MENJADI_SUMBER_DATA_FK on ABSENSI (
FINGER_ID ASC
);

/*==============================================================*/
/* Index: TERJADI_PADA_TANGGAL_FK                               */
/*==============================================================*/
create index TERJADI_PADA_TANGGAL_FK on ABSENSI (
TGL_KERJA ASC
);

/*==============================================================*/
/* Index: DITERAPKAN_PADA_FK                                    */
/*==============================================================*/
create index DITERAPKAN_PADA_FK on ABSENSI (
POTONGAN_ID ASC
);

/*==============================================================*/
/* Index: DATA_BACKUP_ABSENSI_FK                                */
/*==============================================================*/
create index DATA_BACKUP_ABSENSI_FK on ABSENSI (
ABSENSI_BACKUP_ID ASC
);

/*==============================================================*/
/* Index: DATA_TEMP_ABSENSI_FK                                  */
/*==============================================================*/
create index DATA_TEMP_ABSENSI_FK on ABSENSI (
ABSENSI_TEMP_ID ASC
);

/*==============================================================*/
/* Table: ABSENSI_BACKUP                                        */
/*==============================================================*/
create table ABSENSI_BACKUP 
(
   ABSENSI_BACKUP_ID    integer                        not null,
   ABSENSI_ID           integer                        null,
   TGL_JAM_IN           timestamp                      null,
   TGL_JAM_OUT          timestamp                      null,
   KET_IN               varchar(850)                   null,
   TRANSAKSI_IN         char(50)                       null,
   UPDATE_IN_BY         varchar(50)                    null,
   UPDATE_IN_DATE       timestamp                      null,
   KET_OUT              varchar(850)                   null,
   TRANSAKSI_OUT        varchar(50)                    null,
   UPDATE_OUT_BY        varchar(50)                    null,
   UPDATE_OUT_DATE      timestamp                      null,
   TINGKAT_TLM          varchar(50)                    null,
   TOTAL_TLM            float                          null,
   TOTAL_PSW            float                          null,
   TINGKAT_PSW          varchar(50)                    null,
   IS_INVALID           varchar(1)                     null,
   IS_OUTVALID          varchar(1)                     null,
   AWAL_TLM             float                          null,
   PERSEN_POT_TLM       float                          null,
   PERSEN_POT_PSW       float                          null,
   TGL_JAM_BAKU_IN      timestamp                      null,
   TGL_JAM_BAKU_OUT     timestamp                      null,
   TRAKSAKSI_ID_FROM    varchar(250)                   null,
   PENDUKUNG_IN         varchar(50)                    null,
   PENDUKUNG_OUT        varchar(50)                    null,
   HISTORY_TRANSAKSI_IN varchar(450)                   null,
   HISTORY_TRANSAKSI_OUT varchar(450)                   null,
   STATUS_UM            integer                        null,
   constraint PK_ABSENSI_BACKUP primary key (ABSENSI_BACKUP_ID)
);

/*==============================================================*/
/* Index: ABSENSI_BACKUP_PK                                     */
/*==============================================================*/
create unique index ABSENSI_BACKUP_PK on ABSENSI_BACKUP (
ABSENSI_BACKUP_ID ASC
);

/*==============================================================*/
/* Index: DATA_BACKUP_ABSENSI2_FK                               */
/*==============================================================*/
create index DATA_BACKUP_ABSENSI2_FK on ABSENSI_BACKUP (
ABSENSI_ID ASC
);

/*==============================================================*/
/* Table: ABSENSI_TEMP                                          */
/*==============================================================*/
create table ABSENSI_TEMP 
(
   ABSENSI_TEMP_ID      integer                        not null,
   ABSENSI_ID           integer                        null,
   TGL_JAM_IN           timestamp                      null,
   TGL_JAM_OUT          timestamp                      null,
   KET_IN               varchar(850)                   null,
   TRANSAKSI_IN         char(50)                       null,
   UPDATE_IN_BY         varchar(50)                    null,
   UPDATE_IN_DATE       timestamp                      null,
   KET_OUT              varchar(850)                   null,
   TRANSAKSI_OUT        varchar(50)                    null,
   UPDATE_OUT_BY        varchar(50)                    null,
   UPDATE_OUT_DATE      timestamp                      null,
   TINGKAT_TLM          varchar(50)                    null,
   TOTAL_TLM            float                          null,
   TOTAL_PSW            float                          null,
   TINGKAT_PSW          varchar(50)                    null,
   IS_INVALID           varchar(1)                     null,
   IS_OUTVALID          varchar(1)                     null,
   AWAL_TLM             float                          null,
   PERSEN_POT_TLM       float                          null,
   PERSEN_POT_PSW       float                          null,
   TGL_JAM_BAKU_IN      timestamp                      null,
   TGL_JAM_BAKU_OUT     timestamp                      null,
   TRAKSAKSI_ID_FROM    varchar(250)                   null,
   PENDUKUNG_IN         varchar(50)                    null,
   PENDUKUNG_OUT        varchar(50)                    null,
   HISTORY_TRANSAKSI_IN varchar(450)                   null,
   HISTORY_TRANSAKSI_OUT varchar(450)                   null,
   STATUS_UM            integer                        null,
   constraint PK_ABSENSI_TEMP primary key (ABSENSI_TEMP_ID)
);

/*==============================================================*/
/* Index: ABSENSI_TEMP_PK                                       */
/*==============================================================*/
create unique index ABSENSI_TEMP_PK on ABSENSI_TEMP (
ABSENSI_TEMP_ID ASC
);

/*==============================================================*/
/* Index: DATA_TEMP_ABSENSI2_FK                                 */
/*==============================================================*/
create index DATA_TEMP_ABSENSI2_FK on ABSENSI_TEMP (
ABSENSI_ID ASC
);

/*==============================================================*/
/* Table: BUKU_HARIAN_HEAD                                      */
/*==============================================================*/
create table BUKU_HARIAN_HEAD 
(
   GUID                 varchar(100)                   not null,
   JABATAN_ID           integer                        not null,
   NIP                  varchar(50)                    not null,
   ITEM_ID              varchar(50)                    not null,
   GUID_SKP_PEG         varchar(100)                   not null,
   DESKRIPSI            varchar(350)                   null,
   AK                   float                          null,
   QTY                  float                          null,
   GOL                  varchar(10)                    null,
   GOL_PARENT           varchar(10)                    null,
   BIAYA                float                          null,
   UNSUR                varchar(50)                    null,
   TGL_MULAI            date                           null,
   SATUAN_QTY           varchar(50)                    null,
   KETERANGAN           varchar(350)                   null,
   UPDATE_DATE          timestamp                      null,
   CREATE_DATE          timestamp                      null,
   NIP_PARENT           varchar(50)                    null,
   JABATAN_ID_PARENT    integer                        null,
   STATUS               integer                        null,
   KETERANGAN_PENGAJUAN varchar(150)                   null,
   constraint PK_BUKU_HARIAN_HEAD primary key (GUID)
);

/*==============================================================*/
/* Index: BUKU_HARIAN_HEAD_PK                                   */
/*==============================================================*/
create unique index BUKU_HARIAN_HEAD_PK on BUKU_HARIAN_HEAD (
GUID ASC
);

/*==============================================================*/
/* Index: DIBUAT_OLEH_FK                                        */
/*==============================================================*/
create index DIBUAT_OLEH_FK on BUKU_HARIAN_HEAD (
NIP ASC
);

/*==============================================================*/
/* Index: TERKAIT_JABATAN_FK                                    */
/*==============================================================*/
create index TERKAIT_JABATAN_FK on BUKU_HARIAN_HEAD (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: TERKAIT_JABATAN_KEGIATAN_FK                           */
/*==============================================================*/
create index TERKAIT_JABATAN_KEGIATAN_FK on BUKU_HARIAN_HEAD (
ITEM_ID ASC
);

/*==============================================================*/
/* Index: TERKAIT_DENGAN_FK                                     */
/*==============================================================*/
create index TERKAIT_DENGAN_FK on BUKU_HARIAN_HEAD (
GUID_SKP_PEG ASC
);

/*==============================================================*/
/* Table: DINAS_LUAR                                            */
/*==============================================================*/
create table DINAS_LUAR 
(
   DINAS_TRANSAKSI_ID   varchar(50)                    not null,
   GUID_SPRIN           varchar(50)                    not null,
   NIP                  varchar(50)                    not null,
   TGL_AWAL_DINAS_LUAR  timestamp                      null,
   TGL_AKHIR_DINAS_LUAR timestamp                      null,
   KETERANGAN_DINAS_LUAR varchar(450)                   null,
   PENEMPATAN_DINAS_LUAR varchar(350)                   null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   TRANSAKSI            varchar(50)                    null,
   PENDUKUNG            varchar(50)                    null,
   NO_SURAT             varchar(250)                   null,
   STATUS_UM            integer                        null,
   JENIS                varchar(10)                    null,
   TGL_AWAL_SURAT       date                           null,
   TGL_AKHIR_SURAT      date                           null,
   NAMA_FILE            varchar(100)                   null,
   TGL_EMAIL            timestamp                      null,
   TIPE                 integer                        null,
   constraint PK_DINAS_LUAR primary key (DINAS_TRANSAKSI_ID)
);

/*==============================================================*/
/* Index: DINAS_LUAR_PK                                         */
/*==============================================================*/
create unique index DINAS_LUAR_PK on DINAS_LUAR (
DINAS_TRANSAKSI_ID ASC
);

/*==============================================================*/
/* Index: BERDASARKAN_SPRIN_FK                                  */
/*==============================================================*/
create index BERDASARKAN_SPRIN_FK on DINAS_LUAR (
GUID_SPRIN ASC
);

/*==============================================================*/
/* Index: MELAKUKAN_FK                                          */
/*==============================================================*/
create index MELAKUKAN_FK on DINAS_LUAR (
NIP ASC
);

/*==============================================================*/
/* Table: DRH                                                   */
/*==============================================================*/
create table DRH 
(
   NIP                  varchar(50)                    not null,
   JABATAN_ID           integer                        not null,
   TRAKSAKSI_ID         integer                        not null,
   GUID_TRANSAKSI       varchar(50)                    null,
   TGL_MULAI            date                           null,
   NO_SK                varchar(150)                   null
);

/*==============================================================*/
/* Index: JABATAN_DRH_FK                                        */
/*==============================================================*/
create index JABATAN_DRH_FK on DRH (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: MEREKAM_DRH_FK                                        */
/*==============================================================*/
create index MEREKAM_DRH_FK on DRH (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Index: PEGAWAI_DRH_FK                                        */
/*==============================================================*/
create index PEGAWAI_DRH_FK on DRH (
NIP ASC
);

/*==============================================================*/
/* Table: HAK_AKSES_FORM                                        */
/*==============================================================*/
create table HAK_AKSES_FORM 
(
   FORM_ID              varchar(50)                    not null,
   NIP                  varchar(50)                    not null,
   IS_AKSES             varchar(5)                     null,
   TYPE_AKSES           varchar(5)                     null,
   MODUL                varchar(50)                    null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null
);

/*==============================================================*/
/* Index: DIBERIKAN_KEPADA_FK                                   */
/*==============================================================*/
create index DIBERIKAN_KEPADA_FK on HAK_AKSES_FORM (
NIP ASC
);

/*==============================================================*/
/* Index: UNTUK_FORM_FK                                         */
/*==============================================================*/
create index UNTUK_FORM_FK on HAK_AKSES_FORM (
FORM_ID ASC
);

/*==============================================================*/
/* Table: HAK_AKSES_TYPE_SPRIN                                  */
/*==============================================================*/
create table HAK_AKSES_TYPE_SPRIN 
(
   TYPE_SPRIN_ID        char(20)                       not null,
   NIP                  varchar(50)                    not null,
   TYPE_AKSES           char(10)                       null,
   UPDATE_BY            char(10)                       null,
   UPDATE_DATE          char(10)                       null
);

/*==============================================================*/
/* Index: USER_SPRIN_FK                                         */
/*==============================================================*/
create index USER_SPRIN_FK on HAK_AKSES_TYPE_SPRIN (
NIP ASC
);

/*==============================================================*/
/* Index: AKSES_SPRIN_FK                                        */
/*==============================================================*/
create index AKSES_SPRIN_FK on HAK_AKSES_TYPE_SPRIN (
TYPE_SPRIN_ID ASC
);

/*==============================================================*/
/* Table: KALENDER                                              */
/*==============================================================*/
create table KALENDER 
(
   TGL_KERJA            timestamp                      not null,
   IS_LIBUR             varchar(1)                     null,
   KET                  varchar(50)                    null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   constraint PK_KALENDER primary key (TGL_KERJA)
);

/*==============================================================*/
/* Index: KALENDER_PK                                           */
/*==============================================================*/
create unique index KALENDER_PK on KALENDER (
TGL_KERJA ASC
);

/*==============================================================*/
/* Table: LEMBUR                                                */
/*==============================================================*/
create table LEMBUR 
(
   NIP                  varchar(50)                    null,
   TGL_KERJA            timestamp                      null,
   JAM_IN               timestamp                      null,
   JAM_OUT              timestamp                      null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   KETERANGAN           varchar(50)                    null,
   NO_SURAT             varchar(250)                   null,
   JAM_BAKU_IN          timestamp                      null,
   JAM_BAKU_OUT         timestamp                      null
);

/*==============================================================*/
/* Index: TERJADI_TANGGAL_LEMBUR_FK                             */
/*==============================================================*/
create index TERJADI_TANGGAL_LEMBUR_FK on LEMBUR (
TGL_KERJA ASC
);

/*==============================================================*/
/* Index: DILAKUKAN_LEMBUR_FK                                   */
/*==============================================================*/
create index DILAKUKAN_LEMBUR_FK on LEMBUR (
NIP ASC
);

/*==============================================================*/
/* Table: LOG_ACTIVITIY                                         */
/*==============================================================*/
create table LOG_ACTIVITIY 
(
   GUID_LOG             varchar(50)                    not null,
   TRAKSAKSI_ID         integer                        not null,
   UNIT_KERJA_ID        integer                        not null,
   GUID_LOG_BACKUP      varchar(50)                    not null,
   GUID_TIM             varchar(50)                    not null,
   STATUS_ID            integer                        not null,
   NIP                  varchar(50)                    not null,
   TRX                  varchar(50)                    null,
   ACTIVITY             varchar(50)                    null,
   ACTIVITY_DATE        date                           null,
   NOTE                 varchar(150)                   null,
   TEMPAT               varchar(150)                   null,
   PERIHAL              varchar(150)                   null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   FUNGSIONAL           varchar(50)                    null,
   TGL_CLOSING          date                           null,
   SHIFT_1              integer                        null,
   SHIFT_2              integer                        null,
   PENGGANTI            integer                        null,
   STATUS_TRX           varchar(50)                    null,
   KET_UPDATE           varchar(250)                   null,
   NIP_PENGGANTI        varchar(50)                    null,
   BIAYA                float                          null,
   QTY                  float                          null,
   SATUAN_QTY           varchar(50)                    null,
   SHIFT                varchar(5)                     null,
   TRANSAKSI_FORM       varchar(50)                    null,
   TGL_JAM_IN           timestamp                      null,
   TGL_JAM_OUT          timestamp                      null,
   TGL_JAM_BAKU_IN      timestamp                      null,
   TGL_JAM_BAKU_OUT     timestamp                      null,
   constraint PK_LOG_ACTIVITIY primary key (GUID_LOG)
);

/*==============================================================*/
/* Index: LOG_ACTIVITIY_PK                                      */
/*==============================================================*/
create unique index LOG_ACTIVITIY_PK on LOG_ACTIVITIY (
GUID_LOG ASC
);

/*==============================================================*/
/* Index: DILAKUKAN_OLEH_USER_FK                                */
/*==============================================================*/
create index DILAKUKAN_OLEH_USER_FK on LOG_ACTIVITIY (
NIP ASC
);

/*==============================================================*/
/* Index: MEMILIKI_STATUS_FK                                    */
/*==============================================================*/
create index MEMILIKI_STATUS_FK on LOG_ACTIVITIY (
STATUS_ID ASC
);

/*==============================================================*/
/* Index: DILAKUKAN_TIM_FK                                      */
/*==============================================================*/
create index DILAKUKAN_TIM_FK on LOG_ACTIVITIY (
GUID_TIM ASC
);

/*==============================================================*/
/* Index: UNIT_MELAKUKAN_FK                                     */
/*==============================================================*/
create index UNIT_MELAKUKAN_FK on LOG_ACTIVITIY (
UNIT_KERJA_ID ASC
);

/*==============================================================*/
/* Index: TRANSAKSI_TEREKAM_FK                                  */
/*==============================================================*/
create index TRANSAKSI_TEREKAM_FK on LOG_ACTIVITIY (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Index: MEMBACKUP_LOG_ACTIVITIY_FK                            */
/*==============================================================*/
create index MEMBACKUP_LOG_ACTIVITIY_FK on LOG_ACTIVITIY (
GUID_LOG_BACKUP ASC
);

/*==============================================================*/
/* Table: LOG_ACTIVITIY_BACKUP                                  */
/*==============================================================*/
create table LOG_ACTIVITIY_BACKUP 
(
   GUID_LOG_BACKUP      varchar(50)                    not null,
   GUID_LOG             varchar(50)                    null,
   TRX                  varchar(50)                    null,
   ACTIVITY             varchar(50)                    null,
   ACTIVITY_DATE        date                           null,
   NOTE                 varchar(150)                   null,
   TEMPAT               varchar(150)                   null,
   PERIHAL              varchar(150)                   null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   FUNGSIONAL           varchar(50)                    null,
   TGL_CLOSING          date                           null,
   SHIFT_1              integer                        null,
   SHIFT_2              integer                        null,
   PENGGANTI            integer                        null,
   STATUS_TRX           varchar(50)                    null,
   KET_UPDATE           varchar(250)                   null,
   NIP_PENGGANTI        varchar(50)                    null,
   BIAYA                float                          null,
   QTY                  float                          null,
   SATUAN_QTY           varchar(50)                    null,
   SHIFT                varchar(5)                     null,
   TRANSAKSI_FORM       varchar(50)                    null,
   TGL_JAM_IN           timestamp                      null,
   TGL_JAM_OUT          timestamp                      null,
   TGL_JAM_BAKU_IN      timestamp                      null,
   TGL_JAM_BAKU_OUT     timestamp                      null,
   constraint PK_LOG_ACTIVITIY_BACKUP primary key (GUID_LOG_BACKUP)
);

/*==============================================================*/
/* Index: LOG_ACTIVITIY_BACKUP_PK                               */
/*==============================================================*/
create unique index LOG_ACTIVITIY_BACKUP_PK on LOG_ACTIVITIY_BACKUP (
GUID_LOG_BACKUP ASC
);

/*==============================================================*/
/* Index: MEMBACKUP_LOG_ACTIVITIY2_FK                           */
/*==============================================================*/
create index MEMBACKUP_LOG_ACTIVITIY2_FK on LOG_ACTIVITIY_BACKUP (
GUID_LOG ASC
);

/*==============================================================*/
/* Table: LOG_TRANSAKSI                                         */
/*==============================================================*/
create table LOG_TRANSAKSI 
(
   TRAKSAKSI_ID         integer                        not null,
   NIP                  varchar(50)                    not null,
   TRAKSAKSI_BACKUP_ID  integer                        not null,
   GUID_SKP_PEG         varchar(100)                   null,
   TRANSAKSI            varchar(50)                    null,
   ACTIVITY             varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   constraint PK_LOG_TRANSAKSI primary key (TRAKSAKSI_ID)
);

/*==============================================================*/
/* Index: LOG_TRANSAKSI_PK                                      */
/*==============================================================*/
create unique index LOG_TRANSAKSI_PK on LOG_TRANSAKSI (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Index: TRANSAKSI_DILAKUKAN_OLEH_FK                           */
/*==============================================================*/
create index TRANSAKSI_DILAKUKAN_OLEH_FK on LOG_TRANSAKSI (
NIP ASC
);

/*==============================================================*/
/* Index: DATA_BACKUP_TRANSAKSI_FK                              */
/*==============================================================*/
create index DATA_BACKUP_TRANSAKSI_FK on LOG_TRANSAKSI (
TRAKSAKSI_BACKUP_ID ASC
);

/*==============================================================*/
/* Table: LOG_TRANSAKSI_BACKUP                                  */
/*==============================================================*/
create table LOG_TRANSAKSI_BACKUP 
(
   TRAKSAKSI_BACKUP_ID  integer                        not null,
   TRAKSAKSI_ID         integer                        null,
   GUID_SKP_PEG         varchar(100)                   null,
   TRANSAKSI            varchar(50)                    null,
   ACTIVITY             varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   constraint PK_LOG_TRANSAKSI_BACKUP primary key (TRAKSAKSI_BACKUP_ID)
);

/*==============================================================*/
/* Index: LOG_TRANSAKSI_BACKUP_PK                               */
/*==============================================================*/
create unique index LOG_TRANSAKSI_BACKUP_PK on LOG_TRANSAKSI_BACKUP (
TRAKSAKSI_BACKUP_ID ASC
);

/*==============================================================*/
/* Index: DATA_BACKUP_TRANSAKSI2_FK                             */
/*==============================================================*/
create index DATA_BACKUP_TRANSAKSI2_FK on LOG_TRANSAKSI_BACKUP (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MEDIA_INFORMASI                                       */
/*==============================================================*/
create table MEDIA_INFORMASI 
(
   MED_INFOR_ID         integer                        not null,
   UPDATE_DATE          timestamp                      null,
   UPDATE_BY            varchar(50)                    null,
   TRX                  varchar(50)                    null,
   NAMA_FILE            varchar(100)                   null,
   DESKRIPSI            varchar(250)                   null,
   PUBLISH_DATE_START   date                           null,
   PUBLISH_DATE_END     date                           null,
   IS_AKTIF             varchar(5)                     null,
   PIC                  varchar(150)                   null,
   ALAMAT               varchar(250)                   null,
   constraint PK_MEDIA_INFORMASI primary key (MED_INFOR_ID)
);

/*==============================================================*/
/* Index: MEDIA_INFORMASI_PK                                    */
/*==============================================================*/
create unique index MEDIA_INFORMASI_PK on MEDIA_INFORMASI (
MED_INFOR_ID ASC
);

/*==============================================================*/
/* Table: MF_CLASS                                              */
/*==============================================================*/
create table MF_CLASS 
(
   CLASS_ID             integer                        not null,
   TUNJANGAN            float                          null,
   ID                   integer                        null,
   TGL_MULAI            timestamp                      null,
   UPDATE_IN_BY         varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   DOKREFF              varchar(250)                   null,
   constraint PK_MF_CLASS primary key (CLASS_ID)
);

/*==============================================================*/
/* Index: MF_CLASS_PK                                           */
/*==============================================================*/
create unique index MF_CLASS_PK on MF_CLASS (
CLASS_ID ASC
);

/*==============================================================*/
/* Table: MF_CONFIG                                             */
/*==============================================================*/
create table MF_CONFIG 
(
   TRAKSAKSI_ID         integer                        not null,
   CONFIG_NAME          varchar(50)                    null,
   TGL_JAM1             timestamp                      null,
   TGL_JAM2             timestamp                      null
);

/*==============================================================*/
/* Index: MENCATAT_CONFIG_FK                                    */
/*==============================================================*/
create index MENCATAT_CONFIG_FK on MF_CONFIG (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MF_EMAIL_SEND                                         */
/*==============================================================*/
create table MF_EMAIL_SEND 
(
   EMAIL_SEND           varchar(50)                    null,
   PASS_SEND            varchar(50)                    null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   SMTP_SEND            varchar(50)                    null,
   PORT_SENT            varchar(10)                    null
);

/*==============================================================*/
/* Table: MF_ESELON                                             */
/*==============================================================*/
create table MF_ESELON 
(
   ESELON               varchar(50)                    not null,
   URUT_ESELON          integer                        null,
   constraint PK_MF_ESELON primary key (ESELON)
);

/*==============================================================*/
/* Index: MF_ESELON_PK                                          */
/*==============================================================*/
create unique index MF_ESELON_PK on MF_ESELON (
ESELON ASC
);

/*==============================================================*/
/* Table: MF_FIELD_CARI                                         */
/*==============================================================*/
create table MF_FIELD_CARI 
(
   FIELD_ID             varchar(50)                    not null,
   TRAKSAKSI_ID         integer                        not null,
   FIELD_NAME           varchar(50)                    null,
   TYPE_CARI            varchar(50)                    null,
   IS_CMB               varchar(5)                     null,
   NO_URUT              integer                        null,
   APLIKASI             varchar(50)                    null,
   constraint PK_MF_FIELD_CARI primary key (FIELD_ID)
);

/*==============================================================*/
/* Index: MF_FIELD_CARI_PK                                      */
/*==============================================================*/
create unique index MF_FIELD_CARI_PK on MF_FIELD_CARI (
FIELD_ID ASC
);

/*==============================================================*/
/* Index: MENCATAT_PENCARIAN_FK                                 */
/*==============================================================*/
create index MENCATAT_PENCARIAN_FK on MF_FIELD_CARI (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MF_FORM                                               */
/*==============================================================*/
create table MF_FORM 
(
   FORM_ID              varchar(50)                    not null,
   FORM_NAME            varchar(70)                    null,
   FORM_TYPE            varchar(20)                    null,
   NO_URUT              integer                        null,
   BERKAS               varchar(50)                    null,
   PANEL_PAGE           varchar(50)                    null,
   IMG_URL              varchar(50)                    null,
   NO_URUT_PANEL        integer                        null,
   MODUL                varchar(50)                    null,
   PARENT_FORM          varchar(50)                    null,
   MODEL                integer                        null,
   ICON_FA              varchar(50)                    null,
   HIRARKI_LV           integer                        null,
   TRANSAKSI_ID         integer                        null,
   constraint PK_MF_FORM primary key (FORM_ID)
);

/*==============================================================*/
/* Index: MF_FORM_PK                                            */
/*==============================================================*/
create unique index MF_FORM_PK on MF_FORM (
FORM_ID ASC
);

/*==============================================================*/
/* Table: MF_FORM_NEW                                           */
/*==============================================================*/
create table MF_FORM_NEW 
(
   NEW_FORM_ID          varchar(50)                    not null,
   NEW_FORM_NAME        varchar(70)                    null,
   NEW_FORM_TYPE        varchar(20)                    null,
   NO_URUT              integer                        null,
   BERKAS               varchar(50)                    null,
   PANEL_PAGE           varchar(50)                    null,
   IMG_URL              varchar(50)                    null,
   NO_URUT_PANEL        integer                        null,
   MODUL                varchar(50)                    null,
   PARENT_FORM          varchar(50)                    null,
   MODEL                integer                        null,
   ICONFA               varchar(50)                    null,
   HIRARKI_LV           integer                        null,
   constraint PK_MF_FORM_NEW primary key (NEW_FORM_ID)
);

/*==============================================================*/
/* Index: MF_FORM_NEW_PK                                        */
/*==============================================================*/
create unique index MF_FORM_NEW_PK on MF_FORM_NEW (
NEW_FORM_ID ASC
);

/*==============================================================*/
/* Table: MF_GOL                                                */
/*==============================================================*/
create table MF_GOL 
(
   GOL_ID               integer                        not null,
   NAMA_GOL             varchar(50)                    null,
   PANGKAT_GOL          varchar(50)                    null,
   URUT_GOL             integer                        null,
   TRANSAC_ID           integer                        null,
   GROUP_GOL            varchar(2)                     null,
   constraint PK_MF_GOL primary key (GOL_ID)
);

/*==============================================================*/
/* Index: MF_GOL_PK                                             */
/*==============================================================*/
create unique index MF_GOL_PK on MF_GOL (
GOL_ID ASC
);

/*==============================================================*/
/* Table: MF_GROUP_JABATAN                                      */
/*==============================================================*/
create table MF_GROUP_JABATAN 
(
   GROUP_JABATAN_ID     integer                        not null,
   NAMA_GROUP_JABATAN   varchar(50)                    not null,
   constraint PK_MF_GROUP_JABATAN primary key (GROUP_JABATAN_ID)
);

/*==============================================================*/
/* Index: MF_GROUP_JABATAN_PK                                   */
/*==============================================================*/
create unique index MF_GROUP_JABATAN_PK on MF_GROUP_JABATAN (
GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Table: MF_HOST_NAME_FP                                       */
/*==============================================================*/
create table MF_HOST_NAME_FP 
(
   UNIT_KERJA_ID        integer                        not null,
   HOST_NAME_FP         varchar(50)                    null
);

/*==============================================================*/
/* Index: HOST_DARI_UNIT_FK                                     */
/*==============================================================*/
create index HOST_DARI_UNIT_FK on MF_HOST_NAME_FP (
UNIT_KERJA_ID ASC
);

/*==============================================================*/
/* Table: MF_JABATAN                                            */
/*==============================================================*/
create table MF_JABATAN 
(
   JABATAN_ID           integer                        not null,
   JABATAN_ID_BARU      integer                        not null,
   GROUP_JABATAN_ID     integer                        not null,
   SUB_GROUP_JABATAN_ID integer                        not null,
   JABATAN_MANAGE       integer                        null,
   JABATAN_ID_OLD       integer                        null,
   NAMA_JABATAN         varchar(100)                   not null,
   URUT_JABATAN         integer                        not null,
   TYPE_JABATAN         varchar(10)                    not null,
   IS_USE               smallint                       not null,
   UPDATE_IN_BY         varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   constraint PK_MF_JABATAN primary key (JABATAN_ID)
);

/*==============================================================*/
/* Index: MF_JABATAN_PK                                         */
/*==============================================================*/
create unique index MF_JABATAN_PK on MF_JABATAN (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: TERMASUK_DALAM_GROUP_FK                               */
/*==============================================================*/
create index TERMASUK_DALAM_GROUP_FK on MF_JABATAN (
GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Index: TERMASUK_DALAM_SUBGROUP_FK                            */
/*==============================================================*/
create index TERMASUK_DALAM_SUBGROUP_FK on MF_JABATAN (
SUB_GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Index: MERUBAH_JABATAN_FK                                    */
/*==============================================================*/
create index MERUBAH_JABATAN_FK on MF_JABATAN (
JABATAN_ID_BARU ASC
);

/*==============================================================*/
/* Table: MF_JABATAN_KEGIATAN                                   */
/*==============================================================*/
create table MF_JABATAN_KEGIATAN 
(
   ITEM_ID              varchar(50)                    not null,
   JABATAN_ID           integer                        not null,
   DESKRIPSI            varchar(500)                   null,
   AK                   float                          null,
   QTY                  float                          null,
   MUTU                 float                          null,
   WAKTU                timestamp                      null,
   BIAYA                float                          null,
   TYPE                 integer                        null,
   UNSUR                varchar(50)                    null,
   SATUAN_QTY           varchar(50)                    null,
   SATUAN_MUTU          varchar(50)                    null,
   SATUAN_WAKTU         varchar(50)                    null,
   constraint PK_MF_JABATAN_KEGIATAN primary key (ITEM_ID)
);

/*==============================================================*/
/* Index: MF_JABATAN_KEGIATAN_PK                                */
/*==============================================================*/
create unique index MF_JABATAN_KEGIATAN_PK on MF_JABATAN_KEGIATAN (
ITEM_ID ASC
);

/*==============================================================*/
/* Index: DIBUAT_UNTUK_FK                                       */
/*==============================================================*/
create index DIBUAT_UNTUK_FK on MF_JABATAN_KEGIATAN (
JABATAN_ID ASC
);

/*==============================================================*/
/* Table: MF_JAM_KERJA                                          */
/*==============================================================*/
create table MF_JAM_KERJA 
(
   JAM_KERJA_ID         integer                        not null,
   STD_JAM_IN           timestamp                      null,
   STD_JAM_OUT          timestamp                      null,
   TGL_MULAI_BERLAKU    timestamp                      null,
   SHIFT                varchar(50)                    null,
   AGENDA               varchar(50)                    null,
   PENGGANTIAN_TLM1     varchar(5)                     null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   SHIFT_KERJA          varchar(2)                     null,
   constraint PK_MF_JAM_KERJA primary key (JAM_KERJA_ID)
);

/*==============================================================*/
/* Index: MF_JAM_KERJA_PK                                       */
/*==============================================================*/
create unique index MF_JAM_KERJA_PK on MF_JAM_KERJA (
JAM_KERJA_ID ASC
);

/*==============================================================*/
/* Table: MF_JOBLIST                                            */
/*==============================================================*/
create table MF_JOBLIST 
(
   GROUP_JABATAN_ID     integer                        not null,
   ITEM_ID              varchar(50)                    not null,
   DESKRIPSI            varchar(500)                   null,
   AK                   float                          null,
   QTY                  float                          null,
   MUTU                 float                          null,
   WAKTU                timestamp                      null,
   BIAYA                float                          null,
   constraint PK_MF_JOBLIST primary key (GROUP_JABATAN_ID, ITEM_ID)
);

/*==============================================================*/
/* Index: MF_JOBLIST_PK                                         */
/*==============================================================*/
create unique index MF_JOBLIST_PK on MF_JOBLIST (
GROUP_JABATAN_ID ASC,
ITEM_ID ASC
);

/*==============================================================*/
/* Index: MEMILIKI_JOB_FK                                       */
/*==============================================================*/
create index MEMILIKI_JOB_FK on MF_JOBLIST (
GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Index: MENGACU_KE_FK                                         */
/*==============================================================*/
create index MENGACU_KE_FK on MF_JOBLIST (
ITEM_ID ASC
);

/*==============================================================*/
/* Table: MF_KLASIFIKASI_SURAT                                  */
/*==============================================================*/
create table MF_KLASIFIKASI_SURAT 
(
   KLASIFIKASI_ID       varchar(5)                     not null,
   TYPE_SPRIN_ID        char(20)                       not null,
   KLASIFIKASI_NAME     varchar(50)                    null,
   constraint PK_MF_KLASIFIKASI_SURAT primary key (KLASIFIKASI_ID)
);

/*==============================================================*/
/* Index: MF_KLASIFIKASI_SURAT_PK                               */
/*==============================================================*/
create unique index MF_KLASIFIKASI_SURAT_PK on MF_KLASIFIKASI_SURAT (
KLASIFIKASI_ID ASC
);

/*==============================================================*/
/* Index: MENGAKLSIFIKASI_SURAT_FK                              */
/*==============================================================*/
create index MENGAKLSIFIKASI_SURAT_FK on MF_KLASIFIKASI_SURAT (
TYPE_SPRIN_ID ASC
);

/*==============================================================*/
/* Table: MF_LOAD_FINGER                                        */
/*==============================================================*/
create table MF_LOAD_FINGER 
(
   TRAKSAKSI_ID         integer                        not null,
   START_FINGER         timestamp                      null,
   END_FINGER           timestamp                      null,
   TGL_MULAI_BERLAKU    date                           null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   SHIFT_KERJA          varchar(2)                     null,
   START_FINGER_OUT     timestamp                      null,
   END_FINGER_OUT       timestamp                      null
);

/*==============================================================*/
/* Index: MENCATAT_FINGER_FK                                    */
/*==============================================================*/
create index MENCATAT_FINGER_FK on MF_LOAD_FINGER (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MF_ORGZ_SIAGA                                         */
/*==============================================================*/
create table MF_ORGZ_SIAGA 
(
   ORGZ_SIAGA_ID        integer                        not null,
   FUNGSIONAL           varchar(50)                    null,
   PARENT_ID            integer                        null,
   URUT_FUNGSIONAL      float                          null,
   DESKRIPSI            varchar(50)                    null,
   INISIAL              varchar(2)                     null,
   FLAG                 varchar(50)                    null,
   constraint PK_MF_ORGZ_SIAGA primary key (ORGZ_SIAGA_ID)
);

/*==============================================================*/
/* Index: MF_ORGZ_SIAGA_PK                                      */
/*==============================================================*/
create unique index MF_ORGZ_SIAGA_PK on MF_ORGZ_SIAGA (
ORGZ_SIAGA_ID ASC
);

/*==============================================================*/
/* Table: MF_POT                                                */
/*==============================================================*/
create table MF_POT 
(
   POTONGAN_ID          integer                        not null,
   KATEGORI             varchar(50)                    null,
   TINGKAT              varchar(50)                    null,
   PERSEN_POT           float                          null,
   TGL_MULAI            timestamp                      null,
   RANGE_AWAL           float                          null,
   RANGE_AKHIR          float                          null,
   NAMA_POT             varchar(50)                    null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   IS_PENDUKUNG         varchar(2)                     null,
   TINDAKAN             varchar(250)                   null,
   DURASI_POT           float                          null,
   SATUAN_DURASI        varchar(10)                    null,
   constraint PK_MF_POT primary key (POTONGAN_ID)
);

/*==============================================================*/
/* Index: MF_POT_PK                                             */
/*==============================================================*/
create unique index MF_POT_PK on MF_POT (
POTONGAN_ID ASC
);

/*==============================================================*/
/* Table: MF_POTONGAN                                           */
/*==============================================================*/
create table MF_POTONGAN 
(
   POT_ID               integer                        not null,
   KATEGORI             varchar(50)                    null,
   TINGKAT              varchar(50)                    null,
   PERSEN_POT           float                          null,
   TGL_MULAI            timestamp                      null,
   RANGE_AWAL           float                          null,
   RANGE_AKHIR          float                          null,
   NAMA_POT             varchar(50)                    null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   IS_PENDUKUNG         varchar(2)                     null,
   constraint PK_MF_POTONGAN primary key (POT_ID)
);

/*==============================================================*/
/* Index: MF_POTONGAN_PK                                        */
/*==============================================================*/
create unique index MF_POTONGAN_PK on MF_POTONGAN (
POT_ID ASC
);

/*==============================================================*/
/* Table: MF_PRIORITY_TRANSAKSI                                 */
/*==============================================================*/
create table MF_PRIORITY_TRANSAKSI 
(
   MODUL                varchar(50)                    null,
   PRIORITY_TRANSAKSI   integer                        null,
   TRANSAKSI            varchar(50)                    null,
   INISIAL_TRANSAKSI    varchar(5)                     null
);

/*==============================================================*/
/* Table: MF_SATUAN                                             */
/*==============================================================*/
create table MF_SATUAN 
(
   SATUAN_ID            integer                        not null,
   ACTIVITY             varchar(50)                    null,
   SATUAN               varchar(50)                    null,
   PARAMETER            varchar(50)                    null,
   URUT_SATUAN          integer                        null,
   constraint PK_MF_SATUAN primary key (SATUAN_ID)
);

/*==============================================================*/
/* Index: MF_SATUAN_PK                                          */
/*==============================================================*/
create unique index MF_SATUAN_PK on MF_SATUAN (
SATUAN_ID ASC
);

/*==============================================================*/
/* Table: MF_SHIFT                                              */
/*==============================================================*/
create table MF_SHIFT 
(
   SHIFT_ID             varchar(10)                    not null,
   TRAKSAKSI_ID         integer                        not null,
   NAMA_SHIFT           varchar(50)                    null,
   JADWAL               varchar(50)                    null,
   START_SHIFT          timestamp                      null,
   END_SHIFT            timestamp                      null,
   TGL_MULAI_BERLAKU    date                           null,
   constraint PK_MF_SHIFT primary key (SHIFT_ID)
);

/*==============================================================*/
/* Index: MF_SHIFT_PK                                           */
/*==============================================================*/
create unique index MF_SHIFT_PK on MF_SHIFT (
SHIFT_ID ASC
);

/*==============================================================*/
/* Index: MENCATAT_SHIFT_FK                                     */
/*==============================================================*/
create index MENCATAT_SHIFT_FK on MF_SHIFT (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MF_STATUS                                             */
/*==============================================================*/
create table MF_STATUS 
(
   STATUS_ID            integer                        not null,
   STATUS               varchar(50)                    null,
   BG_STATUS            varchar(50)                    null,
   ALERT_STATUS         varchar(50)                    null,
   SPAN_STATUS_LOG_JOB  varchar(50)                    null,
   STATUS_LOG_JOB       varchar(50)                    null,
   constraint PK_MF_STATUS primary key (STATUS_ID)
);

/*==============================================================*/
/* Index: MF_STATUS_PK                                          */
/*==============================================================*/
create unique index MF_STATUS_PK on MF_STATUS (
STATUS_ID ASC
);

/*==============================================================*/
/* Table: MF_SU                                                 */
/*==============================================================*/
create table MF_SU 
(
   NIP                  varchar(50)                    not null,
   NAMA                 varchar(50)                    null,
   PASS                 varchar(50)                    null
);

/*==============================================================*/
/* Index: MENYIMPAN_USER_FK                                     */
/*==============================================================*/
create index MENYIMPAN_USER_FK on MF_SU (
NIP ASC
);

/*==============================================================*/
/* Table: MF_TIM_SIAGA                                          */
/*==============================================================*/
create table MF_TIM_SIAGA 
(
   GUID_TIM             varchar(50)                    not null,
   NO_URUT_TIM          integer                        null,
   NAMA_TIM             varchar(50)                    null,
   ID_UNIT_KERJA        varchar(50)                    null,
   BULAN_PERIODE        varchar(2)                     null,
   TAHUN_PERIODE        varchar(4)                     null,
   FUNGSIONAL_TIM       varchar(50)                    null,
   SHIFT                varchar(5)                     null,
   IS_AKTIF             varchar(1)                     null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   constraint PK_MF_TIM_SIAGA primary key (GUID_TIM)
);

/*==============================================================*/
/* Index: MF_TIM_SIAGA_PK                                       */
/*==============================================================*/
create unique index MF_TIM_SIAGA_PK on MF_TIM_SIAGA (
GUID_TIM ASC
);

/*==============================================================*/
/* Table: MF_TIM_SIAGA_ANGGOTA                                  */
/*==============================================================*/
create table MF_TIM_SIAGA_ANGGOTA 
(
   NIP                  varchar(50)                    not null,
   GUID_TIM             varchar(50)                    not null,
   FUNGSIONAL           varchar(50)                    null,
   IS_AKTIF             varchar(1)                     null,
   ID_UNIT_KERJA        varchar(50)                    null,
   NO_URUT              integer                        null,
   BULAN_PERIODE        varchar(2)                     null,
   TAHUN_PERIODE        varchar(4)                     null,
   SHIFT                varchar(5)                     null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null
);

/*==============================================================*/
/* Index: BERANGGOTAKAN_FK                                      */
/*==============================================================*/
create index BERANGGOTAKAN_FK on MF_TIM_SIAGA_ANGGOTA (
GUID_TIM ASC
);

/*==============================================================*/
/* Index: DIISI_OLEH_FK                                         */
/*==============================================================*/
create index DIISI_OLEH_FK on MF_TIM_SIAGA_ANGGOTA (
NIP ASC
);

/*==============================================================*/
/* Table: MF_TR                                                 */
/*==============================================================*/
create table MF_TR 
(
   TRAKSAKSI_ID         integer                        not null,
   JAM_LOAD             timestamp                      null
);

/*==============================================================*/
/* Index: MENCATAT_TR_FK                                        */
/*==============================================================*/
create index MENCATAT_TR_FK on MF_TR (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: MF_TUNJANGAN                                          */
/*==============================================================*/
create table MF_TUNJANGAN 
(
   TUNJANGAN_ID         integer                        not null,
   JENIS_TUNJANGAN      varchar(50)                    null,
   ACTIVITY             varchar(50)                    null,
   NOMINAL              float                          null,
   TGL_MULAI            date                           null,
   HARI_KERJA           integer                        null,
   FUNGSIONAL           varchar(50)                    null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   DOKREFF              varchar(250)                   null,
   STATUS_PEG           integer                        null,
   SHIFT                varchar(5)                     null,
   UNIT_KERJA_ID        varchar(50)                    null,
   constraint PK_MF_TUNJANGAN primary key (TUNJANGAN_ID)
);

/*==============================================================*/
/* Index: MF_TUNJANGAN_PK                                       */
/*==============================================================*/
create unique index MF_TUNJANGAN_PK on MF_TUNJANGAN (
TUNJANGAN_ID ASC
);

/*==============================================================*/
/* Table: MF_TYPE_SPRIN                                         */
/*==============================================================*/
create table MF_TYPE_SPRIN 
(
   TYPE_SPRIN_ID        char(20)                       not null,
   TYPE_SPRIN_NAME      varchar(50)                    null,
   constraint PK_MF_TYPE_SPRIN primary key (TYPE_SPRIN_ID)
);

/*==============================================================*/
/* Index: MF_TYPE_SPRIN_PK                                      */
/*==============================================================*/
create unique index MF_TYPE_SPRIN_PK on MF_TYPE_SPRIN (
TYPE_SPRIN_ID ASC
);

/*==============================================================*/
/* Table: MF_UNIT_KERJA                                         */
/*==============================================================*/
create table MF_UNIT_KERJA 
(
   UNIT_KERJA_ID        integer                        not null,
   NAMA_UNIT_KERJA      varchar(50)                    null,
   URUT_REPORT          integer                        null,
   IS_PUSAT             integer                        null,
   TRANSAC_ID           integer                        null,
   UPDATE_IN_BY         varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   constraint PK_MF_UNIT_KERJA primary key (UNIT_KERJA_ID)
);

/*==============================================================*/
/* Index: MF_UNIT_KERJA_PK                                      */
/*==============================================================*/
create unique index MF_UNIT_KERJA_PK on MF_UNIT_KERJA (
UNIT_KERJA_ID ASC
);

/*==============================================================*/
/* Table: MF_UNSUR_KEGIATAN                                     */
/*==============================================================*/
create table MF_UNSUR_KEGIATAN 
(
   UNSUR_ID             integer                        not null,
   DESKRIPSI_UNSUR      varchar(50)                    null,
   constraint PK_MF_UNSUR_KEGIATAN primary key (UNSUR_ID)
);

/*==============================================================*/
/* Index: MF_UNSUR_KEGIATAN_PK                                  */
/*==============================================================*/
create unique index MF_UNSUR_KEGIATAN_PK on MF_UNSUR_KEGIATAN (
UNSUR_ID ASC
);

/*==============================================================*/
/* Table: MF_SUB_GROUP_JABATAN                                 */
/*==============================================================*/
create table MF_SUB_GROUP_JABATAN 
(
   SUB_GROUP_JABATAN_ID integer                        not null,
   NAMA_SUB_GROUP_JABATAN varchar(150)                   not null,
   constraint PK_MF_SUB_GROUP_JABATAN primary key (SUB_GROUP_JABATAN_ID)
);

/*==============================================================*/
/* Index: MF_SUB_GROUP_JABATAN_PK                              */
/*==============================================================*/
create unique index MF_SUB_GROUP_JABATAN_PK on MF_SUB_GROUP_JABATAN (
SUB_GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Table: MONITORING_APP                                        */
/*==============================================================*/
create table MONITORING_APP 
(
   TRAKSAKSI_ID         integer                        not null,
   APLICATION           varchar(50)                    null,
   USER_NAME            varchar(50)                    null,
   COMPUTER_IP          varchar(50)                    null,
   LOGIN_TIME           timestamp                      null,
   LOGIN_DATE           timestamp                      null,
   IS_ON                varchar(5)                     null
);

/*==============================================================*/
/* Index: MENCATAT_LOG_APP_FK                                   */
/*==============================================================*/
create index MENCATAT_LOG_APP_FK on MONITORING_APP (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: OTORISASI                                             */
/*==============================================================*/
create table OTORISASI 
(
   GUID_OTO             varchar(100)                   not null,
   NIP                  varchar(50)                    null,
   TRX                  varchar(50)                    null,
   LEVEL_OTO            integer                        null,
   JABATAN              varchar(100)                   null,
   ACT                  integer                        null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   PERIHAL              varchar(150)                   null,
   KETERANGAN           varchar(150)                   null,
   BULAN                integer                        null,
   TAHUN                integer                        null,
   TGL_PENGAJUAN        timestamp                      null,
   constraint PK_OTORISASI primary key (GUID_OTO)
);

/*==============================================================*/
/* Index: OTORISASI_PK                                          */
/*==============================================================*/
create unique index OTORISASI_PK on OTORISASI (
GUID_OTO ASC
);

/*==============================================================*/
/* Index: DIAJUKAN_OLEH_FK                                      */
/*==============================================================*/
create index DIAJUKAN_OLEH_FK on OTORISASI (
NIP ASC
);

/*==============================================================*/
/* Table: OTORISASI_HISTORY                                     */
/*==============================================================*/
create table OTORISASI_HISTORY 
(
   OTO_HISTORY_ID       integer                        not null,
   GUID_OTO             varchar(100)                   not null,
   NIP                  varchar(50)                    not null,
   UNIT_KERJA_ID        integer                        not null,
   TRX                  varchar(50)                    null,
   LEVEL_OTO            integer                        null,
   JABATAN              varchar(100)                   null,
   ACT                  integer                        null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   PERIHAL              varchar(150)                   null,
   KETERANGAN           varchar(150)                   null,
   BULAN                integer                        null,
   TAHUN                integer                        null,
   SHIFT_1              integer                        null,
   SHIFT_2              integer                        null,
   REC_DATE             timestamp                      null,
   TGL_PENGAJUAN        timestamp                      null,
   constraint PK_OTORISASI_HISTORY primary key (OTO_HISTORY_ID)
);

/*==============================================================*/
/* Index: OTORISASI_HISTORY_PK                                  */
/*==============================================================*/
create unique index OTORISASI_HISTORY_PK on OTORISASI_HISTORY (
OTO_HISTORY_ID ASC
);

/*==============================================================*/
/* Index: USER_OTORISASI_HISTORY_FK                             */
/*==============================================================*/
create index USER_OTORISASI_HISTORY_FK on OTORISASI_HISTORY (
NIP ASC
);

/*==============================================================*/
/* Index: OTORISASI_HISTORY_UNIT_FK                             */
/*==============================================================*/
create index OTORISASI_HISTORY_UNIT_FK on OTORISASI_HISTORY (
UNIT_KERJA_ID ASC
);

/*==============================================================*/
/* Index: OTORISASI_SEBELUMNYA_FK                               */
/*==============================================================*/
create index OTORISASI_SEBELUMNYA_FK on OTORISASI_HISTORY (
GUID_OTO ASC
);

/*==============================================================*/
/* Table: PEGAWAI                                               */
/*==============================================================*/
create table PEGAWAI 
(
   NIP                  varchar(50)                    not null,
   ABSENSI_ID           integer                        not null,
   ESELON               varchar(50)                    not null,
   TUNJANGAN_ID         integer                        not null,
   CLASS_ID             integer                        not null,
   UNIT_KERJA_ID        integer                        not null,
   JABATAN_ID           integer                        not null,
   GOL_ID               integer                        not null,
   NIP_MANAGER          varchar(50)                    null,
   NAMA                 varchar(70)                    not null,
   NO_TELP              varchar(50)                    not null,
   PANGKAT              varchar(50)                    null,
   JABATAN              varchar(50)                    null,
   MAIL                 varchar(100)                   null,
   PASS                 varchar(50)                    not null,
   ALAMAT               varchar(50)                    null,
   JENIS_KEL            varchar(15)                    null,
   TGL_LAHIR            timestamp                      null,
   KELURAHAN            varchar(50)                    null,
   KECAMATAN            varchar(50)                    null,
   KOTA                 varchar(50)                    null,
   TEMPAT_LAHIR         varchar(100)                   null,
   AGAMA                varchar(100)                   null,
   STATUS_PERKAWINAN    smallint                       null,
   NO_KTP               varchar(50)                    null,
   NO_NPWP              varchar(50)                    null,
   HOBI                 varchar(150)                   null,
   IS_VIP               smallint                       null,
   TMT_PANGKAT          timestamp                      null,
   IS_KELUAR            smallint                       null,
   TGL_KELUAR           timestamp                      null,
   ALASAN_KELUAR        varchar(250)                   null,
   TGL_MASUK            timestamp                      null,
   TMT_PNS              date                           null,
   TMT_CPNS             date                           null,
   GOL_RECRUIT          varchar(10)                    null,
   STATUS_PEG           smallint                       null,
   TMT_CLASS            date                           null,
   TMT_JABATAN          date                           null,
   UPDATE_IN_BY         varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   constraint PK_PEGAWAI primary key (NIP)
);

/*==============================================================*/
/* Index: PEGAWAI_PK                                            */
/*==============================================================*/
create unique index PEGAWAI_PK on PEGAWAI (
NIP ASC
);

/*==============================================================*/
/* Index: MENDUDUKI_JABATAN_FK                                  */
/*==============================================================*/
create index MENDUDUKI_JABATAN_FK on PEGAWAI (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: MEMILIKI_GOLONGAN_FK                                  */
/*==============================================================*/
create index MEMILIKI_GOLONGAN_FK on PEGAWAI (
GOL_ID ASC
);

/*==============================================================*/
/* Index: BEKERJA_DI_UNIT_FK                                    */
/*==============================================================*/
create index BEKERJA_DI_UNIT_FK on PEGAWAI (
UNIT_KERJA_ID ASC
);

/*==============================================================*/
/* Index: TERMASUK_KELAS_FK                                     */
/*==============================================================*/
create index TERMASUK_KELAS_FK on PEGAWAI (
CLASS_ID ASC
);

/*==============================================================*/
/* Index: DILAKUKAN_OLEH_FK                                     */
/*==============================================================*/
create index DILAKUKAN_OLEH_FK on PEGAWAI (
ABSENSI_ID ASC
);

/*==============================================================*/
/* Index: MEMILIKI_ESELON_FK                                    */
/*==============================================================*/
create index MEMILIKI_ESELON_FK on PEGAWAI (
ESELON ASC
);

/*==============================================================*/
/* Index: UNTUK_STATUS_TUNJANGAN_FK                             */
/*==============================================================*/
create index UNTUK_STATUS_TUNJANGAN_FK on PEGAWAI (
TUNJANGAN_ID ASC
);

/*==============================================================*/
/* Table: PEG_MUTASI_UNIT                                       */
/*==============================================================*/
create table PEG_MUTASI_UNIT 
(
   TRAKSAKSI_ID         integer                        not null,
   NIP                  varchar(50)                    not null,
   TGL_MUTASI           date                           null,
   UNIT_KERJA           varchar(50)                    null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   NO_SK                varchar(50)                    null,
   KETERANGAN           varchar(250)                   null
);

/*==============================================================*/
/* Index: USER_PINDAH_UNIT_FK                                   */
/*==============================================================*/
create index USER_PINDAH_UNIT_FK on PEG_MUTASI_UNIT (
NIP ASC
);

/*==============================================================*/
/* Index: MENCATAT_MUTASI_UNIT_FK                               */
/*==============================================================*/
create index MENCATAT_MUTASI_UNIT_FK on PEG_MUTASI_UNIT (
TRAKSAKSI_ID ASC
);

/*==============================================================*/
/* Table: PERUBAHAN_JABATAN                                     */
/*==============================================================*/
create table PERUBAHAN_JABATAN 
(
   JABATAN_ID_BARU      integer                        not null,
   JABATAN_ID           integer                        null,
   constraint PK_PERUBAHAN_JABATAN primary key (JABATAN_ID_BARU)
);

/*==============================================================*/
/* Index: PERUBAHAN_JABATAN_PK                                  */
/*==============================================================*/
create unique index PERUBAHAN_JABATAN_PK on PERUBAHAN_JABATAN (
JABATAN_ID_BARU ASC
);

/*==============================================================*/
/* Index: MERUBAH_JABATAN2_FK                                   */
/*==============================================================*/
create index MERUBAH_JABATAN2_FK on PERUBAHAN_JABATAN (
JABATAN_ID ASC
);

/*==============================================================*/
/* Table: SARAN                                                 */
/*==============================================================*/
create table SARAN 
(
   ID_SARAN             integer                        not null,
   NIP                  varchar(50)                    not null,
   SARAN                varchar(350)                   not null,
   INSTANSI             varchar(100)                   not null,
   constraint PK_SARAN primary key (ID_SARAN)
);

/*==============================================================*/
/* Index: SARAN_PK                                              */
/*==============================================================*/
create unique index SARAN_PK on SARAN (
ID_SARAN ASC
);

/*==============================================================*/
/* Index: MENYAMPAIKAN_FK                                       */
/*==============================================================*/
create index MENYAMPAIKAN_FK on SARAN (
NIP ASC
);

/*==============================================================*/
/* Table: SKP_PEGAWAI                                           */
/*==============================================================*/
create table SKP_PEGAWAI 
(
   GUID_SKP_PEG         varchar(100)                   not null,
   NIP                  varchar(50)                    not null,
   JABATAN_ID           integer                        not null,
   DESKRIPSI            varchar(500)                   null,
   AK                   float                          null,
   QTY                  float                          null,
   MUTU                 float                          null,
   WAKTU                timestamp                      null,
   BIAYA                float                          null,
   UNSUR                varchar(50)                    null,
   TYPE                 integer                        null,
   TGL_MULAI            timestamp                      null,
   SATUAN_QTY           varchar(50)                    null,
   SATUAN_MUTU          varchar(50)                    null,
   SATUAN_WAKTU         varchar(50)                    null,
   constraint PK_SKP_PEGAWAI primary key (GUID_SKP_PEG)
);

/*==============================================================*/
/* Index: SKP_PEGAWAI_PK                                        */
/*==============================================================*/
create unique index SKP_PEGAWAI_PK on SKP_PEGAWAI (
GUID_SKP_PEG ASC
);

/*==============================================================*/
/* Index: DILAKSANAKAN_DI_FK                                    */
/*==============================================================*/
create index DILAKSANAKAN_DI_FK on SKP_PEGAWAI (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: TERKAIT_OLEH_FK                                       */
/*==============================================================*/
create index TERKAIT_OLEH_FK on SKP_PEGAWAI (
NIP ASC
);

/*==============================================================*/
/* Table: SKP_PEGAWAI_HEAD                                      */
/*==============================================================*/
create table SKP_PEGAWAI_HEAD 
(
   SKP_PEGAWAI_HEAD_ID  integer                        not null,
   GUID_SKP_PEG         varchar(100)                   not null,
   NIP                  varchar(50)                    not null,
   GOL_ID               integer                        not null,
   JABATAN_ID           integer                        not null,
   TGL_MULAI            timestamp                      null,
   NIP_PARENT           varchar(50)                    null,
   JABATAN_ID_PARENT    varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   TGL_PEMBUATAN        timestamp                      null,
   GOL_PARENT           varchar(10)                    null,
   constraint PK_SKP_PEGAWAI_HEAD primary key (SKP_PEGAWAI_HEAD_ID)
);

/*==============================================================*/
/* Index: SKP_PEGAWAI_HEAD_PK                                   */
/*==============================================================*/
create unique index SKP_PEGAWAI_HEAD_PK on SKP_PEGAWAI_HEAD (
SKP_PEGAWAI_HEAD_ID ASC
);

/*==============================================================*/
/* Index: JABATAN_PEGAWAI_HEAD_FK                               */
/*==============================================================*/
create index JABATAN_PEGAWAI_HEAD_FK on SKP_PEGAWAI_HEAD (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: USER_HEAD_FK                                          */
/*==============================================================*/
create index USER_HEAD_FK on SKP_PEGAWAI_HEAD (
NIP ASC
);

/*==============================================================*/
/* Index: GOL_PEGAWAI_HEAD_FK                                   */
/*==============================================================*/
create index GOL_PEGAWAI_HEAD_FK on SKP_PEGAWAI_HEAD (
GOL_ID ASC
);

/*==============================================================*/
/* Index: BAWAHAN_USER_SKP_FK                                   */
/*==============================================================*/
create index BAWAHAN_USER_SKP_FK on SKP_PEGAWAI_HEAD (
GUID_SKP_PEG ASC
);

/*==============================================================*/
/* Table: SPRIN_HEADER                                          */
/*==============================================================*/
create table SPRIN_HEADER 
(
   GUID_SPRIN           varchar(50)                    not null,
   TYPE_SPRIN_ID        char(20)                       not null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   ROLE_NUMBER          integer                        null,
   ABSENSI_FINGER       varchar(2)                     null,
   TGL_SPRIN            date                           null,
   PERIHAL_SPRIN        varchar(250)                   null,
   MENIMBANG_1          varchar(250)                   null,
   MENIMBANG_2          varchar(250)                   null,
   MENIMBANG_3          varchar(250)                   null,
   DASAR_1              varchar(250)                   null,
   DASAR_2              varchar(250)                   null,
   DASAR_3              varchar(250)                   null,
   UNTUK_1              varchar(250)                   null,
   UNTUK_2              varchar(250)                   null,
   UNTUK_3              varchar(250)                   null,
   UNTUK_4              varchar(250)                   null,
   UNTUK_5              varchar(250)                   null,
   JABATAN_OTO          varchar(100)                   null,
   NIP_OTO              varchar(50)                    null,
   NO_URUT_SPRIN        varchar(5)                     null,
   NO_SISIPAN           varchar(50)                    null,
   NO_SPRIN             varchar(50)                    null,
   TGL_AWAL_SPRIN       date                           null,
   TGL_AKHIR_SPRIN      varchar(50)                    null,
   PENEMPATAN           varchar(150)                   null,
   STATUS_UM            integer                        null,
   constraint PK_SPRIN_HEADER primary key (GUID_SPRIN)
);

/*==============================================================*/
/* Index: SPRIN_HEADER_PK                                       */
/*==============================================================*/
create unique index SPRIN_HEADER_PK on SPRIN_HEADER (
GUID_SPRIN ASC
);

/*==============================================================*/
/* Index: BERTIPE_FK                                            */
/*==============================================================*/
create index BERTIPE_FK on SPRIN_HEADER (
TYPE_SPRIN_ID ASC
);

/*==============================================================*/
/* Table: TIME_RECORDER                                         */
/*==============================================================*/
create table TIME_RECORDER 
(
   FINGER_ID            integer                        not null,
   WAKTU                timestamp                      null,
   STATUS               varchar(3)                     null,
   MESIN                varchar(100)                   null,
   KET                  varchar(50)                    null,
   TRANSAKSI            varchar(50)                    null,
   KET_INJECT           varchar(150)                   null,
   REF_INJECT           varchar(150)                   null,
   TRX                  varchar(50)                    null,
   UPDATE_IN_BY         varchar(50)                    null,
   UPDATE_DATE          timestamp                      null,
   constraint PK_TIME_RECORDER primary key (FINGER_ID)
);

/*==============================================================*/
/* Index: TIME_RECORDER_PK                                      */
/*==============================================================*/
create unique index TIME_RECORDER_PK on TIME_RECORDER (
FINGER_ID ASC
);

/*==============================================================*/
/* Table: USER_ACCOUNT                                          */
/*==============================================================*/
create table USER_ACCOUNT 
(
   NIP                  varchar(50)                    not null,
   INIT_LEVEL           integer                        null,
   MODUL                varchar(50)                    null,
   UPDATE_BY            varchar(50)                    null,
   UPDATE_DATE          timestamp                      null
);

/*==============================================================*/
/* Index: DIMILIKI_OLEH_USER_FK                                 */
/*==============================================================*/
create index DIMILIKI_OLEH_USER_FK on USER_ACCOUNT (
NIP ASC
);

alter table ABSENSI
   add constraint FK_ABSENSI_DATA_BACK_ABSENSI_ foreign key (ABSENSI_BACKUP_ID)
      references ABSENSI_BACKUP (ABSENSI_BACKUP_ID)
      on update restrict
      on delete restrict;

alter table ABSENSI
   add constraint FK_ABSENSI_DATA_TEMP_ABSENSI_ foreign key (ABSENSI_TEMP_ID)
      references ABSENSI_TEMP (ABSENSI_TEMP_ID)
      on update restrict
      on delete restrict;

alter table ABSENSI
   add constraint FK_ABSENSI_DITERAPKA_MF_POT foreign key (POTONGAN_ID)
      references MF_POT (POTONGAN_ID)
      on update restrict
      on delete restrict;

alter table ABSENSI
   add constraint FK_ABSENSI_MENJADI_S_TIME_REC foreign key (FINGER_ID)
      references TIME_RECORDER (FINGER_ID)
      on update restrict
      on delete restrict;

alter table ABSENSI
   add constraint FK_ABSENSI_TERJADI_P_KALENDER foreign key (TGL_KERJA)
      references KALENDER (TGL_KERJA)
      on update restrict
      on delete restrict;

alter table ABSENSI_BACKUP
   add constraint FK_ABSENSI__DATA_BACK_ABSENSI foreign key (ABSENSI_ID)
      references ABSENSI (ABSENSI_ID)
      on update restrict
      on delete restrict;

alter table ABSENSI_TEMP
   add constraint FK_ABSENSI__DATA_TEMP_ABSENSI foreign key (ABSENSI_ID)
      references ABSENSI (ABSENSI_ID)
      on update restrict
      on delete restrict;

alter table BUKU_HARIAN_HEAD
   add constraint FK_BUKU_HAR_DIBUAT_OL_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table BUKU_HARIAN_HEAD
   add constraint FK_BUKU_HAR_TERKAIT_D_SKP_PEGA foreign key (GUID_SKP_PEG)
      references SKP_PEGAWAI (GUID_SKP_PEG)
      on update restrict
      on delete restrict;

alter table BUKU_HARIAN_HEAD
   add constraint FK_BUKU_HAR_TERKAIT_J_MF_JABAT2 foreign key (JABATAN_ID)
      references MF_JABATAN (JABATAN_ID)
      on update restrict
      on delete restrict;

alter table BUKU_HARIAN_HEAD
   add constraint FK_BUKU_HAR_TERKAIT_J_MF_JABAT foreign key (ITEM_ID)
      references MF_JABATAN_KEGIATAN (ITEM_ID)
      on update restrict
      on delete restrict;

alter table DINAS_LUAR
   add constraint FK_DINAS_LU_BERDASARK_SPRIN_HE foreign key (GUID_SPRIN)
      references SPRIN_HEADER (GUID_SPRIN)
      on update restrict
      on delete restrict;

alter table DINAS_LUAR
   add constraint FK_DINAS_LU_MELAKUKAN_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table DRH
   add constraint FK_DRH_JABATAN_D_MF_JABAT foreign key (JABATAN_ID)
      references MF_JABATAN (JABATAN_ID)
      on update restrict
      on delete restrict;

alter table DRH
   add constraint FK_DRH_MEREKAM_D_LOG_TRAN foreign key (TRAKSAKSI_ID)
      references LOG_TRANSAKSI (TRAKSAKSI_ID)
      on update restrict
      on delete restrict;

alter table DRH
   add constraint FK_DRH_PEGAWAI_D_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table HAK_AKSES_FORM
   add constraint FK_HAK_AKSE_DIBERIKAN_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table HAK_AKSES_FORM
   add constraint FK_HAK_AKSE_UNTUK_FOR_MF_FORM foreign key (FORM_ID)
      references MF_FORM (FORM_ID)
      on update restrict
      on delete restrict;

alter table HAK_AKSES_TYPE_SPRIN
   add constraint FK_HAK_AKSE_AKSES_SPR_MF_TYPE_ foreign key (TYPE_SPRIN_ID)
      references MF_TYPE_SPRIN (TYPE_SPRIN_ID)
      on update restrict
      on delete restrict;

alter table HAK_AKSES_TYPE_SPRIN
   add constraint FK_HAK_AKSE_USER_SPRI_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table LEMBUR
   add constraint FK_LEMBUR_DILAKUKAN_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table LEMBUR
   add constraint FK_LEMBUR_TERJADI_T_KALENDER foreign key (TGL_KERJA)
      references KALENDER (TGL_KERJA)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY
   add constraint FK_LOG_ACTI_DILAKUKAN_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY
   add constraint FK_LOG_ACTI_DILAKUKAN_MF_TIM_S foreign key (GUID_TIM)
      references MF_TIM_SIAGA (GUID_TIM)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY
   add constraint FK_LOG_ACTI_MEMBACKUP_LOG_ACTI foreign key (GUID_LOG_BACKUP)
      references LOG_ACTIVITIY_BACKUP (GUID_LOG_BACKUP)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY
   add constraint FK_LOG_ACTI_MEMILIKI__MF_STATU foreign key (STATUS_ID)
      references MF_STATUS (STATUS_ID)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY
   add constraint FK_LOG_ACTI_TRANSAKSI_LOG_TRAN foreign key (TRAKSAKSI_ID)
      references LOG_TRANSAKSI (TRAKSAKSI_ID)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY
   add constraint FK_LOG_ACTI_UNIT_MELA_MF_UNIT_ foreign key (UNIT_KERJA_ID)
      references MF_UNIT_KERJA (UNIT_KERJA_ID)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY_BACKUP
   add constraint FK_LOG_ACTI_MEMBACKUP_LOG_BKP foreign key (GUID_LOG)
      references LOG_ACTIVITIY (GUID_LOG)
      on update restrict
      on delete restrict;

alter table LOG_TRANSAKSI
   add constraint FK_LOG_TRAN_DATA_BACK_LOG_TRAN foreign key (TRAKSAKSI_BACKUP_ID)
      references LOG_TRANSAKSI_BACKUP (TRAKSAKSI_BACKUP_ID)
      on update restrict
      on delete restrict;

alter table LOG_TRANSAKSI
   add constraint FK_LOG_TRAN_TRANSAKSI_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table LOG_TRANSAKSI_BACKUP
   add constraint FK_LOG_TRAN_DATA_BACK_LOG_BKP foreign key (TRAKSAKSI_ID)
      references LOG_TRANSAKSI (TRAKSAKSI_ID)
      on update restrict
      on delete restrict;

alter table MF_CONFIG
   add constraint FK_MF_CONFI_MENCATAT__LOG_TRAN foreign key (TRAKSAKSI_ID)
      references LOG_TRANSAKSI (TRAKSAKSI_ID)
      on update restrict
      on delete restrict;

alter table MF_FIELD_CARI
   add constraint FK_MF_FIELD_MENCATAT__LOG_TRAN foreign key (TRAKSAKSI_ID)
      references LOG_TRANSAKSI (TRAKSAKSI_ID)
      on update restrict
      on delete restrict;

alter table MF_HOST_NAME_FP
   add constraint FK_MF_HOST__HOST_DARI_MF_UNIT_ foreign key (UNIT_KERJA_ID)
      references MF_UNIT_KERJA (UNIT_KERJA_ID)
      on update restrict
      on delete restrict;

alter table MF_JABATAN
   add constraint FK_MF_JABAT_MERUBAH_J_PERUBAHA foreign key (JABATAN_ID_BARU)
      references PERUBAHAN_JABATAN (JABATAN_ID_BARU)
      on update restrict
      on delete restrict;

alter table MF_JABATAN
   add constraint FK_MF_JABAT_TERMASUK__MF_GROUP foreign key (GROUP_JABATAN_ID)
      references MF_GROUP_JABATAN (GROUP_JABATAN_ID)
      on update restrict
      on delete restrict;

alter table MF_JABATAN
   add constraint FK_MF_JABAT_TERMASUK__MF__SUB_ foreign key (SUB_GROUP_JABATAN_ID)
      references MF_SUB_GROUP_JABATAN (SUB_GROUP_JABATAN_ID)
      on update restrict
      on delete restrict;

alter table MF_JABATAN_KEGIATAN
   add constraint FK_MF_JABAT_DIBUAT_UN_MF_JABAT foreign key (JABATAN_ID)
      references MF_JABATAN (JABATAN_ID)
      on update restrict
      on delete restrict;

alter table MF_JOBLIST
   add constraint FK_MF_JOBLI_MEMILIKI__MF_GROUP foreign key (GROUP_JABATAN_ID)
      references MF_GROUP_JABATAN (GROUP_JABATAN_ID)
      on update restrict
      on delete restrict;

alter table MF_JOBLIST
   add constraint FK_MF_JOBLI_MENGACU_K_MF_JABAT foreign key (ITEM_ID)
      references MF_JABATAN_KEGIATAN (ITEM_ID)
      on update restrict
      on delete restrict;

alter table MF_KLASIFIKASI_SURAT
   add constraint FK_MF_KLASI_MENGAKLSI_MF_TYPE_ foreign key (TYPE_SPRIN_ID)
      references MF_TYPE_SPRIN (TYPE_SPRIN_ID)
      on update restrict
      on delete restrict;

alter table MF_LOAD_FINGER
   add constraint FK_MF_LOAD__MENCATAT__LOG_TRAN foreign key (TRAKSAKSI_ID)
      references LOG_TRANSAKSI (TRAKSAKSI_ID)
      on update restrict
      on delete restrict;

alter table MF_SHIFT
   add constraint FK_MF_SHIFT_MENCATAT__LOG_TRAN foreign key (TRAKSAKSI_ID)
      references LOG_TRANSAKSI (TRAKSAKSI_ID)
      on update restrict
      on delete restrict;

alter table MF_SU
   add constraint FK_MF_SU_MENYIMPAN_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table MF_TIM_SIAGA_ANGGOTA
   add constraint FK_MF_TIM_S_BERANGGOT_MF_TIM_S foreign key (GUID_TIM)
      references MF_TIM_SIAGA (GUID_TIM)
      on update restrict
      on delete restrict;

alter table MF_TIM_SIAGA_ANGGOTA
   add constraint FK_MF_TIM_S_DIISI_OLE_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table MF_TR
   add constraint FK_MF_TR_MENCATAT__LOG_TRAN foreign key (TRAKSAKSI_ID)
      references LOG_TRANSAKSI (TRAKSAKSI_ID)
      on update restrict
      on delete restrict;

alter table MONITORING_APP
   add constraint FK_MONITORI_MENCATAT__LOG_TRAN foreign key (TRAKSAKSI_ID)
      references LOG_TRANSAKSI (TRAKSAKSI_ID)
      on update restrict
      on delete restrict;

alter table OTORISASI
   add constraint FK_OTORISAS_DIAJUKAN__PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table OTORISASI_HISTORY
   add constraint FK_OTORISAS_OTORISASI_MF_UNIT_ foreign key (UNIT_KERJA_ID)
      references MF_UNIT_KERJA (UNIT_KERJA_ID)
      on update restrict
      on delete restrict;

alter table OTORISASI_HISTORY
   add constraint FK_OTORISAS_OTORISASI_OTORISAS foreign key (GUID_OTO)
      references OTORISASI (GUID_OTO)
      on update restrict
      on delete restrict;

alter table OTORISASI_HISTORY
   add constraint FK_OTORISAS_USER_OTOR_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table PEGAWAI
   add constraint FK_PEGAWAI_BEKERJA_D_MF_UNIT_ foreign key (UNIT_KERJA_ID)
      references MF_UNIT_KERJA (UNIT_KERJA_ID)
      on update restrict
      on delete restrict;

alter table PEGAWAI
   add constraint FK_PEGAWAI_DILAKUKAN_ABSENSI foreign key (ABSENSI_ID)
      references ABSENSI (ABSENSI_ID)
      on update restrict
      on delete restrict;

alter table PEGAWAI
   add constraint FK_PEGAWAI_MEMILIKI__MF_ESELO foreign key (ESELON)
      references MF_ESELON (ESELON)
      on update restrict
      on delete restrict;

alter table PEGAWAI
   add constraint FK_PEGAWAI_MEMILIKI__MF_GOL foreign key (GOL_ID)
      references MF_GOL (GOL_ID)
      on update restrict
      on delete restrict;

alter table PEGAWAI
   add constraint FK_PEGAWAI_MENDUDUKI_MF_JABAT foreign key (JABATAN_ID)
      references MF_JABATAN (JABATAN_ID)
      on update restrict
      on delete restrict;

alter table PEGAWAI
   add constraint FK_PEGAWAI_TERMASUK__MF_CLASS foreign key (CLASS_ID)
      references MF_CLASS (CLASS_ID)
      on update restrict
      on delete restrict;

alter table PEGAWAI
   add constraint FK_PEGAWAI_UNTUK_STA_MF_TUNJA foreign key (TUNJANGAN_ID)
      references MF_TUNJANGAN (TUNJANGAN_ID)
      on update restrict
      on delete restrict;

alter table PEG_MUTASI_UNIT
   add constraint FK_PEG_MUTA_MENCATAT__LOG_TRAN foreign key (TRAKSAKSI_ID)
      references LOG_TRANSAKSI (TRAKSAKSI_ID)
      on update restrict
      on delete restrict;

alter table PEG_MUTASI_UNIT
   add constraint FK_PEG_MUTA_USER_PIND_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table PERUBAHAN_JABATAN
   add constraint FK_PERUBAHA_MERUBAH_J_MF_JABAT foreign key (JABATAN_ID)
      references MF_JABATAN (JABATAN_ID)
      on update restrict
      on delete restrict;

alter table SARAN
   add constraint FK_SARAN_MENYAMPAI_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table SKP_PEGAWAI
   add constraint FK_SKP_PEGA_DILAKSANA_MF_JABAT foreign key (JABATAN_ID)
      references MF_JABATAN (JABATAN_ID)
      on update restrict
      on delete restrict;

alter table SKP_PEGAWAI
   add constraint FK_SKP_PEGA_TERKAIT_O_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table SKP_PEGAWAI_HEAD
   add constraint FK_SKP_PEGA_BAWAHAN_U_SKP_PEGA foreign key (GUID_SKP_PEG)
      references SKP_PEGAWAI (GUID_SKP_PEG)
      on update restrict
      on delete restrict;

alter table SKP_PEGAWAI_HEAD
   add constraint FK_SKP_PEGA_GOL_PEGAW_MF_GOL foreign key (GOL_ID)
      references MF_GOL (GOL_ID)
      on update restrict
      on delete restrict;

alter table SKP_PEGAWAI_HEAD
   add constraint FK_SKP_PEGA_JABATAN_P_MF_JABAT foreign key (JABATAN_ID)
      references MF_JABATAN (JABATAN_ID)
      on update restrict
      on delete restrict;

alter table SKP_PEGAWAI_HEAD
   add constraint FK_SKP_PEGA_USER_HEAD_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table SPRIN_HEADER
   add constraint FK_SPRIN_HE_BERTIPE_MF_TYPE_ foreign key (TYPE_SPRIN_ID)
      references MF_TYPE_SPRIN (TYPE_SPRIN_ID)
      on update restrict
      on delete restrict;

alter table USER_ACCOUNT
   add constraint FK_USER_ACC_DIMILIKI__PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================
-- INSERT DATA DUMMY UNTUK SEMUA TABEL
-- =============================================================

-- Nonaktifkan foreign key check sementara agar bisa insert dengan urutan bebas
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Tabel Master Independen (tanpa FK atau FK ke tabel yg sudah diisi)
INSERT INTO MF_ESELON (ESELON, URUT_ESELON) VALUES 
('1', 0),
('2', 1),
('3', 2),
('4', 3),
('-', 4),
('', 5);

INSERT INTO MF_GOL (GOL_ID, NAMA_GOL, PANGKAT_GOL, URUT_GOL, TRANSAC_ID, GROUP_GOL) VALUES
(1, 'I/a', 'Juru Muda', 16, 1, '1'),
(2, 'I/b', 'Juru Muda Tk.I', 15, 2, '1'),
(3, 'I/c', 'Juru', 14, 3, '1'),
(4, 'I/d', 'Juru Tk.I', 13, 4, '1'),
(5, 'II/a', 'Pengatur Muda', 12, 5, '2'),
(6, 'II/b', 'Pengatur Muda Tk.I', 11, 6, '2'),
(7, 'II/c', 'Pengatur', 10, 7, '2'),
(8, 'II/d', 'Pengatur Tk.I', 9, 8, '2'),
(9, 'III/a', 'Penata Muda', 8, 9, '3'),
(10, 'III/b', 'Penata Muda Tk.I', 7, 10, '3'),
(11, 'III/c', 'Penata', 6, 11, '3'),
(12, 'III/d', 'Penata Tk.I', 5, 12, '3'),
(13, 'IV/a', 'Pembina', 4, 13, '4'),
(14, 'IV/b', 'Pembina Tk.I', 3, 14, '4'),
(15, 'IV/c', 'Pembina Utama Muda', 2, 15, '4'),
(16, 'IV/d', 'Pembina Utama Madya', 1, 16, '4'),
(17, 'IV/e', 'Pembina Utama', 0, 17, '4'),
(18, '-', '-', 999, 18, NULL),
(19, ' ', ' ', 999, 19, NULL);

INSERT INTO MF_GROUP_JABATAN (GROUP_JABATAN_ID, NAMA_GROUP_JABATAN) VALUES
(0, '-'),
(10, 'Kepala Kantor'),
(1010, 'Kasubag Umum'),
(1020, 'Kasi Ops dan Siaga'),
(1030, 'Kasi Sumber Daya'),
(101010, 'Perencanaan'),
(101011, 'Analis BMN'),
(101012, 'Penata Lap SAI'),
(101013, 'Analis Keuangan'),
(101014, 'Pengelola Urusan Dalam'),
(101015, 'Analis Kepegawaian'),
(101016, 'Arsiparis'),
(101017, 'Pranata Komputer'),
(101021, 'Perawat'),
(101022, 'Humas'),
(102010, 'Analis SAR'),
(102011, 'Opr Kom'),
(102012, 'Teknisi Alkom'),
(102013, 'Rescuer'),
(103010, 'Instruktur SAR'),
(103011, 'Pengelola Alat Logistik'),
(103012, 'Pengelola Kendaraan'),
(103013, 'Pengemudi'),
(103014, 'Nahkoda'),
(103015, 'Mualim'),
(103016, 'Markonis'),
(103017, 'Serang Bosun'),
(103018, 'Juru Mudi'),
(103019, 'Jenang Kelasi'),
(103020, 'Juru Masak'),
(103021, 'KKM'),
(103022, 'Masinis'),
(103023, 'Teknisi Listrik Kapal'),
(103024, 'Mandor Mesin'),
(103025, 'Juru Minyak'),
(900000, 'Bendahara'),
(900001, 'Adm Umum'),
(900003, 'Verifikator'),
(900004, 'Adm Kepegawaian');

INSERT INTO MF_SUB_GROUP_JABATAN (SUB_GROUP_JABATAN_ID, NAMA_SUB_GROUP_JABATAN) VALUES
(0, '-'),
(10101010, 'Perencanaan'),
(10101110, 'Analis BMN'),
(10101210, 'Penata Lap SAI'),
(10101310, 'Analis Keuangan'),
(10101410, 'Pengelola Urusan Dalam'),
(10101510, 'Analis Kepegawaian'),
(10101610, 'Arsiparis Terampil'),
(10101620, 'Arsiparis Ahli'),
(10101710, 'Pranata Komputer'),
(10102110, 'Perawat'),
(10102210, 'Pranata Humas'),
(10201010, 'Analis SAR'),
(10201110, 'Opr Kom'),
(10201210, 'Teknisi Alkom'),
(10201310, 'Recuer'),
(10301010, 'Instruktur SAR'),
(10301110, 'Pengelola Alat Logistik'),
(10301210, 'Pengelola Kendaraan'),
(10301310, 'Pengemudi'),
(10301410, 'Nahkoda'),
(10301510, 'Mualim'),
(10301610, 'Markonis'),
(10301710, 'Serang Bosun'),
(10301810, 'Juru Mudi'),
(10301910, 'Kelasi'),
(10302010, 'Juru Masak'),
(10302110, 'KKM'),
(10302210, 'Masinis'),
(10302310, 'Teknisi Listrik'),
(10302410, 'Mandor Mesin'),
(10302510, 'Juru Minyak');

INSERT INTO MF_UNIT_KERJA (UNIT_KERJA_ID, NAMA_UNIT_KERJA, URUT_REPORT, IS_PUSAT) VALUES 
(1, 'Kantor Pusat', 1, 1),
(2, 'Kantor SAR Surabaya', 2, 0);

INSERT INTO MF_UNIT_KERJA (UNIT_KERJA_ID, NAMA_UNIT_KERJA, URUT_REPORT, IS_PUSAT, TRANSAC_ID, UPDATE_IN_BY, UPDATE_DATE) VALUES
(1,  'SURABAYA',1, 1, 1,  '198008292010121001', '2017-08-22 23:54:54'),
(2,  'JEMBER',2, 2, 2,  '198008292010121001', '2017-08-22 23:58:52'),
(3,  'TRENGGALEK',3, 2, 3,  '198008292010121001', '2017-08-22 23:59:10'),
(4,  'KN WIDURA',8, 1, 4,  '198301062009122003', '2024-09-29 23:26:34'),
(21, 'PRAMUBAKTI',21, 1, 5,  '198008292010121001', '2022-03-28 02:15:26'),
(6,  'BANYUWANGI',4, 2, 6,  '198301062009122003', '2024-09-29 23:32:42'),
(23, 'ABK HONORER',23, 1, 7,  '198008292010121001', '2020-07-19 19:32:07'),
(20, 'SECURITY',20, 1, 8,  '198008292010121001', '2020-07-19 19:28:20'),
(22, 'HONORER',22, 1, 9,  '198008292010121001', '2022-05-15 17:28:13'),
(5,  'KN SRIKANDI',9, 1, 10, '198301062009122003', '2024-09-29 23:28:54'),
(7,  'KN ANTASENA',10, 1, 11, '198301062009122003', '2024-09-29 23:39:18'),
(24, 'CPNS',24, 1, 12, '198008292010121001', '2021-01-02 15:09:01'),
(8,  'SUMENEP',5, 2, 13, '198301062009122003', '2024-09-29 23:42:50'),
(9,  'KN PERMADI',11, 1, 14, '198301062009122003', '2024-09-29 23:53:51'),
(25, 'PPNPN',25, 1, 15, '198008292010121001', '2022-03-28 02:23:56'),
(26, 'ABK PPNPN',26, 1, 16, '198008292010121001', '2022-05-10 15:21:51'),
(27, 'RESCUER PPNPN',27, 1, 17, '198008292010121001', '2022-05-10 20:07:49'),
(10, 'BOJONEGORO',6, 2, 18, '198411222009121001', '2024-10-30 23:54:18'),
(11, 'MALANG',7, 2, 19, '198411222009121001', '2024-10-30 23:56:23'),
(28, 'PPPK',28, 1, 20, '198301062009122003', '2025-05-28 22:58:34'),
(29, 'PPPK Paruh Waktu',29, 1, 21, '198301062009122003', '2025-05-28 23:02:46');

INSERT INTO MF_STATUS (STATUS_ID, STATUS, BG_STATUS, ALERT_STATUS, SPAN_STATUS_LOG_JOB, STATUS_LOG_JOB) VALUES
(-1, 'Tdk Hadir',   'bg-red',    'alert-danger',  'badge bg-blue',  'On Progress'),
( 0, 'Batal',       'bg-black',  'alert-danger',  'badge bg-red',   'Reject'),
( 1, 'Request',     'bg-yellow', 'alert-warning', NULL,             NULL),
( 2, 'Rencana',     'bg-blue',   'alert-info',    'badge bg-green', 'Finish'),
( 3, 'Dilaksanaan', 'bg-green',  'alert-success', 'badge bg-green', 'Approved');

INSERT INTO MF_TYPE_SPRIN (TYPE_SPRIN_ID, TYPE_SPRIN_NAME) VALUES
('OPR', 'Operasi'),
('DL',  'Umum'),
('POT', 'Potensi');

INSERT INTO MF_SATUAN (SATUAN_ID, ACTIVITY, SATUAN, PARAMETER, URUT_SATUAN) VALUES 
(1, 'Kegiatan', 'Jam', 'Waktu', 1),
(2, 'Kegiatan', 'Buah', 'Jumlah', 2);

INSERT INTO MF_SATUAN (SATUAN_ID, ACTIVITY, SATUAN, PARAMETER, URUT_SATUAN) VALUES
(1,'SKP', 'Surat Tugas', 'QTY',  10),
(2,'SKP', 'Lembar',      'QTY',  13),
(3,'SKP', 'Daftar',      'QTY',  14),
(4,'SKP', 'Dokumen',     'QTY',   1),
(5,'SKP', 'Buku',        'QTY',   2),
(6,'SKP', 'Ceklist',     'QTY',   3),
(7,'SKP', 'Data',        'QTY',   4),
(8,'SKP', 'Laporan',     'QTY',   5),
(9,'SKP', 'Label',       'QTY',   6),
(10,'SKP', 'Kegiatan',    'QTY',   7),
(11,'SKP', 'Makalah',     'QTY',   8),
(12,'SKP', 'Naskah',      'QTY',   9),
(13,'SKP', '-',           'QTY',  11),
(14,'SKP', '',            'QTY',  12),
(15,'SKP', '-',           'MUTU', 11),
(16,'SKP', '%',           'MUTU',  1),
(17,'SKP', 'Bulan',       'WAKTU', 1),
(18,'SKP', '-',           'WAKTU',10),
(19,'SKP', '',            'WAKTU',11);

INSERT INTO MF_UNSUR_KEGIATAN (UNSUR_ID, DESKRIPSI_UNSUR) VALUES
(0, 'Unsur Utama'),
(1, 'Unsur Penunjang');

INSERT INTO MF_ORGZ_SIAGA (ORGZ_SIAGA_ID, FUNGSIONAL, PARENT_ID, URUT_FUNGSIONAL, DESKRIPSI, INISIAL, FLAG) VALUES
(2,  'PW',         NULL,  2, 'Perwira',                    'P',  'PW'),
(20, 'ABK',        2,    20, 'Anak Buah Kapal',            'A',  'ABK'),
(16, 'Kom_(P)',    1,    11, 'Komunikasi Khusus Perempuan','KF', 'KOM'),
(1,  'KGR',        NULL,  1, 'KAGAHAR',                    'G',  'KGR'),
(11, 'Kom',        1,    11, 'Komunikasi',                 'K',  'KOM'),
(12, 'Medis',      1,    13, 'Medis',                      'M',  'MEDIS'),
(14, 'Humas',      1,    15, 'Hubungan Masyarakat',        'H',  'HUMAS'),
(15, 'Rescuer',    1,    17, 'Rescuer',                    'R',  'RESCUER'),
(17, 'Rescuer_(P)',1,    17, 'Rescuer Khusus Perempuan',   'RF', 'RESCUER');

INSERT INTO MF_JAM_KERJA (JAM_KERJA_ID, STD_JAM_IN, STD_JAM_OUT, TGL_MULAI_BERLAKU, SHIFT, AGENDA, PENGGANTIAN_TLM1, UPDATE_BY, UPDATE_DATE, SHIFT_KERJA) VALUES
(1,  '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2013-01-01 00:00:00', '1', NULL, 'Y', NULL, NULL, '1'),
(2,  '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2013-01-01 00:00:00', '2', NULL, 'Y', NULL, NULL, '1'),
(3,  '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2013-12-31 00:00:00', '1', NULL, 'Y', NULL, NULL, '1'),
(4,  '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2013-12-31 00:00:00', '2', NULL, 'Y', NULL, NULL, '1'),
(5,  '1900-01-01 08:00:00', '1900-01-01 15:30:00', '2013-11-11 00:00:00', '1', NULL, 'N', NULL, NULL, '1'),
(6,  '1900-01-01 08:00:00', '1900-01-01 16:30:00', '2013-11-11 00:00:00', '2', NULL, 'N', NULL, NULL, '1'),
(7,  '1900-01-01 08:00:00', '1900-01-01 15:30:00', '2014-01-02 00:00:00', '1', NULL, 'N', '198306022010121004', '2014-01-03 07:30:00', '1'),
(8,  '1900-01-01 08:00:00', '1900-01-01 16:30:00', '2014-01-02 00:00:00', '2', NULL, 'N', '198306022010121004', '2014-01-03 07:35:00', '1'),
(9,  '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2014-01-17 00:00:00', '1', NULL, 'Y', '198306022010121004', '2014-01-27 12:20:00', '1'),
(10, '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2014-01-17 00:00:00', '2', NULL, 'Y', '198306022010121004', '2014-01-27 12:25:00', '1'),
(11, '1900-01-01 08:00:00', '1900-01-01 15:30:00', '2014-06-01 00:00:00', '1', NULL, 'N', '198306022010121004', '2014-06-03 11:10:00', '1'),
(12, '1900-01-01 08:00:00', '1900-01-01 16:30:00', '2014-06-01 00:00:00', '2', NULL, 'N', '198306022010121004', '2014-06-03 11:20:00', '1'),
(13, '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2014-06-25 00:00:00', '1', NULL, 'Y', '198306022010121004', '2014-07-12 10:30:00', '1'),
(14, '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2014-06-25 00:00:00', '2', NULL, 'Y', '198306022010121004', '2014-07-12 10:35:00', '1'),
(15, '1900-01-01 08:00:00', '1900-01-01 15:30:00', '2015-01-01 00:00:00', '1', NULL, 'N', '198008292010121001', '2015-01-02 09:15:00', '1'),
(16, '1900-01-01 08:00:00', '1900-01-01 16:30:00', '2015-01-01 00:00:00', '2', NULL, 'N', '198008292010121001', '2015-01-02 09:20:00', '1'),
(17, '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2015-01-23 00:00:00', '1', NULL, 'Y', '198008292010121001', '2015-01-23 14:50:00', '1'),
(18, '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2015-01-23 00:00:00', '2', NULL, 'Y', '198008292010121001', '2015-01-23 14:55:00', '1'),
(19, '1900-01-01 23:30:00', '1900-01-01 01:00:00', '2015-05-15 00:00:00', '1', NULL, 'Y', 'Sysadmin', '2015-05-23 02:15:00', '2'),
(20, '1900-01-01 23:30:00', '1900-01-01 01:00:00', '2015-05-15 00:00:00', '2', NULL, 'Y', 'Sysadmin', '2015-05-23 02:20:00', '2'),
(21, '1900-01-01 08:00:00', '1900-01-01 15:30:00', '2015-06-05 00:00:00', '1', NULL, 'N', '198008292010121001', '2015-06-07 10:05:00', '1'),
(22, '1900-01-01 08:00:00', '1900-01-01 16:30:00', '2015-06-05 00:00:00', '2', NULL, 'N', '198008292010121001', '2015-06-07 10:10:00', '1'),
(23, '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2015-07-01 00:00:00', '1', NULL, 'Y', '198008292010121001', '2015-07-01 16:40:00', '1'),
(24, '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2015-07-01 00:00:00', '2', NULL, 'Y', '198008292010121001', '2015-07-01 16:45:00', '1'),
(25, '1900-01-01 08:00:00', '1900-01-01 15:30:00', '2015-11-01 00:00:00', '1', NULL, 'N', '198008292010121001', '2015-11-11 08:50:00', '1'),
(26, '1900-01-01 08:00:00', '1900-01-01 16:30:00', '2015-11-01 00:00:00', '2', NULL, 'N', '198008292010121001', '2015-11-11 09:00:00', '1'),
(27, '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2015-11-25 00:00:00', '1', NULL, 'Y', '198008292010121001', '2015-12-05 10:20:00', '1'),
(28, '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2015-11-25 00:00:00', '2', NULL, 'Y', '198008292010121001', '2015-12-05 10:25:00', '1'),
(29, '1900-01-01 08:00:00', '1900-01-01 15:30:00', '2016-02-10 00:00:00', '1', NULL, 'N', '198008292010121001', '2016-02-11 13:30:00', '1'),
(30, '1900-01-01 08:00:00', '1900-01-01 16:30:00', '2016-02-10 00:00:00', '2', NULL, 'N', '198008292010121001', '2016-02-11 13:35:00', '1'),
(31, '1900-01-01 00:30:00', '1900-01-01 01:00:00', '2016-02-10 00:00:00', '1', NULL, 'N', '198008292010121001', '2016-02-13 10:50:00', '2'),
(33, '1900-01-01 08:00:00', '1900-01-01 16:00:00', '2016-03-01 00:00:00', '1', NULL, 'Y', '198008292010121001', '2016-03-01 15:40:00', '1'),
(34, '1900-01-01 08:00:00', '1900-01-01 17:00:00', '2016-03-01 00:00:00', '2', NULL, 'Y', '198008292010121001', '2016-03-01 15:45:00', '1'),
(35, '1900-01-01 08:00:00', '1900-01-01 15:30:00', '2016-07-01 00:00:00', '1', NULL, 'N', '198008292010121001', '2016-07-01 08:20:00', '1'),
(36, '1900-01-01 08:00:00', '1900-01-01 16:30:00', '2016-07-01 00:00:00', '2', NULL, 'N', '198008292010121001', '2016-07-01 08:25:00', '1'),
(37, '1900-01-01 08:00:00', '1900-01-01 16:00:00', '2016-07-25 00:00:00', '1', NULL, 'Y', '198008292010121001', '2016-07-24 20:30:00', '1'),
(38, '1900-01-01 08:00:00', '1900-01-01 17:00:00', '2016-07-25 00:00:00', '2', NULL, 'Y', '198008292010121001', '2016-07-24 20:35:00', '1'),
(39, '1900-01-01 06:30:00', '1900-01-01 14:30:00', '2016-12-01 00:00:00', '1', NULL, 'Y', '198008292010121001', '2016-12-01 11:15:00', '1'),
(40, '1900-01-01 06:30:00', '1900-01-01 15:30:00', '2016-12-01 00:00:00', '2', NULL, 'Y', '198008292010121001', '2016-12-01 11:20:00', '1'),
(41, '1900-01-01 00:30:00', '1900-01-01 00:45:00', '2016-12-01 00:00:00', '1', NULL, 'Y', '198008292010121001', '2016-12-10 09:10:00', '2'),
(42, '1900-01-01 00:30:00', '1900-01-01 01:00:00', '2016-12-01 00:00:00', '2', NULL, 'Y', '198008292010121001', '2016-12-10 09:20:00', '2'),
(43, '1900-01-01 00:30:00', '1900-01-01 01:00:00', '2016-11-01 00:00:00', '1', NULL, 'Y', '198008292010121001', '2016-12-10 09:45:00', '2'),
(44, '1900-01-01 00:30:00', '1900-01-01 01:15:00', '2016-11-01 00:00:00', '2', NULL, 'Y', '198008292010121001', '2016-12-10 10:00:00', '2'),
(45, '1900-01-01 08:00:00', '1900-01-01 16:00:00', '2017-01-01 00:00:00', '1', NULL, 'Y', '198008292010121001', '2017-01-01 13:30:00', '1'),
(46, '1900-01-01 08:00:00', '1900-01-01 17:00:00', '2017-01-01 00:00:00', '2', NULL, 'Y', '198008292010121001', '2017-01-01 13:35:00', '1'),
(47, '1900-01-01 00:30:00', '1900-01-01 01:00:00', '2017-01-01 00:00:00', '1', NULL, 'Y', '198008292010121001', '2017-01-01 13:50:00', '2'),
(48, '1900-01-01 00:30:00', '1900-01-01 01:15:00', '2017-01-01 00:00:00', '2', NULL, 'Y', '198008292010121001', '2017-01-01 13:55:00', '2'),
(49, '1900-01-01 08:00:00', '1900-01-01 15:30:00', '2017-05-01 00:00:00', '1', NULL, 'N', '197803022007122002', '2017-05-10 16:30:00', '1'),
(50, '1900-01-01 08:00:00', '1900-01-01 16:30:00', '2017-05-01 00:00:00', '2', NULL, 'N', '197803022007122002', '2017-05-10 16:35:00', '1'),
(61, '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2017-01-01 00:00:00', '1', NULL, 'Y', 'sysadmin', '2017-08-01 15:20:00', '1'),
(64, '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2016-09-01 00:00:00', '2', NULL, 'Y', 'sysadmin', '2017-08-01 16:10:00', '1'),
(65, '1900-01-01 00:30:00', '1900-01-01 00:45:00', '2017-05-01 00:00:00', '1', NULL, 'N', 'sysadmin', '2017-08-02 09:30:00', '2'),
(66, '1900-01-01 00:30:00', '1900-01-01 01:00:00', '2017-05-01 00:00:00', '2', NULL, 'N', 'sysadmin', '2017-08-02 09:45:00', '2'),
(67, '1900-01-01 23:30:00', '1900-01-01 01:00:00', '2017-06-01 00:00:00', '1', NULL, 'Y', 'sysadmin', '2017-08-02 10:00:00', '2'),
(59, '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2017-06-01 00:00:00', '1', NULL, 'Y', 'sysadmin', '2017-08-01 14:50:00', '1'),
(60, '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2017-06-01 00:00:00', '2', NULL, 'Y', 'sysadmin', '2017-08-01 14:55:00', '1'),
(68, '1900-01-01 23:30:00', '1900-01-01 01:15:00', '2017-06-01 00:00:00', '2', NULL, 'Y', 'sysadmin', '2017-08-02 10:15:00', '2'),
(69, '1900-01-01 08:00:00', '1900-01-01 15:30:00', '2017-12-01 00:00:00', '1', NULL, 'N', '198301062009122003', '2017-11-28 10:30:00', '1'),
(70, '1900-01-01 08:00:00', '1900-01-01 16:30:00', '2017-12-01 00:00:00', '2', NULL, 'N', '198301062009122003', '2017-11-28 10:35:00', '1'),
(71, '1900-01-01 00:30:00', '1900-01-01 00:45:00', '2017-12-01 00:00:00', '1', NULL, 'N', '198301062009122003', '2017-11-28 11:00:00', '2'),
(72, '1900-01-01 00:30:00', '1900-01-01 01:00:00', '2017-12-01 00:00:00', '2', NULL, 'N', '198301062009122003', '2017-11-28 11:10:00', '2'),
(73, '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2017-12-25 00:00:00', '1', NULL, 'Y', '198301062009122003', '2017-12-20 13:20:00', '1'),
(74, '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2017-12-25 00:00:00', '2', NULL, 'Y', '198301062009122003', '2017-12-20 13:30:00', '1'),
(75, '1900-01-01 23:30:00', '1900-01-01 01:00:00', '2017-12-25 00:00:00', '1', NULL, 'Y', '198301062009122003', '2017-12-20 13:40:00', '2'),
(76, '1900-01-01 23:30:00', '1900-01-01 01:15:00', '2017-12-25 00:00:00', '2', NULL, 'Y', '198301062009122003', '2017-12-20 13:45:00', '2'),
(32, '1900-01-01 23:30:00', '1900-01-01 01:15:00', '2016-02-10 00:00:00', '2', NULL, 'N', '198008292010121001', '2016-02-13 11:00:00', '2'),
(62, '1900-01-01 07:30:00', '1900-01-01 17:00:00', '2017-01-01 00:00:00', '2', NULL, 'Y', 'sysadmin', '2017-08-01 15:35:00', '1'),
(63, '1900-01-01 07:30:00', '1900-01-01 16:00:00', '2016-09-01 00:00:00', '1', NULL, 'Y', 'sysadmin', '2017-08-01 16:00:00', '1');

INSERT INTO MF_POT (POTONGAN_ID, KATEGORI, TINGKAT, PERSEN_POT, TGL_MULAI, RANGE_AWAL, RANGE_AKHIR, NAMA_POT, UPDATE_BY, UPDATE_DATE, IS_PENDUKUNG, TINDAKAN, DURASI_POT, SATUAN_DURASI) VALUES
(1,  'TLM', 'TLM-1', 0.5,  '2013-01-01 00:00:00', 1,   30,   'Terlambat Tk-1',                    '198306022010121004', '2013-10-11 20:48:21', 'Y', NULL, 0, NULL),
(2,  'TLM', 'TLM-2', 1,    '2013-01-01 00:00:00', 31,  60,   'Terlambat Tk-2',                    '198306022010121004', '2013-10-11 20:50:00', 'Y', NULL, 0, NULL),
(3,  'TLM', 'TLM-3', 1.25, '2013-01-01 00:00:00', 61,  90,   'Terlambat Tk-3',                    '198306022010121004', '2013-10-11 20:51:00', 'Y', NULL, 0, NULL),
(4,  'TLM', 'TLM-4', 1.5,  '2013-01-01 00:00:00', 91,  1000, 'Terlambat Tk-4',                    '198306022010121004', '2013-10-11 20:52:00', 'Y', NULL, 0, NULL),
(5,  'PSW', 'PSW-1', 0.5,  '2013-01-01 00:00:00', -1,  -30,  'Pulang Sebelum Waktu Tk-1',         '198306022010121004', '2013-10-11 20:53:00', 'Y', NULL, 0, NULL),
(6,  'PSW', 'PSW-2', 1,    '2013-01-01 00:00:00', -31, -60,  'Pulang Sebelum Waktu Tk-2',         '198306022010121004', '2013-10-11 20:54:00', 'Y', NULL, 0, NULL),
(7,  'PSW', 'PSW-3', 1.25, '2013-01-01 00:00:00', -61, -90,  'Pulang Sebelum Waktu Tk-3',         '198306022010121004', '2013-10-11 20:55:00', 'Y', NULL, 0, NULL),
(8,  'PSW', 'PSW-4', 1.5,  '2013-01-01 00:00:00', -91, -1000,'Pulang Sebelum Waktu Tk-4',         '198306022010121004', '2013-10-11 20:56:00', 'Y', NULL, 0, NULL),
(9,  'DINASLUAR', 'DL', 1, '2013-01-01 00:00:00', 1,   4,    'Dinas Luar',                        '198306022010121004', '2013-10-11 20:57:00', 'Y', NULL, 0, NULL),
(10, 'SAKIT', 'S-1', 0,    '2013-01-01 00:00:00', 1,   4,    'Sakit SU Dok 1-2 hr',               '198306022010121004', '2014-02-24 11:30:00', 'Y', NULL, 0, NULL),
(11, 'SAKIT', 'S-2', 2,    '2013-01-01 00:00:00', 15,  1000, 'Sakit SU Dok Menkes > 3 hr',        '198306022010121004', '2014-02-24 11:40:00', 'Y', NULL, 0, NULL),
(12, 'SAKIT', 'S-4', 3,    '2013-01-01 00:00:00', 1,   1000, 'Sakit SU Dok Non Menkes >14 hr',    '198306022010121004', '2014-02-28 10:20:00', 'Y', NULL, 0, NULL),
(13, 'IJIN',  'I',   5,    '2013-01-01 00:00:00', 1,   30,   'Ijin',                              '198306022010121004', '2014-02-20 15:50:00', 'Y', NULL, 0, NULL),
(14, 'CUTI',  'CT',  0,    '2013-01-01 00:00:00', 1,   12,   'Cuti Tahunan',                      '198306022010121004', '2013-10-11 21:00:00', 'Y', NULL, 0, NULL),
(15, 'CUTI',  'CB-1',2,    '2013-01-01 00:00:00', 1,   3,    'Cuti Bersalin Anak Ke 1-3',         '198306022010121004', '2014-02-20 15:35:00', 'Y', NULL, 0, NULL),
(16, 'CUTI',  'CB-2',3,    '2013-01-01 00:00:00', 4,   12,   'Cuti Bersalin Anak Ke >3',          '198306022010121004', '2014-02-20 15:40:00', 'Y', NULL, 0, NULL),
(19, 'HUKUMAN','HDR', 20,  '2013-01-01 00:00:00', 5,   5,    'Hukuman Disiplin Ringan',           '198306022010121004', '2014-02-20 15:45:00', 'Y', 'Teguran Lisan', 2, 'Bulan'),
(20, 'HUKUMAN','HDR', 20,  '2013-01-01 00:00:00', 6,   10,   'Hukuman Disiplin Ringan',           '198306022010121004', '2014-02-20 15:48:00', 'Y', 'Teguran Tertulis', 4, 'Bulan'),
(21, 'HUKUMAN','HDR', 20,  '2013-01-01 00:00:00', 11,  15,   'Hukuman Disiplin Ringan',           '198306022010121004', '2014-02-20 15:50:00', 'Y', 'Pernyataan Tidak Puas Secara Tertulis', 6, 'Bulan'),
(22, 'HUKUMAN','HDS', 50,  '2013-01-01 00:00:00', 16,  20,   'Hukuman Disiplin Sedang',           '198306022010121004', '2013-10-11 21:10:00', 'Y', 'Penundaan Kenaikan Gaji Berkala Selama 1 Tahun', 2, 'Bulan'),
(24, 'TLM', 'TLM-1', 0.5,  '2013-12-31 00:00:00', 1,   30,   'Terlambat Tk-1',                    '198306022010121004', '2013-10-11 20:48:21', 'Y', NULL, 0, NULL),
(25, 'TLM', 'TLM-2', 1,    '2013-12-31 00:00:00', 31,  60,   'Terlambat Tk-2',                    '198306022010121004', '2013-10-11 20:50:00', 'Y', NULL, 0, NULL),
(26, 'TLM', 'TLM-3', 1.25, '2013-12-31 00:00:00', 61,  90,   'Terlambat Tk-3',                    '198306022010121004', '2013-10-11 20:51:00', 'Y', NULL, 0, NULL),
(27, 'TLM', 'TLM-4', 1.5,  '2013-12-31 00:00:00', 91,  1000, 'Terlambat Tk-4',                    '198306022010121004', '2013-10-11 20:52:00', 'Y', NULL, 0, NULL),
(29, 'TLM', 'TLM-2', 1,    '2013-11-11 00:00:00', 1,   30,   'Terlambat Tk-2',                    '198306022010121004', '2013-10-11 20:50:00', 'Y', NULL, 0, NULL),
(30, 'TLM', 'TLM-3', 1.25, '2013-11-11 00:00:00', 31,  60,   'Terlambat Tk-3',                    '198306022010121004', '2013-10-11 20:51:00', 'Y', NULL, 0, NULL),
(31, 'TLM', 'TLM-4', 1.5,  '2013-11-11 00:00:00', 61,  1000, 'Terlambat Tk-4',                    '198306022010121004', '2013-10-11 20:52:00', 'Y', NULL, 0, NULL),
(33, 'SAKIT', 'S-5', 5,    '2014-02-10 00:00:00', 0,   0,    'Sakit Tanpa SU Dokter',             '198306022010121004', '2014-02-28 10:30:00', 'N', NULL, 0, NULL),
(34, 'CUTI',  'CAP-M2', 3, '2014-02-10 00:00:00', 0,   0,    'Cuti AP Keluarga Meninggal > 5 hari','198306022010121004','2014-02-24 12:00:00', 'Y', NULL, 0, NULL),
(35, 'CUTI',  'CAP', 3,    '2014-02-10 00:00:00', 0,   0,    'Cuti Alasan Penting Lainnya',       '198306022010121004', '2014-02-24 11:55:00', 'Y', NULL, 0, NULL),
(36, 'SAKIT', 'S-3', 2,    '2014-02-10 00:00:00', 0,   0,    'Sakit SU Dok Non Menkes 3-14 hr',   '198306022010121004', '2014-02-28 10:25:00', 'Y', NULL, 0, NULL),
(37, 'CUTI',  'CB-3', 2,   '2014-02-10 00:00:00', 0,   0,    'Cuti Bersalin Akibat Gugur Kandungan','198306022010121004','2014-02-27 10:50:00', 'Y', NULL, 0, NULL),
(38, 'CUTI',  'CAP-M1',0,  '2014-05-01 00:00:00', 0,   0,    'Cuti AP Keluarga Meninggal < 5 hari','198306022010121004','2014-06-20 14:30:00', 'Y', NULL, 0, NULL),
(39, 'TA',    'TA',   5,   '2013-07-01 00:00:00', 1,   3,    'Tidak Absen',                       '198306022010121004', '2015-02-01 00:00:00', 'N', NULL, 0, NULL),
(40, 'HUKUMAN','HDS', 50,  '2013-01-01 00:00:00', 21,  25,   'Hukuman Disiplin Sedang',           '198306022010121004', '2015-02-20 08:30:00', 'Y', 'Penundaan Kenaikan Pangkat Berkala Selama 1 Tahun', 4, 'Bulan'),
(41, 'HUKUMAN','HDS', 50,  '2013-01-01 00:00:00', 26,  30,   'Hukuman Disiplin Sedang',           '198306022010121004', '2015-02-20 08:35:00', 'Y', 'Penurunan Pangkat Setingkat Lebih Rendah Selama 1 Tahun', 6, 'Bulan'),
(42, 'HUKUMAN','HDB', 80,  '2013-01-01 00:00:00', 31,  35,   'Hukuman Disiplin Berat',            '198306022010121004', '2015-02-20 08:40:00', 'Y', 'Penurunan Pangkat Setinggi Lebih Rendah Selama 3 Tahun', 6, 'Bulan'),
(43, 'HUKUMAN','HDB', 80,  '2013-01-01 00:00:00', 36,  40,   'Hukuman Disiplin Berat',            '198306022010121004', '2015-02-20 08:45:00', 'Y', 'Pemindahan Dalam Rangka Penurunan Jabatan Setingkat Lebih Rendah', 8, 'Bulan'),
(44, 'HUKUMAN','HDB', 80,  '2013-01-01 00:00:00', 41,  45,   'Hukuman Disiplin Berat',            '198306022010121004', '2015-02-20 08:50:00', 'Y', 'Pembebasan Dari Jabatan', 10, 'Bulan'),
(45, 'HUKUMAN','HDB', 100, '2013-01-01 00:00:00', 46,  9999, 'Hukuman Disiplin Berat',            '198306022010121004', '2015-02-20 08:55:00', 'Y', 'Pemberhentian Dengan Hormat Tidak Atas Permintaan Sendiri', 0, '-');

INSERT INTO MF_POTONGAN (POT_ID, KATEGORI, TINGKAT, PERSEN_POT, TGL_MULAI, RANGE_AWAL, RANGE_AKHIR, NAMA_POT, UPDATE_BY, UPDATE_DATE, IS_PENDUKUNG) VALUES
(1,  'TLM', 'TLM-1', 0.5,  '2013-01-01 00:00:00', 1,   30,   'Terlambat Tk-1',                    '198306022010121004', '2013-10-11 20:48:21', 'Y'),
(2,  'TLM', 'TLM-2', 1,    '2013-01-01 00:00:00', 31,  60,   'Terlambat Tk-2',                    '198306022010121004', '2013-10-11 20:50:00', 'Y'),
(3,  'TLM', 'TLM-3', 1.25, '2013-01-01 00:00:00', 61,  90,   'Terlambat Tk-3',                    '198306022010121004', '2013-10-11 20:51:00', 'Y'),
(4,  'TLM', 'TLM-4', 1.5,  '2013-01-01 00:00:00', 91,  1000, 'Terlambat Tk-4',                    '198306022010121004', '2013-10-11 20:52:00', 'Y'),
(5,  'PSW', 'PSW-1', 0.5,  '2013-01-01 00:00:00', -1,  -30,  'Pulang Sebelum Waktu Tk-1',         '198306022010121004', '2013-10-11 20:53:00', 'Y'),
(6,  'PSW', 'PSW-2', 1,    '2013-01-01 00:00:00', -31, -60,  'Pulang Sebelum Waktu Tk-2',         '198306022010121004', '2013-10-11 20:54:00', 'Y'),
(7,  'PSW', 'PSW-3', 1.25, '2013-01-01 00:00:00', -61, -90,  'Pulang Sebelum Waktu Tk-3',         '198306022010121004', '2013-10-11 20:55:00', 'Y'),
(8,  'PSW', 'PSW-4', 1.5,  '2013-01-01 00:00:00', -91, -1000,'Pulang Sebelum Waktu Tk-4',         '198306022010121004', '2013-10-11 20:56:00', 'Y'),
(9,  'DINASLUAR', 'DL', 1, '2013-01-01 00:00:00', 1,   4,    'Dinas Luar',                        '198306022010121004', '2013-10-11 20:57:00', 'Y'),
(10, 'SAKIT', 'S-1', 0,    '2013-01-01 00:00:00', 1,   4,    'Sakit SU Dok 1-2 hr',               '198306022010121004', '2014-02-24 11:30:00', 'Y'),
(11, 'SAKIT', 'S-2', 2,    '2013-01-01 00:00:00', 15,  1000, 'Sakit SU Dok Menkes > 3 hr',        '198306022010121004', '2014-02-24 11:40:00', 'Y'),
(12, 'SAKIT', 'S-4', 3,    '2013-01-01 00:00:00', 1,   1000, 'Sakit SU Dok Non Menkes >14 hr',    '198306022010121004', '2014-02-28 10:20:00', 'Y'),
(13, 'IJIN',  'I',   5,    '2013-01-01 00:00:00', 1,   30,   'Ijin',                              '198306022010121004', '2014-02-20 15:50:00', 'Y'),
(14, 'CUTI',  'CT',  0,    '2013-01-01 00:00:00', 1,   12,   'Cuti Tahunan',                      '198306022010121004', '2013-10-11 21:00:00', 'Y'),
(15, 'CUTI',  'CB-1',2,    '2013-01-01 00:00:00', 1,   3,    'Cuti Bersalin Anak Ke 1-3',         '198306022010121004', '2014-02-20 15:35:00', 'Y'),
(16, 'CUTI',  'CB-2',3,    '2013-01-01 00:00:00', 4,   12,   'Cuti Bersalin Anak Ke >3',          '198306022010121004', '2014-02-20 15:40:00', 'Y'),
(19, 'HUKUMAN','HDR', 20,  '2013-01-01 00:00:00', 5,   5,    'Hukuman Disiplin Ringan',           '198306022010121004', '2014-02-20 15:45:00', 'Y'),
(20, 'HUKUMAN','HDR', 20,  '2013-01-01 00:00:00', 6,   10,   'Hukuman Disiplin Ringan',           '198306022010121004', '2014-02-20 15:48:00', 'Y'),
(21, 'HUKUMAN','HDR', 20,  '2013-01-01 00:00:00', 11,  15,   'Hukuman Disiplin Ringan',           '198306022010121004', '2014-02-20 15:50:00', 'Y'),
(22, 'HUKUMAN','HDS', 50,  '2013-01-01 00:00:00', 16,  20,   'Hukuman Disiplin Sedang',           '198306022010121004', '2013-10-11 21:10:00', 'Y'),
(24, 'TLM', 'TLM-1', 0.5,  '2013-12-31 00:00:00', 1,   30,   'Terlambat Tk-1',                    '198306022010121004', '2013-10-11 20:48:21', 'Y'),
(25, 'TLM', 'TLM-2', 1,    '2013-12-31 00:00:00', 31,  60,   'Terlambat Tk-2',                    '198306022010121004', '2013-10-11 20:50:00', 'Y'),
(26, 'TLM', 'TLM-3', 1.25, '2013-12-31 00:00:00', 61,  90,   'Terlambat Tk-3',                    '198306022010121004', '2013-10-11 20:51:00', 'Y'),
(27, 'TLM', 'TLM-4', 1.5,  '2013-12-31 00:00:00', 91,  1000, 'Terlambat Tk-4',                    '198306022010121004', '2013-10-11 20:52:00', 'Y'),
(29, 'TLM', 'TLM-2', 1,    '2013-11-11 00:00:00', 1,   30,   'Terlambat Tk-2',                    '198306022010121004', '2013-10-11 20:50:00', 'Y'),
(30, 'TLM', 'TLM-3', 1.25, '2013-11-11 00:00:00', 31,  60,   'Terlambat Tk-3',                    '198306022010121004', '2013-10-11 20:51:00', 'Y'),
(31, 'TLM', 'TLM-4', 1.5,  '2013-11-11 00:00:00', 61,  1000, 'Terlambat Tk-4',                    '198306022010121004', '2013-10-11 20:52:00', 'Y'),
(33, 'SAKIT', 'S-5', 5,    '2014-02-10 00:00:00', 0,   0,    'Sakit Tanpa SU Dokter',             '198306022010121004', '2014-02-28 10:30:00', 'N'),
(34, 'CUTI',  'CAP-M2', 3, '2014-02-10 00:00:00', 0,   0,    'Cuti AP Keluarga Meninggal > 5 hari','198306022010121004','2014-02-24 12:00:00', 'Y'),
(35, 'CUTI',  'CAP', 3,    '2014-02-10 00:00:00', 0,   0,    'Cuti Alasan Penting Lainnya',       '198306022010121004', '2014-02-24 11:55:00', 'Y'),
(36, 'SAKIT', 'S-3', 2,    '2014-02-10 00:00:00', 0,   0,    'Sakit SU Dok Non Menkes 3-14 hr',   '198306022010121004', '2014-02-28 10:25:00', 'Y'),
(37, 'CUTI',  'CB-3', 2,   '2014-02-10 00:00:00', 0,   0,    'Cuti Bersalin Akibat Gugur Kandungan','198306022010121004','2014-02-27 10:50:00', 'Y'),
(38, 'CUTI',  'CAP-M1',0,  '2014-05-01 00:00:00', 0,   0,    'Cuti AP Keluarga Meninggal < 5 hari','198306022010121004','2014-06-20 14:30:00', 'Y'),
(39, 'TA',    'TA',   5,   '2013-07-01 00:00:00', 1,   3,    'Tidak Absen',                       '198306022010121004', '2015-02-01 00:00:00', 'N'),
(40, 'HUKUMAN','HDS', 50,  '2013-01-01 00:00:00', 21,  25,   'Hukuman Disiplin Sedang',           '198306022010121004', '2015-02-20 08:30:00', 'Y'),
(41, 'HUKUMAN','HDS', 50,  '2013-01-01 00:00:00', 26,  30,   'Hukuman Disiplin Sedang',           '198306022010121004', '2015-02-20 08:35:00', 'Y'),
(42, 'HUKUMAN','HDB', 80,  '2013-01-01 00:00:00', 31,  35,   'Hukuman Disiplin Berat',            '198306022010121004', '2015-02-20 08:40:00', 'Y'),
(43, 'HUKUMAN','HDB', 80,  '2013-01-01 00:00:00', 36,  40,   'Hukuman Disiplin Berat',            '198306022010121004', '2015-02-20 08:45:00', 'Y'),
(44, 'HUKUMAN','HDB', 80,  '2013-01-01 00:00:00', 41,  45,   'Hukuman Disiplin Berat',            '198306022010121004', '2015-02-20 08:50:00', 'Y'),
(45, 'HUKUMAN','HDB', 100, '2013-01-01 00:00:00', 46,  9999, 'Hukuman Disiplin Berat',            '198306022010121004', '2015-02-20 08:55:00', 'Y');

INSERT INTO MF_CLASS (CLASS_ID, TUNJANGAN, ID, TGL_MULAI, UPDATE_IN_BY, UPDATE_DATE, DOKREFF) VALUES
(7,  2304000,  1,  '2012-11-01 00:00:00', '198008292010121001', '2013-11-17 09:30:00', '-'),
(13, 6023000,  2,  '2012-11-01 00:00:00', '198008292010121001', '2013-11-17 09:35:00', '-'),
(9,  2915000,  3,  '2012-11-01 00:00:00', '198008292010121001', '2013-11-17 09:32:00', '-'),
(8,  2535000,  4,  '2012-11-01 00:00:00', '198008292010121001', '2013-11-17 09:31:00', '-'),
(6,  2095000,  5,  '2012-11-01 00:00:00', '198008292010121001', '2013-11-17 09:28:00', '-'),
(5,  1904000,  6,  '2012-11-01 00:00:00', '198008292010121001', '2013-11-17 09:29:00', '-'),
(10, 3352000,  7,  '2012-11-01 00:00:00', '198008292010121001', '2013-11-17 09:37:00', '-'),
(11, 3855000,  8,  '2012-11-01 00:00:00', '198008292010121001', '2013-11-17 09:40:00', '-'),
(12, 4819000,  9,  '2012-11-01 00:00:00', '198008292010121001', '2013-11-17 09:42:00', '-'),
(1,  1968000,  10, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:20:00', '-'),
(2,  2089000,  11, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:22:00', '-'),
(3,  2216000,  12, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:25:00', '-'),
(4,  2350000,  13, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:27:00', '-'),
(5,  2493000,  14, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:29:00', '-'),
(6,  2702000,  15, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:31:00', '-'),
(7,  2928000,  16, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:33:00', '-'),
(8,  3319000,  17, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:35:00', '-'),
(9,  3781000,  18, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:37:00', '-'),
(10, 4551000,  19, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:40:00', '-'),
(10, 4551000,  20, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:42:00', '-'),
(11, 5183000,  21, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:44:00', '-'),
(12, 7271000,  22, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:46:00', '-'),
(13, 8562000,  23, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:48:00', '-'),
(14, 11670000, 24, '2014-01-16 00:00:00', '198008292010121001', '2015-01-15 10:50:00', '-'),
(13, 8562000,  25, '2015-02-01 00:00:00', '198501232009122002', '2015-02-20 09:15:00', '-'),
(9,  3781000,  26, '2015-02-01 00:00:00', '198501232009122002', '2015-02-20 09:20:00', '-'),
(8,  3319000,  27, '2015-02-01 00:00:00', '198501232009122002', '2015-02-20 09:25:00', '-'),
(7,  2928000,  28, '2015-02-01 00:00:00', '198501232009122002', '2015-02-20 09:30:00', '-'),
(6,  2702000,  29, '2015-02-01 00:00:00', '198501232009122002', '2015-02-20 09:35:00', '-'),
(5,  2493000,  31, '2015-02-01 00:00:00', '198501232009122002', '2015-02-20 09:40:00', '-'),
(1,  2531250, 32, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:10:00', 'PERBAN NO 4 TAHUN 2024'),
(2,  2708250, 33, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:12:00', 'PERBAN NO 4 TAHUN 2024'),
(3,  2898000, 34, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:14:00', 'PERBAN NO 4 TAHUN 2024'),
(4,  2985000, 35, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:16:00', 'PERBAN NO 4 TAHUN 2024'),
(5,  3134250, 36, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:18:00', 'PERBAN NO 4 TAHUN 2024'),
(6,  3510400, 37, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:20:00', 'PERBAN NO 4 TAHUN 2024'),
(7,  3915950, 38, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:22:00', 'PERBAN NO 4 TAHUN 2024'),
(8,  4595150, 39, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:24:00', 'PERBAN NO 4 TAHUN 2024'),
(9,  5079200, 40, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:26:00', 'PERBAN NO 4 TAHUN 2024'),
(10, 5979200, 41, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:28:00', 'PERBAN NO 4 TAHUN 2024'),
(11, 8757600, 42, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:30:00', 'PERBAN NO 4 TAHUN 2024'),
(12, 9896000, 43, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:32:00', 'PERBAN NO 4 TAHUN 2024'),
(13, 10936000,44, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:34:00', 'PERBAN NO 4 TAHUN 2024'),
(14, 17064000,45, '2024-01-01 00:00:00', '198411222009121001', '2024-12-10 10:36:00', 'PERBAN NO 4 TAHUN 2024');

INSERT INTO MF_TUNJANGAN (TUNJANGAN_ID, JENIS_TUNJANGAN, ACTIVITY, NOMINAL, TGL_MULAI, HARI_KERJA, FUNGSIONAL, UPDATE_BY, UPDATE_DATE, DOKREFF, STATUS_PEG, UNIT_KERJA_ID, SHIFT) VALUES
(1, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '1', 'LONG'),
(2, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '1', 'LONG'),
(3, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '1', 'LONG'),
(4, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '1', 'LONG'),
(5, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '1', 'LONG'),
(6, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '1', 'LONG'),
(7, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '1', 'LONG'),
(8, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '1', 'LONG'),
(9, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '1', 'LONG'),
(10, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '1', 'LONG'),
(11, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '1', 'LONG'),
(12, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '1', 'LONG'),
(13, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '1', 'LONG'),
(14, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '1', 'LONG'),
(17, 'U.Makan', 'Intern', 37000, '2023-01-01', 0, 'All', '197803022007122002', '2022-10-12 09:45:00', '72/PMK.05/2023', NULL, NULL, NULL),
(18, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '1', 'LONG'),
(19, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '1', 'LONG'),
(20, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '1', 'LONG'),
(21, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '1', 'LONG'),
(22, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '1', 'LONG'),
(23, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '1', 'LONG'),
(24, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '1', 'LONG'),
(25, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '1', 'LONG'),
(26, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '1', 'LONG'),
(27, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '1', 'LONG'),
(28, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '1', 'LONG'),
(29, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '1', 'LONG'),
(30, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '1', 'LONG'),
(31, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '1', 'LONG'),
(32, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '1', '1'),
(33, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '1', '1'),
(34, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '1', '1'),
(35, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '1', '1'),
(36, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '1', '1'),
(37, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '1', '1'),
(38, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '1', '1'),
(39, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '1', '1'),
(40, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '1', '1'),
(41, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '1', '1'),
(42, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '1', '1'),
(43, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '1', '1'),
(44, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '1', '1'),
(45, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '1', '1'),
(46, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '1', '1'),
(47, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '1', '1'),
(48, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '1', '1'),
(49, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '1', '1'),
(50, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '1', '1'),
(51, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '1', '1'),
(52, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '1', '1'),
(53, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '1', '1'),
(54, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '1', '1'),
(55, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '1', '1'),
(56, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '1', '1'),
(57, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '1', '1'),
(58, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '1', '1'),
(59, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '1', '1'),
(60, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '1', '2'),
(61, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '1', '2'),
(63, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '1', '2'),
(64, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '1', '2'),
(65, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '1', '2'),
(66, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '1', '2'),
(67, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '1', '2'),
(68, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '1', '2'),
(69, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '1', '2'),
(70, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '1', '2'),
(71, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '1', '2'),
(72, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '1', '2'),
(73, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '1', '2'),
(74, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '1', '2'),
(75, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '1', '2'),
(76, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '1', '2'),
(77, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '1', '2'),
(78, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '1', '2'),
(79, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '1', '2'),
(80, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '1', '2'),
(82, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '1', '2'),
(83, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '1', '2'),
(84, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '1', '2'),
(85, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '1', '2'),
(86, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '1', '2'),
(87, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '1', '2'),
(88, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '2', 'LONG'),
(89, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '2', 'LONG'),
(90, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '2', 'LONG'),
(91, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '2', 'LONG'),
(92, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '2', 'LONG'),
(93, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '2', 'LONG'),
(94, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '2', 'LONG'),
(95, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '2', 'LONG'),
(96, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '2', 'LONG'),
(97, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '2', 'LONG'),
(98, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '2', 'LONG'),
(99, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '2', 'LONG'),
(100, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '2', 'LONG'),
(101, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '2', 'LONG'),
(102, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '2', 'LONG'),
(103, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '2', 'LONG'),
(104, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '2', 'LONG'),
(105, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '2', 'LONG'),
(106, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '2', 'LONG'),
(107, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '2', 'LONG'),
(108, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '2', 'LONG'),
(109, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '2', 'LONG'),
(110, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '2', 'LONG'),
(111, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '2', 'LONG'),
(112, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '2', 'LONG'),
(113, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '2', 'LONG'),
(114, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '2', 'LONG'),
(115, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '2', 'LONG'),
(116, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '2', '1'),
(117, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '2', '1'),
(118, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '2', '1'),
(119, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '2', '1'),
(120, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '2', '1'),
(121, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '2', '1'),
(122, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '2', '1'),
(123, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '2', '1'),
(124, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '2', '1'),
(125, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '2', '1'),
(126, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '2', '1'),
(127, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '2', '1'),
(128, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '2', '1'),
(129, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '2', '1'),
(130, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '2', '1'),
(131, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '2', '1'),
(132, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '2', '1'),
(133, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '2', '1'),
(134, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '2', '1'),
(135, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '2', '1'),
(137, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '2', '1'),
(138, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '2', '1'),
(139, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '2', '1'),
(140, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '2', '1'),
(141, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '2', '1'),
(142, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '2', '1'),
(143, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '2', '1'),
(144, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '2', '2'),
(145, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '2', '2'),
(146, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '2', '2'),
(147, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '2', '2'),
(148, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '2', '2'),
(149, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '2', '2'),
(150, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '2', '2'),
(152, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '2', '2'),
(153, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '2', '2'),
(154, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '2', '2'),
(155, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '2', '2'),
(156, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '2', '2'),
(157, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '2', '2'),
(158, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '2', '2'),
(159, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '2', '2'),
(160, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '2', '2'),
(161, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '2', '2'),
(162, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '2', '2'),
(163, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '2', '2'),
(164, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '2', '2'),
(165, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '2', '2'),
(166, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '2', '2'),
(167, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '2', '2'),
(168, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '2', '2'),
(169, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '2', '2'),
(170, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '2', '2'),
(171, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '2', '2'),
(172, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '3', 'LONG'),
(173, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '3', 'LONG'),
(174, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '3', 'LONG'),
(175, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '3', 'LONG'),
(176, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '3', 'LONG'),
(177, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '3', 'LONG'),
(178, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '3', 'LONG'),
(179, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '3', 'LONG'),
(180, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '3', 'LONG'),
(181, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '3', 'LONG'),
(182, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '3', 'LONG'),
(183, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '3', 'LONG'),
(184, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '3', 'LONG'),
(185, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '3', 'LONG'),
(186, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '3', 'LONG'),
(187, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '3', 'LONG'),
(188, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '3', 'LONG'),
(189, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '3', 'LONG'),
(190, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '3', 'LONG'),
(191, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '3', 'LONG'),
(192, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '3', 'LONG'),
(193, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '3', 'LONG'),
(194, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '3', 'LONG'),
(195, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '3', 'LONG'),
(196, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '3', 'LONG'),
(197, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '3', 'LONG'),
(198, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '3', 'LONG'),
(199, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '3', 'LONG'),
(200, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '3', '1'),
(201, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '3', '1'),
(202, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '3', '1'),
(203, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '3', '1'),
(204, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '3', '1'),
(205, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '3', '1'),
(207, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '3', '1'),
(208, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '3', '1'),
(209, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '3', '1'),
(210, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '3', '1'),
(211, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '3', '1'),
(212, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '3', '1'),
(213, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '3', '1'),
(214, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '3', '1'),
(215, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '3', '1'),
(216, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '3', '1'),
(217, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '3', '1'),
(218, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '3', '1'),
(219, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '3', '1'),
(220, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '3', '1'),
(221, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '3', '1'),
(222, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '3', '1'),
(223, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '3', '1'),
(224, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '3', '1'),
(225, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '3', '1'),
(226, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '3', '1'),
(228, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '3', '2'),
(229, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '3', '2'),
(230, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '3', '2'),
(231, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '3', '2'),
(232, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '3', '2'),
(233, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '3', '2'),
(234, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '3', '2'),
(235, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '3', '2'),
(236, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '3', '2'),
(237, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '3', '2'),
(238, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '3', '2'),
(239, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '3', '2'),
(240, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '3', '2'),
(241, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '3', '2'),
(242, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '3', '2'),
(243, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '3', '2'),
(244, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '3', '2'),
(245, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '3', '2'),
(246, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '3', '2'),
(247, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '3', '2'),
(248, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '3', '2'),
(249, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '3', '2'),
(250, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '3', '2'),
(251, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '3', '2'),
(252, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '3', '2'),
(253, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '3', '2'),
(254, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '3', '2'),
(255, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '3', '2'),
(256, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '4', 'LONG'),
(257, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '4', 'LONG'),
(258, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '4', 'LONG'),
(259, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '4', 'LONG'),
(260, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '4', 'LONG'),
(261, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '4', 'LONG'),
(262, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '4', 'LONG'),
(263, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '4', 'LONG'),
(264, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '4', 'LONG'),
(265, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '4', 'LONG'),
(266, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '4', 'LONG'),
(267, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '4', 'LONG'),
(268, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '4', 'LONG'),
(269, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '4', 'LONG'),
(270, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '4', 'LONG'),
(271, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '4', 'LONG'),
(272, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '4', 'LONG'),
(273, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '4', 'LONG'),
(274, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '4', 'LONG'),
(275, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '4', 'LONG'),
(276, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '4', 'LONG'),
(278, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '4', 'LONG'),
(279, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '4', 'LONG'),
(280, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '4', 'LONG'),
(281, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '4', 'LONG'),
(282, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '4', 'LONG'),
(283, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '4', 'LONG'),
(284, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '4', '1'),
(285, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '4', '1'),
(286, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '4', '1'),
(287, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '4', '1'),
(288, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '4', '1'),
(289, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '4', '1'),
(290, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '4', '1'),
(291, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '4', '1'),
(292, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '4', '1'),
(293, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '4', '1'),
(294, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '4', '1'),
(295, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '4', '1'),
(296, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '4', '1'),
(297, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '4', '1'),
(298, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '4', '1'),
(299, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '4', '1'),
(300, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '4', '1'),
(301, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '4', '1'),
(302, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '4', '1'),
(303, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '4', '1'),
(304, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '4', '1'),
(305, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '4', '1'),
(306, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '4', '1'),
(307, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '4', '1'),
(308, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '4', '1');

INSERT INTO MF_TUNJANGAN (TUNJANGAN_ID, JENIS_TUNJANGAN, ACTIVITY, NOMINAL, TGL_MULAI, HARI_KERJA, FUNGSIONAL, UPDATE_BY, UPDATE_DATE, DOKREFF, STATUS_PEG, UNIT_KERJA_ID, SHIFT) VALUES
(309, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '4', '1'),
(310, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '4', '1'),
(311, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '4', '1'),
(312, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '4', '2'),
(313, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '4', '2'),
(314, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '4', '2'),
(315, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '4', '2'),
(316, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '4', '2'),
(317, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '4', '2'),
(318, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '4', '2'),
(319, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '4', '2'),
(320, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '4', '2'),
(321, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '4', '2'),
(322, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '4', '2'),
(323, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '4', '2'),
(324, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '4', '2'),
(325, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '4', '2'),
(326, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '4', '2'),
(327, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '4', '2'),
(328, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '4', '2'),
(329, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '4', '2'),
(330, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '4', '2'),
(331, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '4', '2'),
(332, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '4', '2'),
(334, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '4', '2'),
(335, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '4', '2'),
(336, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '4', '2'),
(337, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '4', '2'),
(338, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '4', '2'),
(339, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '4', '2'),
(340, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '6', 'LONG'),
(341, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '6', 'LONG'),
(342, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '6', 'LONG'),
(343, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '6', 'LONG'),
(344, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '6', 'LONG'),
(345, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '6', 'LONG'),
(346, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '6', 'LONG'),
(347, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '6', 'LONG'),
(348, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '6', 'LONG'),
(349, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '6', 'LONG'),
(350, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '6', 'LONG'),
(351, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '6', 'LONG'),
(352, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '6', 'LONG'),
(353, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '6', 'LONG'),
(354, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '6', 'LONG'),
(355, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '6', 'LONG'),
(356, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '6', 'LONG'),
(357, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '6', 'LONG'),
(358, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '6', 'LONG'),
(359, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '6', 'LONG'),
(360, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '6', 'LONG'),
(361, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '6', 'LONG'),
(362, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '6', 'LONG'),
(363, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '6', 'LONG'),
(364, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '6', 'LONG'),
(365, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '6', 'LONG'),
(366, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '6', 'LONG'),
(367, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '6', 'LONG'),
(368, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '6', '1'),
(369, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '6', '1'),
(370, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '6', '1'),
(371, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '6', '1'),
(372, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '6', '1'),
(373, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '6', '1'),
(374, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '6', '1'),
(375, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '6', '1'),
(376, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '6', '1'),
(377, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '6', '1'),
(378, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '6', '1'),
(379, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '6', '1'),
(380, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '6', '1'),
(381, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '6', '1'),
(382, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '6', '1'),
(383, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '6', '1'),
(384, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '6', '1'),
(385, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '6', '1'),
(386, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '6', '1'),
(387, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '6', '1'),
(388, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '6', '1'),
(389, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '6', '1'),
(390, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '6', '1'),
(391, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '6', '1'),
(392, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '6', '1'),
(393, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '6', '1'),
(394, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '6', '1'),
(395, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '6', '1'),
(396, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '6', '2'),
(398, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '6', '2'),
(399, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '6', '2'),
(400, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '6', '2'),
(401, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '6', '2'),
(402, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '6', '2'),
(403, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '6', '2'),
(404, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '6', '2'),
(405, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '6', '2'),
(406, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '6', '2'),
(407, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '6', '2'),
(408, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '6', '2'),
(409, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '6', '2'),
(410, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '6', '2'),
(411, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '6', '2'),
(412, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '6', '2'),
(413, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '6', '2'),
(414, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '6', '2'),
(415, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '6', '2'),
(416, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '6', '2'),
(417, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '6', '2'),
(418, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '6', '2'),
(419, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '6', '2'),
(420, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '6', '2'),
(421, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '6', '2'),
(422, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '6', '2'),
(423, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '6', '2'),
(424, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '8', 'LONG'),
(425, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '8', 'LONG'),
(426, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '8', 'LONG'),
(427, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '8', 'LONG'),
(428, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '8', 'LONG'),
(429, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '8', 'LONG'),
(430, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '8', 'LONG'),
(432, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '8', 'LONG'),
(433, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '8', 'LONG'),
(434, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '8', 'LONG'),
(435, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '8', 'LONG'),
(436, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '8', 'LONG'),
(437, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '8', 'LONG'),
(438, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '8', 'LONG'),
(439, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '8', 'LONG'),
(440, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '8', 'LONG'),
(441, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '8', 'LONG'),
(442, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '8', 'LONG'),
(443, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '8', 'LONG'),
(444, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '8', 'LONG'),
(445, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '8', 'LONG'),
(446, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '8', 'LONG'),
(447, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '8', 'LONG'),
(448, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '8', 'LONG'),
(449, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '8', 'LONG'),
(450, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '8', 'LONG'),
(451, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '8', 'LONG'),
(452, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '8', '1'),
(453, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '8', '1'),
(454, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '8', '1'),
(455, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '8', '1'),
(456, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '8', '1'),
(457, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '8', '1'),
(458, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '8', '1'),
(459, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '8', '1'),
(460, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '8', '1'),
(461, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '8', '1'),
(462, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '8', '1'),
(463, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '8', '1'),
(464, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '8', '1'),
(465, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '8', '1'),
(466, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '8', '1'),
(467, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '8', '1'),
(468, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '8', '1'),
(469, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '8', '1'),
(470, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '8', '1'),
(471, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '8', '1'),
(472, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '8', '1'),
(473, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '8', '1'),
(474, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '8', '1'),
(475, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '8', '1'),
(476, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '8', '1'),
(477, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '8', '1'),
(478, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '8', '1'),
(479, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '8', '1'),
(480, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '8', '2'),
(481, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '8', '2'),
(482, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '8', '2'),
(483, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '8', '2'),
(484, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '8', '2'),
(485, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '8', '2'),
(486, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '8', '2'),
(487, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '8', '2'),
(488, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '8', '2'),
(490, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '8', '2'),
(491, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '8', '2'),
(492, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '8', '2'),
(493, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '8', '2'),
(494, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '8', '2'),
(495, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '8', '2'),
(496, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '8', '2'),
(497, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '8', '2'),
(498, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '8', '2'),
(499, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '8', '2'),
(500, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '8', '2'),
(502, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '8', '2'),
(503, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '8', '2'),
(504, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '8', '2'),
(505, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '8', '2'),
(506, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '8', '2'),
(507, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '8', '2'),
(508, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '5', 'LONG'),
(509, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '5', 'LONG'),
(510, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '5', 'LONG'),
(511, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '5', 'LONG'),
(512, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '5', 'LONG'),
(513, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '5', 'LONG'),
(514, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '5', 'LONG'),
(515, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '5', 'LONG'),
(516, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '5', 'LONG'),
(517, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '5', 'LONG'),
(518, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '5', 'LONG'),
(519, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '5', 'LONG'),
(520, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '5', 'LONG'),
(521, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '5', 'LONG'),
(522, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '5', 'LONG'),
(523, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '5', 'LONG'),
(524, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '5', 'LONG'),
(525, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '5', 'LONG'),
(526, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '5', 'LONG'),
(527, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '5', 'LONG'),
(528, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '5', 'LONG'),
(529, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '5', 'LONG'),
(530, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '5', 'LONG'),
(531, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '5', 'LONG'),
(532, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '5', 'LONG'),
(533, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '5', 'LONG'),
(534, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 2, '5', 'LONG'),
(535, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 2, '5', 'LONG'),
(536, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 1, '5', '1'),
(537, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 1, '5', '1'),
(538, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 1, '5', '1'),
(539, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 1, '5', '1'),
(540, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 1, '5', '1'),
(541, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 1, '5', '1'),
(542, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '5', '1'),
(543, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '5', '1'),
(544, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 1, '5', '1'),
(545, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 1, '5', '1'),
(546, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 1, '5', '1'),
(547, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 1, '5', '1'),
(548, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'PW', NULL, NULL, '-', 1, '5', '1'),
(549, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'PW', NULL, NULL, '-', 1, '5', '1'),
(550, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Kom', NULL, NULL, '-', 2, '5', '1'),
(551, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Kom', NULL, NULL, '-', 2, '5', '1'),
(552, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Medis', NULL, NULL, '-', 2, '5', '1'),
(553, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Medis', NULL, NULL, '-', 2, '5', '1'),
(554, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'Humas', NULL, NULL, '-', 2, '5', '1'),
(555, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Humas', NULL, NULL, '-', 2, '5', '1'),
(557, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '5', '1'),
(558, 'U.Transport', 'Piket Siaga', 60000, '2022-01-01', 1, 'ABK', NULL, NULL, '-', 2, '5', '1'),
(559, 'U.Transport', 'Piket Siaga', 62500, '2022-01-01', 0, 'ABK', NULL, NULL, '-', 2, '5', '1'),
(560, 'U.Transport', 'Piket Siaga', 70000, '2022-01-01', 1, 'KGR', NULL, NULL, '-', 2, '5', '1'),
(561, 'U.Transport', 'Piket Siaga', 72500, '2022-01-01', 0, 'KGR', NULL, NULL, '-', 2, '5', '1'),
(721, 'U.Transport', 'Piket Siaga', 30000, '2021-01-01', 1, 'Kom', '198008292010121001', '2015-06-02 07:20:00', '-', 2, '6', '1'),
(729, 'U.Transport', 'Piket Siaga', 30000, '2021-01-01', 1, 'Kom', '198008292010121001', '2015-06-02 07:25:00', '-', 2, '5', '1'),
(759, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Kom', '198008292010121001', '2015-06-02 08:10:00', '-', 2, '5', '2'),
(760, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '1', '1'),
(761, 'U.Transport', 'Piket Siaga', 30000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '1', '1'),
(762, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '1', '2'),
(763, 'U.Transport', 'Piket Siaga', 35000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '1', '2'),
(764, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '2', '1'),
(765, 'U.Transport', 'Piket Siaga', 30000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '2', '1'),
(766, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '2', '2'),
(767, 'U.Transport', 'Piket Siaga', 35000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '2', '2'),
(768, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '3', '1'),
(769, 'U.Transport', 'Piket Siaga', 30000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '3', '1'),
(770, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '3', '2'),
(771, 'U.Transport', 'Piket Siaga', 35000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '3', '2'),
(776, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '6', '1'),
(777, 'U.Transport', 'Piket Siaga', 30000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '6', '1'),
(778, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '6', '2'),
(779, 'U.Transport', 'Piket Siaga', 35000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '6', '2'),
(780, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '8', '1'),
(781, 'U.Transport', 'Piket Siaga', 30000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '8', '1'),
(782, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 1, '8', '2'),
(783, 'U.Transport', 'Piket Siaga', 35000, '2021-01-01', 1, 'Rescuer', NULL, NULL, '-', 2, '8', '2'),
(788, 'U.Transport', 'Piket Siaga', 75000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '1', '1'),
(789, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '1', '1'),
(790, 'U.Transport', 'Piket Siaga', 75000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '1', '2'),
(791, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '1', '2'),
(792, 'U.Transport', 'Piket Siaga', 75000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '2', '1'),
(793, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '2', '1'),
(794, 'U.Transport', 'Piket Siaga', 75000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '2', '2'),
(795, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '2', '2'),
(796, 'U.Transport', 'Piket Siaga', 75000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '3', '1'),
(797, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '3', '1'),
(798, 'U.Transport', 'Piket Siaga', 75000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '3', '2'),
(799, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '3', '2'),
(804, 'U.Transport', 'Piket Siaga', 75000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '6', '1'),
(805, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '6', '1'),
(806, 'U.Transport', 'Piket Siaga', 75000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '6', '2'),
(807, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '6', '2'),
(808, 'U.Transport', 'Piket Siaga', 75000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '8', '1'),
(809, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '8', '1'),
(810, 'U.Transport', 'Piket Siaga', 75000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 1, '8', '2'),
(811, 'U.Transport', 'Piket Siaga', 60000, '2021-01-01', 0, 'Rescuer', NULL, NULL, '-', 2, '8', '2'),
(816, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'ABK', NULL, NULL, '-', 1, '1', '1'),
(824, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'ABK', NULL, NULL, '-', 1, '3', '1'),
(825, 'U.Transport', 'Piket Siaga', 30000, '2021-01-01', 1, 'ABK', '198008292010121001', '2015-06-02 09:30:00', '-', 2, '3', '1'),
(826, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'ABK', NULL, NULL, '-', 1, '3', '2'),
(827, 'U.Transport', 'Piket Siaga', 35000, '2021-01-01', 1, 'ABK', '198008292010121001', '2015-06-02 09:35:00', '-', 2, '3', '2'),
(828, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'ABK', NULL, NULL, '-', 1, '4', '1'),
(829, 'U.Transport', 'Piket Siaga', 30000, '2021-01-01', 1, 'ABK', '198008292010121001', '2015-06-02 08:45:00', '-', 2, '4', '1'),
(830, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'ABK', NULL, NULL, '-', 1, '4', '2'),
(831, 'U.Transport', 'Piket Siaga', 35000, '2021-01-01', 1, 'ABK', '198008292010121001', '2015-06-02 08:50:00', '-', 2, '4', '2'),
(832, 'U.Transport', 'Piket Siaga', 40000, '2021-01-01', 1, 'ABK', NULL, NULL, '-', 1, '6', '1');



INSERT INTO MF_SHIFT (SHIFT_ID, TRAKSAKSI_ID, NAMA_SHIFT, JADWAL, START_SHIFT, END_SHIFT, TGL_MULAI_BERLAKU) VALUES 
('P', 1, 'Pagi', 'Senin-Jumat', '2023-01-01 07:00:00', '2023-01-01 15:00:00', '2023-01-01');

INSERT INTO MF_HOST_NAME_FP (UNIT_KERJA_ID, HOST_NAME_FP) VALUES 
(1, '192.168.1.100');

INSERT INTO MF_EMAIL_SEND (EMAIL_SEND, PASS_SEND, SMTP_SEND, PORT_SENT) VALUES 
('admin@basarnas.go.id', 'pass123', 'smtp.gmail.com', '587');

INSERT INTO MF_PRIORITY_TRANSAKSI (MODUL, PRIORITY_TRANSAKSI, TRANSAKSI, INISIAL_TRANSAKSI) VALUES 
('Absensi', 1, 'Masuk', 'IN');

INSERT INTO MF_SU (NIP, NAMA, PASS) VALUES 
('admin', 'Administrator', 'admin123');

INSERT INTO MF_TIM_SIAGA (GUID_TIM, NO_URUT_TIM, NAMA_TIM, ID_UNIT_KERJA, BULAN_PERIODE, TAHUN_PERIODE, FUNGSIONAL_TIM, SHIFT, IS_AKTIF) VALUES 
('tim-001', 1, 'Tim Alpha', '1', '01', '2023', 'SAR', 'P', '1');

-- 2. Tabel dengan FK ke tabel di atas (pastikan data referensi sudah ada)
INSERT INTO PERUBAHAN_JABATAN (JABATAN_ID_BARU, JABATAN_ID) VALUES 
(10, NULL);  -- Nanti JABATAN_ID akan diisi setelah MF_JABATAN dibuat

INSERT INTO MF_JABATAN (JABATAN_ID, JABATAN_ID_BARU, GROUP_JABATAN_ID, SUB_GROUP_JABATAN_ID, JABATAN_MANAGE, NAMA_JABATAN, URUT_JABATAN, TYPE_JABATAN, IS_USE) VALUES 
(1, 10, 1, 1, NULL, 'Kepala Kantor', 1, 'Struktural', 1);

-- Update PERUBAHAN_JABATAN dengan JABATAN_ID yang sudah ada
UPDATE PERUBAHAN_JABATAN SET JABATAN_ID = 1 WHERE JABATAN_ID_BARU = 10;

INSERT INTO MF_JABATAN_KEGIATAN (ITEM_ID, JABATAN_ID, DESKRIPSI, AK, QTY, MUTU, WAKTU, BIAYA, TYPE, UNSUR, SATUAN_QTY, SATUAN_MUTU, SATUAN_WAKTU) VALUES 
('KEG-001', 1, 'Menyusun laporan', 100, 1, 100, '2023-01-01 08:00:00', 0, 1, 'Utama', 'Laporan', 'Persen', 'Jam');

INSERT INTO MF_JOBLIST (GROUP_JABATAN_ID, ITEM_ID, DESKRIPSI, AK, QTY, MUTU, WAKTU, BIAYA) VALUES 
(1, 'KEG-001', 'Joblist laporan', 100, 1, 100, '2023-01-01 08:00:00', 0);

INSERT INTO MF_KLASIFIKASI_SURAT (KLASIFIKASI_ID, TYPE_SPRIN_ID, KLASIFIKASI_NAME) VALUES 
('A', 'SPRIN', 'Biasa'), ('B', 'SPT', 'Segera');

INSERT INTO MF_LOAD_FINGER (TRAKSAKSI_ID, START_FINGER, END_FINGER, TGL_MULAI_BERLAKU, SHIFT_KERJA) VALUES 
(1, '2023-01-01 06:00:00', '2023-01-01 09:00:00', '2023-01-01', '1');

INSERT INTO MF_TR (TRAKSAKSI_ID, JAM_LOAD) VALUES 
(1, '2023-01-01 06:00:00');

INSERT INTO MF_CONFIG (TRAKSAKSI_ID, CONFIG_NAME, TGL_JAM1, TGL_JAM2) VALUES 
(1, 'AppConfig', '2023-01-01 07:00:00', '2023-01-01 16:00:00');

INSERT INTO MF_FIELD_CARI (FIELD_ID, TRAKSAKSI_ID, FIELD_NAME, TYPE_CARI, IS_CMB, NO_URUT, APLIKASI) VALUES 
('fld001', 1, 'NIP', 'text', 'N', 1, 'Absensi');

INSERT INTO MF_FORM (FORM_ID, FORM_NAME, FORM_TYPE, NO_URUT, BERKAS, PANEL_PAGE, IMG_URL, NO_URUT_PANEL, MODUL, PARENT_FORM, MODEL, ICON_FA, HIRARKI_LV) VALUES 
('form1', 'Dashboard', 'Main', 1, 'dashboard', 'home', 'home.png', 1, 'Absensi', NULL, 1, 'fa-home', 1);

INSERT INTO MF_FORM_NEW (NEW_FORM_ID, NEW_FORM_NAME, NEW_FORM_TYPE, NO_URUT, BERKAS, PANEL_PAGE, IMG_URL, NO_URUT_PANEL, MODUL, PARENT_FORM, MODEL, ICONFA, HIRARKI_LV) VALUES 
('newform1', 'Laporan', 'Sub', 2, 'report', 'report', 'report.png', 2, 'Absensi', 'form1', 1, 'fa-chart', 2);

INSERT INTO KALENDER (TGL_KERJA, IS_LIBUR, KET) VALUES 
('2023-01-02 00:00:00', 'N', 'Hari Kerja'),
('2023-01-01 00:00:00', 'Y', 'Tahun Baru');

INSERT INTO TIME_RECORDER (FINGER_ID, WAKTU, STATUS, MESIN, KET, TRANSAKSI) VALUES 
(1, '2023-01-02 07:30:00', 'IN', 'Mesin1', 'Datang', 'Masuk'),
(2, '2023-01-02 16:30:00', 'OUT', 'Mesin1', 'Pulang', 'Keluar');

INSERT INTO PEGAWAI (NIP, ABSENSI_ID, ESELON, TUNJANGAN_ID, CLASS_ID, UNIT_KERJA_ID, JABATAN_ID, GOL_ID, NAMA, NO_TELP, PANGKAT, JABATAN, MAIL, PASS, JENIS_KEL, TGL_LAHIR, AGAMA, STATUS_PEG) VALUES 
('198001012000011001', 1, 'III/c', 1, 1, 1, 1, 1, 'Andi Setiawan', '08123456789', 'Penata', 'Kepala Kantor', 'andi@basarnas.go.id', 'pass123', 'L', '1980-01-01 00:00:00', 'Islam', 1),
('199002022010012002', 2, 'III/b', 1, 1, 2, 1, 2, 'Siti Aminah', '08129876543', 'Penata Muda', 'Staf', 'siti@basarnas.go.id', 'pass456', 'P', '1990-02-02 00:00:00', 'Islam', 1);

INSERT INTO USER_ACCOUNT (NIP, INIT_LEVEL, MODUL) VALUES 
('198001012000011001', 1, 'Absensi'),
('199002022010012002', 2, 'Absensi');

INSERT INTO HAK_AKSES_FORM (FORM_ID, NIP, IS_AKSES, TYPE_AKSES, MODUL) VALUES 
('form1', '198001012000011001', 'Y', 'RW', 'Absensi');

INSERT INTO HAK_AKSES_TYPE_SPRIN (TYPE_SPRIN_ID, NIP, TYPE_AKSES) VALUES 
('SPRIN', '198001012000011001', 'RW');

INSERT INTO SPRIN_HEADER (GUID_SPRIN, TYPE_SPRIN_ID, ROLE_NUMBER, TGL_SPRIN, PERIHAL_SPRIN, MENIMBANG_1, DASAR_1, UNTUK_1, JABATAN_OTO, NIP_OTO, NO_URUT_SPRIN, NO_SPRIN, TGL_AWAL_SPRIN, TGL_AKHIR_SPRIN, PENEMPATAN) VALUES 
('sprin-001', 'SPRIN', 1, '2023-02-01', 'Dinas Luar', 'Perlu', 'UU', 'Staf', 'Kepala', '198001012000011001', '001', 'SPRIN/001/II/2023', '2023-02-01', '2023-02-07', 'Surabaya');

INSERT INTO DINAS_LUAR (DINAS_TRANSAKSI_ID, GUID_SPRIN, NIP, TGL_AWAL_DINAS_LUAR, TGL_AKHIR_DINAS_LUAR, KETERANGAN_DINAS_LUAR, PENEMPATAN_DINAS_LUAR, TRANSAKSI, NO_SURAT, JENIS, TIPE) VALUES 
('dl-001', 'sprin-001', '199002022010012002', '2023-02-01 08:00:00', '2023-02-07 17:00:00', 'Rapat Koordinasi', 'Hotel A', 'Dinas', 'SPRIN/001', 'DL', 1);

INSERT INTO LEMBUR (NIP, TGL_KERJA, JAM_IN, JAM_OUT, KETERANGAN, NO_SURAT, JAM_BAKU_IN, JAM_BAKU_OUT) VALUES 
('199002022010012002', '2023-01-15 00:00:00', '2023-01-15 18:00:00', '2023-01-15 21:00:00', 'Lembur', 'SPRIN/002', '2023-01-15 18:00:00', '2023-01-15 21:00:00');

INSERT INTO LOG_TRANSAKSI (TRAKSAKSI_ID, NIP, TRAKSAKSI_BACKUP_ID, GUID_SKP_PEG, TRANSAKSI, ACTIVITY, UPDATE_DATE) VALUES 
(1, '198001012000011001', 1, 'skp-001', 'Insert', 'Tambah Data', '2023-01-01 10:00:00');

INSERT INTO LOG_TRANSAKSI_BACKUP (TRAKSAKSI_BACKUP_ID, TRAKSAKSI_ID, GUID_SKP_PEG, TRANSAKSI, ACTIVITY, UPDATE_DATE) VALUES 
(1, 1, 'skp-001', 'Insert', 'Backup', '2023-01-01 10:05:00');

INSERT INTO LOG_ACTIVITIY_BACKUP (GUID_LOG_BACKUP, GUID_LOG, TRX, ACTIVITY, ACTIVITY_DATE, NOTE, TEMPAT, PERIHAL, UPDATE_BY, UPDATE_DATE, FUNGSIONAL, TGL_CLOSING, SHIFT_1, SHIFT_2, PENGGANTI, STATUS_TRX, KET_UPDATE, NIP_PENGGANTI, BIAYA, QTY, SATUAN_QTY, SHIFT, TRANSAKSI_FORM, TGL_JAM_IN, TGL_JAM_OUT, TGL_JAM_BAKU_IN, TGL_JAM_BAKU_OUT) VALUES 
('log-backup-001', 'log-001', 'ABSEN', 'Login', '2023-01-01', 'User login', 'Kantor', 'Akses', 'admin', '2023-01-01 07:00:00', 'Admin', NULL, 1, 2, 0, 'Sukses', '-', NULL, 0, 1, 'Kali', 'P', 'Login', '2023-01-01 07:00:00', '2023-01-01 16:00:00', '2023-01-01 07:00:00', '2023-01-01 16:00:00');

INSERT INTO LOG_ACTIVITIY (GUID_LOG, TRAKSAKSI_ID, UNIT_KERJA_ID, GUID_LOG_BACKUP, GUID_TIM, STATUS_ID, NIP, TRX, ACTIVITY, ACTIVITY_DATE, NOTE, TEMPAT, PERIHAL, UPDATE_BY, UPDATE_DATE, FUNGSIONAL, TGL_CLOSING, SHIFT_1, SHIFT_2, PENGGANTI, STATUS_TRX, KET_UPDATE, NIP_PENGGANTI, BIAYA, QTY, SATUAN_QTY, SHIFT, TRANSAKSI_FORM, TGL_JAM_IN, TGL_JAM_OUT, TGL_JAM_BAKU_IN, TGL_JAM_BAKU_OUT) VALUES 
('log-001', 1, 1, 'log-backup-001', 'tim-001', 1, '198001012000011001', 'ABSEN', 'Login', '2023-01-01', 'User login', 'Kantor', 'Akses', 'admin', '2023-01-01 07:00:00', 'Admin', NULL, 1, 2, 0, 'Sukses', '-', NULL, 0, 1, 'Kali', 'P', 'Login', '2023-01-01 07:00:00', '2023-01-01 16:00:00', '2023-01-01 07:00:00', '2023-01-01 16:00:00');

INSERT INTO ABSENSI (ABSENSI_ID, POTONGAN_ID, TGL_KERJA, ABSENSI_BACKUP_ID, ABSENSI_TEMP_ID, FINGER_ID, TGL_JAM_IN, TGL_JAM_OUT, KET_IN, TRANSAKSI_IN, KET_OUT, TRANSAKSI_OUT, TINGKAT_TLM, TOTAL_TLM, TOTAL_PSW, TINGKAT_PSW, IS_INVALID, IS_OUTVALID, AWAL_TLM, PERSEN_POT_TLM, PERSEN_POT_PSW, TGL_JAM_BAKU_IN, TGL_JAM_BAKU_OUT, TRAKSAKSI_ID_FROM, PENDUKUNG_IN, PENDUKUNG_OUT, HISTORY_TRANSAKSI_IN, HISTORY_TRANSAKSI_OUT, STATUS_UM) VALUES 
(1, 1, '2023-01-02 00:00:00', 1, 1, 1, '2023-01-02 07:30:00', '2023-01-02 16:30:00', 'Masuk tepat waktu', 'IN', 'Pulang tepat waktu', 'OUT', 'Ringan', 0, 0, 'Ringan', 'N', 'N', 0, 0, 0, '2023-01-02 07:30:00', '2023-01-02 16:30:00', 'trx-001', 'Manual', 'Manual', 'History in', 'History out', 1),
(2, 1, '2023-01-02 00:00:00', 2, 2, 2, '2023-01-02 08:00:00', '2023-01-02 17:00:00', 'Terlambat', 'IN', 'Normal', 'OUT', 'Sedang', 30, 0, 'Sedang', 'N', 'N', 30, 5, 0, '2023-01-02 07:30:00', '2023-01-02 16:30:00', 'trx-002', 'Manual', 'Manual', 'History in', 'History out', 1);

INSERT INTO ABSENSI_BACKUP (ABSENSI_BACKUP_ID, ABSENSI_ID, TGL_JAM_IN, TGL_JAM_OUT, KET_IN, TRANSAKSI_IN, KET_OUT, TRANSAKSI_OUT, TINGKAT_TLM, TOTAL_TLM, TOTAL_PSW, TINGKAT_PSW, IS_INVALID, IS_OUTVALID, AWAL_TLM, PERSEN_POT_TLM, PERSEN_POT_PSW, TGL_JAM_BAKU_IN, TGL_JAM_BAKU_OUT, TRAKSAKSI_ID_FROM, PENDUKUNG_IN, PENDUKUNG_OUT, HISTORY_TRANSAKSI_IN, HISTORY_TRANSAKSI_OUT, STATUS_UM) VALUES 
(1, 1, '2023-01-02 07:30:00', '2023-01-02 16:30:00', 'Masuk tepat waktu', 'IN', 'Pulang tepat waktu', 'OUT', 'Ringan', 0, 0, 'Ringan', 'N', 'N', 0, 0, 0, '2023-01-02 07:30:00', '2023-01-02 16:30:00', 'trx-001', 'Manual', 'Manual', 'History in', 'History out', 1),
(2, 2, '2023-01-02 08:00:00', '2023-01-02 17:00:00', 'Terlambat', 'IN', 'Normal', 'OUT', 'Sedang', 30, 0, 'Sedang', 'N', 'N', 30, 5, 0, '2023-01-02 07:30:00', '2023-01-02 16:30:00', 'trx-002', 'Manual', 'Manual', 'History in', 'History out', 1);

INSERT INTO ABSENSI_TEMP (ABSENSI_TEMP_ID, ABSENSI_ID, TGL_JAM_IN, TGL_JAM_OUT, KET_IN, TRANSAKSI_IN, KET_OUT, TRANSAKSI_OUT, TINGKAT_TLM, TOTAL_TLM, TOTAL_PSW, TINGKAT_PSW, IS_INVALID, IS_OUTVALID, AWAL_TLM, PERSEN_POT_TLM, PERSEN_POT_PSW, TGL_JAM_BAKU_IN, TGL_JAM_BAKU_OUT, TRAKSAKSI_ID_FROM, PENDUKUNG_IN, PENDUKUNG_OUT, HISTORY_TRANSAKSI_IN, HISTORY_TRANSAKSI_OUT, STATUS_UM) VALUES 
(1, 1, '2023-01-02 07:30:00', '2023-01-02 16:30:00', 'Masuk tepat waktu', 'IN', 'Pulang tepat waktu', 'OUT', 'Ringan', 0, 0, 'Ringan', 'N', 'N', 0, 0, 0, '2023-01-02 07:30:00', '2023-01-02 16:30:00', 'trx-001', 'Manual', 'Manual', 'History in', 'History out', 1),
(2, 2, '2023-01-02 08:00:00', '2023-01-02 17:00:00', 'Terlambat', 'IN', 'Normal', 'OUT', 'Sedang', 30, 0, 'Sedang', 'N', 'N', 30, 5, 0, '2023-01-02 07:30:00', '2023-01-02 16:30:00', 'trx-002', 'Manual', 'Manual', 'History in', 'History out', 1);

INSERT INTO BUKU_HARIAN_HEAD (GUID, JABATAN_ID, NIP, ITEM_ID, GUID_SKP_PEG, DESKRIPSI, AK, QTY, GOL, GOL_PARENT, BIAYA, UNSUR, TGL_MULAI, SATUAN_QTY, KETERANGAN, UPDATE_DATE, CREATE_DATE, NIP_PARENT, JABATAN_ID_PARENT, STATUS, KETERANGAN_PENGAJUAN) VALUES 
('bh-001', 1, '198001012000011001', 'KEG-001', 'skp-001', 'Laporan', 100, 1, 'III/a', 'III/a', 0, 'Utama', '2023-01-01', 'Laporan', 'Selesai', '2023-01-01 10:00:00', '2023-01-01 09:00:00', NULL, NULL, 1, 'Disetujui');

INSERT INTO DRH (NIP, JABATAN_ID, TRAKSAKSI_ID, GUID_TRANSAKSI, TGL_MULAI, NO_SK) VALUES 
('198001012000011001', 1, 1, 'trx-001', '2023-01-01', 'SK/001/2023');

INSERT INTO MEDIA_INFORMASI (MED_INFOR_ID, UPDATE_DATE, UPDATE_BY, TRX, NAMA_FILE, DESKRIPSI, PUBLISH_DATE_START, PUBLISH_DATE_END, IS_AKTIF, PIC, ALAMAT) VALUES 
(1, '2023-01-01 08:00:00', 'admin', 'Upload', 'pengumuman.pdf', 'Jadwal Piket', '2023-01-01', '2023-12-31', 'Y', 'Humas', '/uploads/pengumuman.pdf');

INSERT INTO MONITORING_APP (TRAKSAKSI_ID, APLICATION, USER_NAME, COMPUTER_IP, LOGIN_TIME, LOGIN_DATE, IS_ON) VALUES 
(1, 'AbsensiApp', 'andi', '192.168.1.10', '2023-01-01 07:00:00', '2023-01-01 07:00:00', 'Y');

INSERT INTO OTORISASI (GUID_OTO, NIP, TRX, LEVEL_OTO, JABATAN, ACT, UPDATE_BY, UPDATE_DATE, PERIHAL, KETERANGAN, BULAN, TAHUN, TGL_PENGAJUAN) VALUES 
('oto-001', '198001012000011001', 'Cuti', 1, 'Kepala', 1, 'admin', '2023-01-01 08:00:00', 'Cuti Tahunan', 'Disetujui', 1, 2023, '2023-01-01 08:00:00');

INSERT INTO OTORISASI_HISTORY (OTO_HISTORY_ID, GUID_OTO, NIP, UNIT_KERJA_ID, TRX, LEVEL_OTO, JABATAN, ACT, UPDATE_BY, UPDATE_DATE, PERIHAL, KETERANGAN, BULAN, TAHUN, SHIFT_1, SHIFT_2, REC_DATE, TGL_PENGAJUAN) VALUES 
(1, 'oto-001', '198001012000011001', 1, 'Cuti', 1, 'Kepala', 1, 'admin', '2023-01-01 08:00:00', 'Cuti Tahunan', 'Diproses', 1, 2023, 1, 2, '2023-01-01 08:05:00', '2023-01-01 08:00:00');

INSERT INTO PEG_MUTASI_UNIT (TRAKSAKSI_ID, NIP, TGL_MUTASI, UNIT_KERJA, UPDATE_BY, UPDATE_DATE, NO_SK, KETERANGAN) VALUES 
(1, '199002022010012002', '2023-02-01', '2', 'admin', '2023-02-01 09:00:00', 'SK/002/2023', 'Mutasi ke Surabaya');

INSERT INTO SARAN (ID_SARAN, NIP, SARAN, INSTANSI) VALUES 
(1, '198001012000011001', 'Tingkatkan pelayanan', 'Basarnas');

INSERT INTO SKP_PEGAWAI (GUID_SKP_PEG, NIP, JABATAN_ID, DESKRIPSI, AK, QTY, MUTU, WAKTU, BIAYA, UNSUR, TYPE, TGL_MULAI, SATUAN_QTY, SATUAN_MUTU, SATUAN_WAKTU) VALUES 
('skp-001', '198001012000011001', 1, 'Menyusun laporan tahunan', 100, 1, 100, '2023-01-01 08:00:00', 0, 'Utama', 1, '2023-01-01 00:00:00', 'Laporan', 'Persen', 'Jam');

INSERT INTO SKP_PEGAWAI_HEAD (SKP_PEGAWAI_HEAD_ID, GUID_SKP_PEG, NIP, GOL_ID, JABATAN_ID, TGL_MULAI, NIP_PARENT, JABATAN_ID_PARENT, UPDATE_DATE, TGL_PEMBUATAN, GOL_PARENT) VALUES 
(1, 'skp-001', '198001012000011001', 1, 1, '2023-01-01 00:00:00', NULL, NULL, '2023-01-01 09:00:00', '2023-01-01 08:00:00', 'III/a');

-- Aktifkan kembali foreign key check
SET FOREIGN_KEY_CHECKS = 1;