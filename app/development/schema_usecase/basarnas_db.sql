/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     14/04/2026 11:54:54                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_ABSENSI_DATA_BACK_ABSENSI_') then
    alter table ABSENSI
       delete foreign key FK_ABSENSI_DATA_BACK_ABSENSI_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ABSENSI_DATA_TEMP_ABSENSI_') then
    alter table ABSENSI
       delete foreign key FK_ABSENSI_DATA_TEMP_ABSENSI_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ABSENSI_DITERAPKA_MF_POT') then
    alter table ABSENSI
       delete foreign key FK_ABSENSI_DITERAPKA_MF_POT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ABSENSI_MENJADI_S_TIME_REC') then
    alter table ABSENSI
       delete foreign key FK_ABSENSI_MENJADI_S_TIME_REC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ABSENSI_TERJADI_P_KALENDER') then
    alter table ABSENSI
       delete foreign key FK_ABSENSI_TERJADI_P_KALENDER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ABSENSI__DATA_BACK_ABSENSI') then
    alter table ABSENSI_BACKUP
       delete foreign key FK_ABSENSI__DATA_BACK_ABSENSI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ABSENSI__DATA_TEMP_ABSENSI') then
    alter table ABSENSI_TEMP
       delete foreign key FK_ABSENSI__DATA_TEMP_ABSENSI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BUKU_HAR_DIBUAT_OL_PEGAWAI') then
    alter table BUKU_HARIAN_HEAD
       delete foreign key FK_BUKU_HAR_DIBUAT_OL_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BUKU_HAR_TERKAIT_D_SKP_PEGA') then
    alter table BUKU_HARIAN_HEAD
       delete foreign key FK_BUKU_HAR_TERKAIT_D_SKP_PEGA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BUKU_HAR_TERKAIT_J_MF_JABAT2') then
    alter table BUKU_HARIAN_HEAD
       delete foreign key FK_BUKU_HAR_TERKAIT_J_MF_JABAT2
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BUKU_HAR_TERKAIT_J_MF_JABAT') then
    alter table BUKU_HARIAN_HEAD
       delete foreign key FK_BUKU_HAR_TERKAIT_J_MF_JABAT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DINAS_LU_BERDASARK_SPRIN_HE') then
    alter table DINAS_LUAR
       delete foreign key FK_DINAS_LU_BERDASARK_SPRIN_HE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DINAS_LU_MELAKUKAN_PEGAWAI') then
    alter table DINAS_LUAR
       delete foreign key FK_DINAS_LU_MELAKUKAN_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DRH_JABATAN_D_MF_JABAT') then
    alter table DRH
       delete foreign key FK_DRH_JABATAN_D_MF_JABAT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DRH_MEREKAM_D_LOG_TRAN') then
    alter table DRH
       delete foreign key FK_DRH_MEREKAM_D_LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DRH_PEGAWAI_D_PEGAWAI') then
    alter table DRH
       delete foreign key FK_DRH_PEGAWAI_D_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HAK_AKSE_DIBERIKAN_PEGAWAI') then
    alter table HAK_AKSES_FORM
       delete foreign key FK_HAK_AKSE_DIBERIKAN_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HAK_AKSE_UNTUK_FOR_MF_FORM') then
    alter table HAK_AKSES_FORM
       delete foreign key FK_HAK_AKSE_UNTUK_FOR_MF_FORM
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HAK_AKSE_AKSES_SPR_MF_TYPE_') then
    alter table HAK_AKSES_TYPE_SPRIN
       delete foreign key FK_HAK_AKSE_AKSES_SPR_MF_TYPE_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HAK_AKSE_USER_SPRI_PEGAWAI') then
    alter table HAK_AKSES_TYPE_SPRIN
       delete foreign key FK_HAK_AKSE_USER_SPRI_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LEMBUR_DILAKUKAN_PEGAWAI') then
    alter table LEMBUR
       delete foreign key FK_LEMBUR_DILAKUKAN_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LEMBUR_TERJADI_T_KALENDER') then
    alter table LEMBUR
       delete foreign key FK_LEMBUR_TERJADI_T_KALENDER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOG_ACTI_DILAKUKAN_PEGAWAI') then
    alter table LOG_ACTIVITIY
       delete foreign key FK_LOG_ACTI_DILAKUKAN_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOG_ACTI_DILAKUKAN_MF_TIM_S') then
    alter table LOG_ACTIVITIY
       delete foreign key FK_LOG_ACTI_DILAKUKAN_MF_TIM_S
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOG_ACTI_MEMBACKUP_LOG_ACTI') then
    alter table LOG_ACTIVITIY
       delete foreign key FK_LOG_ACTI_MEMBACKUP_LOG_ACTI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOG_ACTI_MEMILIKI__MF_STATU') then
    alter table LOG_ACTIVITIY
       delete foreign key FK_LOG_ACTI_MEMILIKI__MF_STATU
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOG_ACTI_TRANSAKSI_LOG_TRAN') then
    alter table LOG_ACTIVITIY
       delete foreign key FK_LOG_ACTI_TRANSAKSI_LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOG_ACTI_UNIT_MELA_MF_UNIT_') then
    alter table LOG_ACTIVITIY
       delete foreign key FK_LOG_ACTI_UNIT_MELA_MF_UNIT_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOG_ACTI_MEMBACKUP_LOG_ACTI') then
    alter table LOG_ACTIVITIY_BACKUP
       delete foreign key FK_LOG_ACTI_MEMBACKUP_LOG_ACTI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOG_TRAN_DATA_BACK_LOG_TRAN') then
    alter table LOG_TRANSAKSI
       delete foreign key FK_LOG_TRAN_DATA_BACK_LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOG_TRAN_TRANSAKSI_PEGAWAI') then
    alter table LOG_TRANSAKSI
       delete foreign key FK_LOG_TRAN_TRANSAKSI_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOG_TRAN_DATA_BACK_LOG_TRAN') then
    alter table LOG_TRANSAKSI_BACKUP
       delete foreign key FK_LOG_TRAN_DATA_BACK_LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_CONFI_MENCATAT__LOG_TRAN') then
    alter table MF_CONFIG
       delete foreign key FK_MF_CONFI_MENCATAT__LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_FIELD_MENCATAT__LOG_TRAN') then
    alter table MF_FIELD_CARI
       delete foreign key FK_MF_FIELD_MENCATAT__LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_HOST__HOST_DARI_MF_UNIT_') then
    alter table MF_HOST_NAME_FP
       delete foreign key FK_MF_HOST__HOST_DARI_MF_UNIT_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_JABAT_MERUBAH_J_PERUBAHA') then
    alter table MF_JABATAN
       delete foreign key FK_MF_JABAT_MERUBAH_J_PERUBAHA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_JABAT_TERMASUK__MF_GROUP') then
    alter table MF_JABATAN
       delete foreign key FK_MF_JABAT_TERMASUK__MF_GROUP
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_JABAT_TERMASUK__MF__SUB_') then
    alter table MF_JABATAN
       delete foreign key FK_MF_JABAT_TERMASUK__MF__SUB_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_JABAT_DIBUAT_UN_MF_JABAT') then
    alter table MF_JABATAN_KEGIATAN
       delete foreign key FK_MF_JABAT_DIBUAT_UN_MF_JABAT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_JOBLI_MEMILIKI__MF_GROUP') then
    alter table MF_JOBLIST
       delete foreign key FK_MF_JOBLI_MEMILIKI__MF_GROUP
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_JOBLI_MENGACU_K_MF_JABAT') then
    alter table MF_JOBLIST
       delete foreign key FK_MF_JOBLI_MENGACU_K_MF_JABAT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_KLASI_MENGAKLSI_MF_TYPE_') then
    alter table MF_KLASIFIKASI_SURAT
       delete foreign key FK_MF_KLASI_MENGAKLSI_MF_TYPE_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_LOAD__MENCATAT__LOG_TRAN') then
    alter table MF_LOAD_FINGER
       delete foreign key FK_MF_LOAD__MENCATAT__LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_SHIFT_MENCATAT__LOG_TRAN') then
    alter table MF_SHIFT
       delete foreign key FK_MF_SHIFT_MENCATAT__LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_SU_MENYIMPAN_PEGAWAI') then
    alter table MF_SU
       delete foreign key FK_MF_SU_MENYIMPAN_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_TIM_S_BERANGGOT_MF_TIM_S') then
    alter table MF_TIM_SIAGA_ANGGOTA
       delete foreign key FK_MF_TIM_S_BERANGGOT_MF_TIM_S
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_TIM_S_DIISI_OLE_PEGAWAI') then
    alter table MF_TIM_SIAGA_ANGGOTA
       delete foreign key FK_MF_TIM_S_DIISI_OLE_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MF_TR_MENCATAT__LOG_TRAN') then
    alter table MF_TR
       delete foreign key FK_MF_TR_MENCATAT__LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MONITORI_MENCATAT__LOG_TRAN') then
    alter table MONITORING_APP
       delete foreign key FK_MONITORI_MENCATAT__LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_OTORISAS_DIAJUKAN__PEGAWAI') then
    alter table OTORISASI
       delete foreign key FK_OTORISAS_DIAJUKAN__PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_OTORISAS_OTORISASI_MF_UNIT_') then
    alter table OTORISASI_HISTORY
       delete foreign key FK_OTORISAS_OTORISASI_MF_UNIT_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_OTORISAS_OTORISASI_OTORISAS') then
    alter table OTORISASI_HISTORY
       delete foreign key FK_OTORISAS_OTORISASI_OTORISAS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_OTORISAS_USER_OTOR_PEGAWAI') then
    alter table OTORISASI_HISTORY
       delete foreign key FK_OTORISAS_USER_OTOR_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PEGAWAI_BEKERJA_D_MF_UNIT_') then
    alter table PEGAWAI
       delete foreign key FK_PEGAWAI_BEKERJA_D_MF_UNIT_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PEGAWAI_DILAKUKAN_ABSENSI') then
    alter table PEGAWAI
       delete foreign key FK_PEGAWAI_DILAKUKAN_ABSENSI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PEGAWAI_MEMILIKI__MF_ESELO') then
    alter table PEGAWAI
       delete foreign key FK_PEGAWAI_MEMILIKI__MF_ESELO
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PEGAWAI_MEMILIKI__MF_GOL') then
    alter table PEGAWAI
       delete foreign key FK_PEGAWAI_MEMILIKI__MF_GOL
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PEGAWAI_MENDUDUKI_MF_JABAT') then
    alter table PEGAWAI
       delete foreign key FK_PEGAWAI_MENDUDUKI_MF_JABAT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PEGAWAI_TERMASUK__MF_CLASS') then
    alter table PEGAWAI
       delete foreign key FK_PEGAWAI_TERMASUK__MF_CLASS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PEGAWAI_UNTUK_STA_MF_TUNJA') then
    alter table PEGAWAI
       delete foreign key FK_PEGAWAI_UNTUK_STA_MF_TUNJA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PEG_MUTA_MENCATAT__LOG_TRAN') then
    alter table PEG_MUTASI_UNIT
       delete foreign key FK_PEG_MUTA_MENCATAT__LOG_TRAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PEG_MUTA_USER_PIND_PEGAWAI') then
    alter table PEG_MUTASI_UNIT
       delete foreign key FK_PEG_MUTA_USER_PIND_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PERUBAHA_MERUBAH_J_MF_JABAT') then
    alter table PERUBAHAN_JABATAN
       delete foreign key FK_PERUBAHA_MERUBAH_J_MF_JABAT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SARAN_MENYAMPAI_PEGAWAI') then
    alter table SARAN
       delete foreign key FK_SARAN_MENYAMPAI_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SKP_PEGA_DILAKSANA_MF_JABAT') then
    alter table SKP_PEGAWAI
       delete foreign key FK_SKP_PEGA_DILAKSANA_MF_JABAT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SKP_PEGA_TERKAIT_O_PEGAWAI') then
    alter table SKP_PEGAWAI
       delete foreign key FK_SKP_PEGA_TERKAIT_O_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SKP_PEGA_BAWAHAN_S_SKP_PEGA') then
    alter table SKP_PEGAWAI_HEAD
       delete foreign key FK_SKP_PEGA_BAWAHAN_S_SKP_PEGA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SKP_PEGA_GOL_PEGAW_MF_GOL') then
    alter table SKP_PEGAWAI_HEAD
       delete foreign key FK_SKP_PEGA_GOL_PEGAW_MF_GOL
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SKP_PEGA_JABATAN_P_MF_JABAT') then
    alter table SKP_PEGAWAI_HEAD
       delete foreign key FK_SKP_PEGA_JABATAN_P_MF_JABAT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SKP_PEGA_USER_HEAD_PEGAWAI') then
    alter table SKP_PEGAWAI_HEAD
       delete foreign key FK_SKP_PEGA_USER_HEAD_PEGAWAI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SPRIN_HE_BERTIPE_MF_TYPE_') then
    alter table SPRIN_HEADER
       delete foreign key FK_SPRIN_HE_BERTIPE_MF_TYPE_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_USER_ACC_DIMILIKI__PEGAWAI') then
    alter table USER_ACCOUNT
       delete foreign key FK_USER_ACC_DIMILIKI__PEGAWAI
end if;

drop index if exists ABSENSI.DATA_TEMP_ABSENSI_FK;

drop index if exists ABSENSI.DATA_BACKUP_ABSENSI_FK;

drop index if exists ABSENSI.DITERAPKAN_PADA_FK;

drop index if exists ABSENSI.TERJADI_PADA_TANGGAL_FK;

drop index if exists ABSENSI.MENJADI_SUMBER_DATA_FK;

drop index if exists ABSENSI.ABSENSI_PK;

drop table if exists ABSENSI;

drop index if exists ABSENSI_BACKUP.DATA_BACKUP_ABSENSI2_FK;

drop index if exists ABSENSI_BACKUP.ABSENSI_BACKUP_PK;

drop table if exists ABSENSI_BACKUP;

drop index if exists ABSENSI_TEMP.DATA_TEMP_ABSENSI2_FK;

drop index if exists ABSENSI_TEMP.ABSENSI_TEMP_PK;

drop table if exists ABSENSI_TEMP;

drop index if exists BUKU_HARIAN_HEAD.TERKAIT_JABATAN_KEGIATAN_FK;

drop index if exists BUKU_HARIAN_HEAD.TERKAIT_DENGAN_FK;

drop index if exists BUKU_HARIAN_HEAD.TERKAIT_JABATAN_FK;

drop index if exists BUKU_HARIAN_HEAD.DIBUAT_OLEH_FK;

drop index if exists BUKU_HARIAN_HEAD.BUKU_HARIAN_HEAD_PK;

drop table if exists BUKU_HARIAN_HEAD;

drop index if exists DINAS_LUAR.BERDASARKAN_SPRIN_FK;

drop index if exists DINAS_LUAR.DINAS_LUAR_PK;

drop table if exists DINAS_LUAR;

drop index if exists DRH.PEGAWAI_DRH_FK;

drop index if exists DRH.MEREKAM_DRH_FK;

drop index if exists DRH.JABATAN_DRH_FK;

drop table if exists DRH;

drop index if exists HAK_AKSES_FORM.UNTUK_FORM_FK;

drop index if exists HAK_AKSES_FORM.DIBERIKAN_KEPADA_FK;

drop table if exists HAK_AKSES_FORM;

drop index if exists HAK_AKSES_TYPE_SPRIN.AKSES_SPRIN_FK;

drop index if exists HAK_AKSES_TYPE_SPRIN.USER_SPRIN_FK;

drop table if exists HAK_AKSES_TYPE_SPRIN;

drop index if exists KALENDER.KALENDER_PK;

drop table if exists KALENDER;

drop index if exists LEMBUR.DILAKUKAN_LEMBUR_FK;

drop index if exists LEMBUR.TERJADI_TANGGAL_LEMBUR_FK;

drop table if exists LEMBUR;

drop index if exists LOG_ACTIVITIY.MEMBACKUP_LOG_ACTIVITIY_FK;

drop index if exists LOG_ACTIVITIY.TRANSAKSI_TEREKAM_FK;

drop index if exists LOG_ACTIVITIY.UNIT_MELAKUKAN_FK;

drop index if exists LOG_ACTIVITIY.DILAKUKAN_TIM_FK;

drop index if exists LOG_ACTIVITIY.MEMILIKI_STATUS_FK;

drop index if exists LOG_ACTIVITIY.DILAKUKAN_OLEH_USER_FK;

drop index if exists LOG_ACTIVITIY.LOG_ACTIVITIY_PK;

drop table if exists LOG_ACTIVITIY;

drop index if exists LOG_ACTIVITIY_BACKUP.MEMBACKUP_LOG_ACTIVITIY2_FK;

drop index if exists LOG_ACTIVITIY_BACKUP.LOG_ACTIVITIY_BACKUP_PK;

drop table if exists LOG_ACTIVITIY_BACKUP;

drop index if exists LOG_TRANSAKSI.DATA_BACKUP_TRANSAKSI_FK;

drop index if exists LOG_TRANSAKSI.TRANSAKSI_DILAKUKAN_OLEH_FK;

drop index if exists LOG_TRANSAKSI.LOG_TRANSAKSI_PK;

drop table if exists LOG_TRANSAKSI;

drop index if exists LOG_TRANSAKSI_BACKUP.DATA_BACKUP_TRANSAKSI2_FK;

drop index if exists LOG_TRANSAKSI_BACKUP.LOG_TRANSAKSI_BACKUP_PK;

drop table if exists LOG_TRANSAKSI_BACKUP;

drop index if exists MEDIA_INFORMASI.MEDIA_INFORMASI_PK;

drop table if exists MEDIA_INFORMASI;

drop index if exists MF_CLASS.MF_CLASS_PK;

drop table if exists MF_CLASS;

drop index if exists MF_CONFIG.MENCATAT_CONFIG_FK;

drop table if exists MF_CONFIG;

drop table if exists MF_EMAIL_SEND;

drop index if exists MF_ESELON.MF_ESELON_PK;

drop table if exists MF_ESELON;

drop index if exists MF_FIELD_CARI.MENCATAT_PENCARIAN_FK;

drop index if exists MF_FIELD_CARI.MF_FIELD_CARI_PK;

drop table if exists MF_FIELD_CARI;

drop index if exists MF_FORM.MF_FORM_PK;

drop table if exists MF_FORM;

drop index if exists MF_FORM_NEW.MF_FORM_NEW_PK;

drop table if exists MF_FORM_NEW;

drop index if exists MF_GOL.MF_GOL_PK;

drop table if exists MF_GOL;

drop index if exists MF_GROUP_JABATAN.MF_GROUP_JABATAN_PK;

drop table if exists MF_GROUP_JABATAN;

drop index if exists MF_HOST_NAME_FP.HOST_DARI_UNIT_FK;

drop table if exists MF_HOST_NAME_FP;

drop index if exists MF_JABATAN.MERUBAH_JABATAN_FK;

drop index if exists MF_JABATAN.RELATIONSHIP_2_FK;

drop index if exists MF_JABATAN.RELATIONSHIP_1_FK;

drop index if exists MF_JABATAN.MF_JABATAN_PK;

drop table if exists MF_JABATAN;

drop index if exists MF_JABATAN_KEGIATAN.DIBUAT_UNTUK_FK;

drop index if exists MF_JABATAN_KEGIATAN.MF_JABATAN_KEGIATAN_PK;

drop table if exists MF_JABATAN_KEGIATAN;

drop index if exists MF_JAM_KERJA.MF_JAM_KERJA_PK;

drop table if exists MF_JAM_KERJA;

drop index if exists MF_JOBLIST.MENGACU_KE_FK;

drop index if exists MF_JOBLIST.MEMILIKI_JOB_FK;

drop index if exists MF_JOBLIST.MF_JOBLIST_PK;

drop table if exists MF_JOBLIST;

drop index if exists MF_KLASIFIKASI_SURAT.MENGAKLSIFIKASI_SURAT_FK;

drop index if exists MF_KLASIFIKASI_SURAT.MF_KLASIFIKASI_SURAT_PK;

drop table if exists MF_KLASIFIKASI_SURAT;

drop index if exists MF_LOAD_FINGER.MENCATAT_FINGER_FK;

drop table if exists MF_LOAD_FINGER;

drop index if exists MF_ORGZ_SIAGA.MF_ORGZ_SIAGA_PK;

drop table if exists MF_ORGZ_SIAGA;

drop index if exists MF_POT.MF_POTONGAN_PK;

drop table if exists MF_POT;

drop index if exists MF_POTONGAN.MF_POTONGAN_PK;

drop table if exists MF_POTONGAN;

drop table if exists MF_PRIORITY_TRANSAKSI;

drop index if exists MF_SATUAN.MF_SATUAN_PK;

drop table if exists MF_SATUAN;

drop index if exists MF_SHIFT.MENCATAT_SHIFT_FK;

drop index if exists MF_SHIFT.MF_SHIFT_PK;

drop table if exists MF_SHIFT;

drop index if exists MF_STATUS.MF_STATUS_PK;

drop table if exists MF_STATUS;

drop index if exists MF_SU.MENYIMPAN_USER_FK;

drop table if exists MF_SU;

drop index if exists MF_TIM_SIAGA.MF_TIM_SIAGA_PK;

drop table if exists MF_TIM_SIAGA;

drop index if exists MF_TIM_SIAGA_ANGGOTA.DIISI_OLEH_FK;

drop index if exists MF_TIM_SIAGA_ANGGOTA.BERANGGOTAKAN_FK;

drop table if exists MF_TIM_SIAGA_ANGGOTA;

drop index if exists MF_TR.MENCATAT_TR_FK;

drop table if exists MF_TR;

drop index if exists MF_TUNJANGAN.MF_TUNJANGAN_PK;

drop table if exists MF_TUNJANGAN;

drop index if exists MF_TYPE_SPRIN.MF_TYPE_SPRIN_PK;

drop table if exists MF_TYPE_SPRIN;

drop index if exists MF_UNIT_KERJA.MF_UNIT_KERJA_PK;

drop table if exists MF_UNIT_KERJA;

drop index if exists MF_UNSUR_KEGIATAN.MF_UNSUR_KEGIATAN_PK;

drop table if exists MF_UNSUR_KEGIATAN;

drop index if exists MF__SUB_GROUP_JABATAN.MF__SUB_GROUP_JABATAN_PK;

drop table if exists MF__SUB_GROUP_JABATAN;

drop index if exists MONITORING_APP.MENCATAT_LOG_APP_FK;

drop table if exists MONITORING_APP;

drop index if exists OTORISASI.DIAJUKAN_OLEH_FK;

drop index if exists OTORISASI.OTORISASI_PK;

drop table if exists OTORISASI;

drop index if exists OTORISASI_HISTORY.OTORISASI_SEBELUMNYA_FK;

drop index if exists OTORISASI_HISTORY.OTORISASI_HISTORY_UNIT_FK;

drop index if exists OTORISASI_HISTORY.USER_OTORISASI_HISTORY_FK;

drop index if exists OTORISASI_HISTORY.OTORISASI_HISTORY_PK;

drop table if exists OTORISASI_HISTORY;

drop index if exists PEGAWAI.UNTUK_STATUS_TUNJANGAN_FK;

drop index if exists PEGAWAI.MEMILIKI_ESELON_FK;

drop index if exists PEGAWAI.DILAKUKAN_OLEH_FK;

drop index if exists PEGAWAI.TERMASUK_KELAS_FK;

drop index if exists PEGAWAI.BEKERJA_DI_UNIT_FK;

drop index if exists PEGAWAI.MEMILIKI_GOLONGAN_FK;

drop index if exists PEGAWAI.MENDUDUKI_JABATAN_FK;

drop index if exists PEGAWAI.PEGAWAI_PK;

drop table if exists PEGAWAI;

drop index if exists PEG_MUTASI_UNIT.MENCATAT_MUTASI_UNIT_FK;

drop index if exists PEG_MUTASI_UNIT.USER_PINDAH_UNIT_FK;

drop table if exists PEG_MUTASI_UNIT;

drop index if exists PERUBAHAN_JABATAN.MERUBAH_JABATAN2_FK;

drop index if exists PERUBAHAN_JABATAN.PERUBAHAN_JABATAN_PK;

drop table if exists PERUBAHAN_JABATAN;

drop index if exists SARAN.MENYAMPAIKAN_FK;

drop index if exists SARAN.SARAN_PK;

drop table if exists SARAN;

drop index if exists SKP_PEGAWAI.DIMILIKI_OLEH_FK;

drop index if exists SKP_PEGAWAI.DILAKSANAKAN_DI_FK;

drop index if exists SKP_PEGAWAI.SKP_PEGAWAI_PK;

drop table if exists SKP_PEGAWAI;

drop index if exists SKP_PEGAWAI_HEAD.GOL_PEGAWAI_HEAD_FK;

drop index if exists SKP_PEGAWAI_HEAD.BAWAHAN_USER_FK;

drop index if exists SKP_PEGAWAI_HEAD.USER_HEAD_FK;

drop index if exists SKP_PEGAWAI_HEAD.JABATAN_PEGAWAI_HEAD_FK;

drop index if exists SKP_PEGAWAI_HEAD.SKP_PEGAWAI_HEAD_PK;

drop table if exists SKP_PEGAWAI_HEAD;

drop index if exists SPRIN_HEADER.BERTIPE_FK;

drop index if exists SPRIN_HEADER.SPRIN_HEADER_PK;

drop table if exists SPRIN_HEADER;

drop index if exists TIME_RECORDER.TIME_RECORDER_PK;

drop table if exists TIME_RECORDER;

drop index if exists USER_ACCOUNT.DIMILIKI_OLEH_USER_FK;

drop table if exists USER_ACCOUNT;

/*==============================================================*/
/* Table: ABSENSI                                               */
/*==============================================================*/
create table ABSENSI 
(
   ABSENSI_ID           integer                        not null,
   ATTRIBUTE_186        integer                        not null,
   TGL_KERJA            timestamp                      not null,
   ABSENSI_ID2          integer                        not null,
   ABSENSI_ID3          integer                        not null,
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
ATTRIBUTE_186 ASC
);

/*==============================================================*/
/* Index: DATA_BACKUP_ABSENSI_FK                                */
/*==============================================================*/
create index DATA_BACKUP_ABSENSI_FK on ABSENSI (
ABSENSI_ID2 ASC
);

/*==============================================================*/
/* Index: DATA_TEMP_ABSENSI_FK                                  */
/*==============================================================*/
create index DATA_TEMP_ABSENSI_FK on ABSENSI (
ABSENSI_ID3 ASC
);

/*==============================================================*/
/* Table: ABSENSI_BACKUP                                        */
/*==============================================================*/
create table ABSENSI_BACKUP 
(
   ABSENSI_ID2          integer                        not null,
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
   constraint PK_ABSENSI_BACKUP primary key (ABSENSI_ID2)
);

/*==============================================================*/
/* Index: ABSENSI_BACKUP_PK                                     */
/*==============================================================*/
create unique index ABSENSI_BACKUP_PK on ABSENSI_BACKUP (
ABSENSI_ID2 ASC
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
   ABSENSI_ID3          integer                        not null,
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
   constraint PK_ABSENSI_TEMP primary key (ABSENSI_ID3)
);

/*==============================================================*/
/* Index: ABSENSI_TEMP_PK                                       */
/*==============================================================*/
create unique index ABSENSI_TEMP_PK on ABSENSI_TEMP (
ABSENSI_ID3 ASC
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
   ATTRIBUTE_266        varchar(100)                   not null,
   JABATAN_ID           integer                        null,
   NIP                  varchar(50)                    not null,
   ITEM_ID              varchar(50)                    not null,
   GUID_SKP_PEG         varchar(100)                   not null,
   ATTRIBUTE_267        varchar(350)                   null,
   ATTRIBUTE_268        float                          null,
   ATTRIBUTE_269        float                          null,
   ATTRIBUTE_270        varchar(10)                    null,
   ATTRIBUTE_271        varchar(10)                    null,
   ATTRIBUTE_272        float                          null,
   ATTRIBUTE_273        varchar(50)                    null,
   ATTRIBUTE_274        date                           null,
   ATTRIBUTE_275        varchar(50)                    null,
   ATTRIBUTE_276        varchar(350)                   null,
   ATTRIBUTE_277        timestamp                      null,
   ATTRIBUTE_278        timestamp                      null,
   ATTRIBUTE_279        varchar(50)                    null,
   ATTRIBUTE_280        integer                        null,
   ATTRIBUTE_281        integer                        null,
   ATTRIBUTE_282        varchar(150)                   null,
   constraint PK_BUKU_HARIAN_HEAD primary key (ATTRIBUTE_266)
);

/*==============================================================*/
/* Index: BUKU_HARIAN_HEAD_PK                                   */
/*==============================================================*/
create unique index BUKU_HARIAN_HEAD_PK on BUKU_HARIAN_HEAD (
ATTRIBUTE_266 ASC
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
/* Index: TERKAIT_DENGAN_FK                                     */
/*==============================================================*/
create index TERKAIT_DENGAN_FK on BUKU_HARIAN_HEAD (
JABATAN_ID ASC,
NIP ASC,
GUID_SKP_PEG ASC
);

/*==============================================================*/
/* Index: TERKAIT_JABATAN_KEGIATAN_FK                           */
/*==============================================================*/
create index TERKAIT_JABATAN_KEGIATAN_FK on BUKU_HARIAN_HEAD (
ITEM_ID ASC
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
/* Table: DRH                                                   */
/*==============================================================*/
create table DRH 
(
   NIP                  varchar(50)                    not null,
   JABATAN_ID           integer                        not null,
   ATTRIBUTE_247        integer                        not null,
   ATTRIBUTE_414        varchar(50)                    null,
   ATTRIBUTE_415        date                           null,
   ATTRIBUTE_416        varchar(150)                   null
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
ATTRIBUTE_247 ASC
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
   ATTRIBUTE_252        varchar(50)                    not null,
   NIP                  varchar(50)                    not null,
   ATTRIBUTE_283        varchar(5)                     null,
   ATTRIBUTE_284        varchar(5)                     null,
   ATTRIBUTE_285        varchar(50)                    null,
   ATTRIBUTE_286        varchar(50)                    null,
   ATTRIBUTE_287        timestamp                      null
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
ATTRIBUTE_252 ASC
);

/*==============================================================*/
/* Table: HAK_AKSES_TYPE_SPRIN                                  */
/*==============================================================*/
create table HAK_AKSES_TYPE_SPRIN 
(
   TYPE_SPRIN_ID        char(20)                       not null,
   NIP                  varchar(50)                    not null,
   ATTRIBUTE_417        char(10)                       null,
   ATTRIBUTE_418        char(10)                       null,
   ATTRIBUTE_419        char(10)                       null
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
   ATTRIBUTE_210        varchar(50)                    not null,
   ATTRIBUTE_247        integer                        not null,
   UNIT_KERJA_ID        integer                        not null,
   ATTRIBUTE_290        varchar(50)                    not null,
   GUID_TIM             varchar(50)                    not null,
   ATTRIBUTE_221        integer                        not null,
   NIP                  varchar(50)                    not null,
   ATTRIBUTE_211        varchar(50)                    null,
   ATTRIBUTE_212        varchar(50)                    null,
   ATTRIBUTE_214        date                           null,
   ATTRIBUTE_215        varchar(150)                   null,
   ATTRIBUTE_216        varchar(150)                   null,
   ATTRIBUTE_217        varchar(150)                   null,
   ATTRIBUTE_218        varchar(50)                    null,
   ATTRIBUTE_219        timestamp                      null,
   ATTRIBUTE_227        varchar(50)                    null,
   ATTRIBUTE_229        date                           null,
   ATTRIBUTE_230        integer                        null,
   ATTRIBUTE_231        integer                        null,
   ATTRIBUTE_232        integer                        null,
   ATTRIBUTE_233        varchar(50)                    null,
   ATTRIBUTE_234        varchar(250)                   null,
   ATTRIBUTE_235        varchar(50)                    null,
   ATTRIBUTE_236        float                          null,
   ATTRIBUTE_237        float                          null,
   ATTRIBUTE_238        varchar(50)                    null,
   ATTRIBUTE_239        varchar(5)                     null,
   ATTRIBUTE_241        varchar(50)                    null,
   ATTRIBUTE_242        timestamp                      null,
   ATTRIBUTE_243        timestamp                      null,
   ATTRIBUTE_244        timestamp                      null,
   ATTRIBUTE_245        timestamp                      null,
   constraint PK_LOG_ACTIVITIY primary key (ATTRIBUTE_210)
);

/*==============================================================*/
/* Index: LOG_ACTIVITIY_PK                                      */
/*==============================================================*/
create unique index LOG_ACTIVITIY_PK on LOG_ACTIVITIY (
ATTRIBUTE_210 ASC
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
ATTRIBUTE_221 ASC
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
ATTRIBUTE_247 ASC
);

/*==============================================================*/
/* Index: MEMBACKUP_LOG_ACTIVITIY_FK                            */
/*==============================================================*/
create index MEMBACKUP_LOG_ACTIVITIY_FK on LOG_ACTIVITIY (
ATTRIBUTE_290 ASC
);

/*==============================================================*/
/* Table: LOG_ACTIVITIY_BACKUP                                  */
/*==============================================================*/
create table LOG_ACTIVITIY_BACKUP 
(
   ATTRIBUTE_290        varchar(50)                    not null,
   ATTRIBUTE_210        varchar(50)                    null,
   ATTRIBUTE_211        varchar(50)                    null,
   ATTRIBUTE_212        varchar(50)                    null,
   ATTRIBUTE_214        date                           null,
   ATTRIBUTE_215        varchar(150)                   null,
   ATTRIBUTE_216        varchar(150)                   null,
   ATTRIBUTE_217        varchar(150)                   null,
   ATTRIBUTE_218        varchar(50)                    null,
   ATTRIBUTE_219        timestamp                      null,
   ATTRIBUTE_227        varchar(50)                    null,
   ATTRIBUTE_229        date                           null,
   ATTRIBUTE_230        integer                        null,
   ATTRIBUTE_231        integer                        null,
   ATTRIBUTE_232        integer                        null,
   ATTRIBUTE_233        varchar(50)                    null,
   ATTRIBUTE_234        varchar(250)                   null,
   ATTRIBUTE_235        varchar(50)                    null,
   ATTRIBUTE_236        float                          null,
   ATTRIBUTE_237        float                          null,
   ATTRIBUTE_238        varchar(50)                    null,
   ATTRIBUTE_239        varchar(5)                     null,
   ATTRIBUTE_241        varchar(50)                    null,
   ATTRIBUTE_242        timestamp                      null,
   ATTRIBUTE_243        timestamp                      null,
   ATTRIBUTE_244        timestamp                      null,
   ATTRIBUTE_245        timestamp                      null,
   constraint PK_LOG_ACTIVITIY_BACKUP primary key (ATTRIBUTE_290)
);

/*==============================================================*/
/* Index: LOG_ACTIVITIY_BACKUP_PK                               */
/*==============================================================*/
create unique index LOG_ACTIVITIY_BACKUP_PK on LOG_ACTIVITIY_BACKUP (
ATTRIBUTE_290 ASC
);

/*==============================================================*/
/* Index: MEMBACKUP_LOG_ACTIVITIY2_FK                           */
/*==============================================================*/
create index MEMBACKUP_LOG_ACTIVITIY2_FK on LOG_ACTIVITIY_BACKUP (
ATTRIBUTE_210 ASC
);

/*==============================================================*/
/* Table: LOG_TRANSAKSI                                         */
/*==============================================================*/
create table LOG_TRANSAKSI 
(
   ATTRIBUTE_247        integer                        not null,
   NIP                  varchar(50)                    not null,
   ATTRIBUTE_401        integer                        not null,
   ATTRIBUTE_251        varchar(100)                   null,
   ATTRIBUTE_248        varchar(50)                    null,
   ATTRIBUTE_249        varchar(50)                    null,
   ATTRIBUTE_250        timestamp                      null,
   constraint PK_LOG_TRANSAKSI primary key (ATTRIBUTE_247)
);

/*==============================================================*/
/* Index: LOG_TRANSAKSI_PK                                      */
/*==============================================================*/
create unique index LOG_TRANSAKSI_PK on LOG_TRANSAKSI (
ATTRIBUTE_247 ASC
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
ATTRIBUTE_401 ASC
);

/*==============================================================*/
/* Table: LOG_TRANSAKSI_BACKUP                                  */
/*==============================================================*/
create table LOG_TRANSAKSI_BACKUP 
(
   ATTRIBUTE_401        integer                        not null,
   ATTRIBUTE_247        integer                        null,
   ATTRIBUTE_251        varchar(100)                   null,
   ATTRIBUTE_248        varchar(50)                    null,
   ATTRIBUTE_249        varchar(50)                    null,
   ATTRIBUTE_250        timestamp                      null,
   constraint PK_LOG_TRANSAKSI_BACKUP primary key (ATTRIBUTE_401)
);

/*==============================================================*/
/* Index: LOG_TRANSAKSI_BACKUP_PK                               */
/*==============================================================*/
create unique index LOG_TRANSAKSI_BACKUP_PK on LOG_TRANSAKSI_BACKUP (
ATTRIBUTE_401 ASC
);

/*==============================================================*/
/* Index: DATA_BACKUP_TRANSAKSI2_FK                             */
/*==============================================================*/
create index DATA_BACKUP_TRANSAKSI2_FK on LOG_TRANSAKSI_BACKUP (
ATTRIBUTE_247 ASC
);

/*==============================================================*/
/* Table: MEDIA_INFORMASI                                       */
/*==============================================================*/
create table MEDIA_INFORMASI 
(
   ATTRIBUTE_402        integer                        not null,
   ATTRIBUTE_403        timestamp                      null,
   ATTRIBUTE_404        varchar(50)                    null,
   ATTRIBUTE_405        varchar(50)                    null,
   ATTRIBUTE_406        varchar(100)                   null,
   ATTRIBUTE_407        varchar(250)                   null,
   ATTRIBUTE_408        date                           null,
   ATTRIBUTE_409        date                           null,
   ATTRIBUTE_410        varchar(5)                     null,
   ATTRIBUTE_411        varchar(150)                   null,
   ATTRIBUTE_412        varchar(250)                   null,
   constraint PK_MEDIA_INFORMASI primary key (ATTRIBUTE_402)
);

/*==============================================================*/
/* Index: MEDIA_INFORMASI_PK                                    */
/*==============================================================*/
create unique index MEDIA_INFORMASI_PK on MEDIA_INFORMASI (
ATTRIBUTE_402 ASC
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
   ATTRIBUTE_247        integer                        not null,
   ATTRIBUTE_361        varchar(50)                    null,
   ATTRIBUTE_362        timestamp                      null,
   ATTRIBUTE_363        timestamp                      null
);

/*==============================================================*/
/* Index: MENCATAT_CONFIG_FK                                    */
/*==============================================================*/
create index MENCATAT_CONFIG_FK on MF_CONFIG (
ATTRIBUTE_247 ASC
);

/*==============================================================*/
/* Table: MF_EMAIL_SEND                                         */
/*==============================================================*/
create table MF_EMAIL_SEND 
(
   ATTRIBUTE_364        varchar(50)                    null,
   ATTRIBUTE_365        varchar(50)                    null,
   ATTRIBUTE_366        varchar(50)                    null,
   ATTRIBUTE_367        timestamp                      null,
   ATTRIBUTE_368        varchar(50)                    null,
   ATTRIBUTE_369        varchar(10)                    null
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
   ATTRIBUTE_353        varchar(50)                    not null,
   ATTRIBUTE_247        integer                        not null,
   ATTRIBUTE_354        varchar(50)                    null,
   ATTRIBUTE_355        varchar(50)                    null,
   ATTRIBUTE_356        varchar(5)                     null,
   ATTRIBUTE_357        integer                        null,
   ATTRIBUTE_358        varchar(50)                    null,
   constraint PK_MF_FIELD_CARI primary key (ATTRIBUTE_353)
);

/*==============================================================*/
/* Index: MF_FIELD_CARI_PK                                      */
/*==============================================================*/
create unique index MF_FIELD_CARI_PK on MF_FIELD_CARI (
ATTRIBUTE_353 ASC
);

/*==============================================================*/
/* Index: MENCATAT_PENCARIAN_FK                                 */
/*==============================================================*/
create index MENCATAT_PENCARIAN_FK on MF_FIELD_CARI (
ATTRIBUTE_247 ASC
);

/*==============================================================*/
/* Table: MF_FORM                                               */
/*==============================================================*/
create table MF_FORM 
(
   ATTRIBUTE_252        varchar(50)                    not null,
   ATTRIBUTE_253        varchar(70)                    null,
   ATTRIBUTE_254        varchar(20)                    null,
   ATTRIBUTE_255        integer                        null,
   ATTRIBUTE_256        varchar(50)                    null,
   ATTRIBUTE_257        varchar(50)                    null,
   ATTRIBUTE_258        varchar(50)                    null,
   ATTRIBUTE_259        integer                        null,
   ATTRIBUTE_260        varchar(50)                    null,
   ATTRIBUTE_261        varchar(50)                    null,
   ATTRIBUTE_262        integer                        null,
   ATTRIBUTE_263        varchar(50)                    null,
   ATTRIBUTE_264        integer                        null,
   ATTRIBUTE_265        integer                        null,
   constraint PK_MF_FORM primary key (ATTRIBUTE_252)
);

/*==============================================================*/
/* Index: MF_FORM_PK                                            */
/*==============================================================*/
create unique index MF_FORM_PK on MF_FORM (
ATTRIBUTE_252 ASC
);

/*==============================================================*/
/* Table: MF_FORM_NEW                                           */
/*==============================================================*/
create table MF_FORM_NEW 
(
   ATTRIBUTE_371        varchar(50)                    not null,
   ATTRIBUTE_372        varchar(70)                    null,
   ATTRIBUTE_383        varchar(20)                    null,
   ATTRIBUTE_373        integer                        null,
   ATTRIBUTE_374        varchar(50)                    null,
   ATTRIBUTE_375        varchar(50)                    null,
   ATTRIBUTE_376        varchar(50)                    null,
   ATTRIBUTE_377        integer                        null,
   ATTRIBUTE_378        varchar(50)                    null,
   ATTRIBUTE_379        varchar(50)                    null,
   ATTRIBUTE_380        integer                        null,
   ATTRIBUTE_381        varchar(50)                    null,
   ATTRIBUTE_382        integer                        null,
   constraint PK_MF_FORM_NEW primary key (ATTRIBUTE_371)
);

/*==============================================================*/
/* Index: MF_FORM_NEW_PK                                        */
/*==============================================================*/
create unique index MF_FORM_NEW_PK on MF_FORM_NEW (
ATTRIBUTE_371 ASC
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
   ATTRIBUTE_370        varchar(50)                    null
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
   ATTRIBUTE_413        integer                        not null,
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
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_1_FK on MF_JABATAN (
GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_2_FK on MF_JABATAN (
SUB_GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Index: MERUBAH_JABATAN_FK                                    */
/*==============================================================*/
create index MERUBAH_JABATAN_FK on MF_JABATAN (
ATTRIBUTE_413 ASC
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
   ATTRIBUTE_323        integer                        not null,
   ATTRIBUTE_324        timestamp                      null,
   ATTRIBUTE_325        timestamp                      null,
   ATTRIBUTE_326        timestamp                      null,
   ATTRIBUTE_327        varchar(50)                    null,
   ATTRIBUTE_328        varchar(50)                    null,
   ATTRIBUTE_329        varchar(5)                     null,
   ATTRIBUTE_330        varchar(50)                    null,
   ATTRIBUTE_331        timestamp                      null,
   ATTRIBUTE_332        varchar(2)                     null,
   constraint PK_MF_JAM_KERJA primary key (ATTRIBUTE_323)
);

/*==============================================================*/
/* Index: MF_JAM_KERJA_PK                                       */
/*==============================================================*/
create unique index MF_JAM_KERJA_PK on MF_JAM_KERJA (
ATTRIBUTE_323 ASC
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
   constraint PK_MF_JOBLIST primary key clustered (GROUP_JABATAN_ID, ITEM_ID)
);

/*==============================================================*/
/* Index: MF_JOBLIST_PK                                         */
/*==============================================================*/
create unique clustered index MF_JOBLIST_PK on MF_JOBLIST (
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
   ATTRIBUTE_333        varchar(5)                     not null,
   TYPE_SPRIN_ID        char(20)                       not null,
   ATTRIBUTE_334        varchar(50)                    null,
   constraint PK_MF_KLASIFIKASI_SURAT primary key (ATTRIBUTE_333)
);

/*==============================================================*/
/* Index: MF_KLASIFIKASI_SURAT_PK                               */
/*==============================================================*/
create unique index MF_KLASIFIKASI_SURAT_PK on MF_KLASIFIKASI_SURAT (
ATTRIBUTE_333 ASC
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
   ATTRIBUTE_247        integer                        not null,
   ATTRIBUTE_393        timestamp                      null,
   ATTRIBUTE_394        timestamp                      null,
   ATTRIBUTE_399        date                           null,
   ATTRIBUTE_400        varchar(50)                    null,
   ATTRIBUTE_395        timestamp                      null,
   ATTRIBUTE_396        varchar(2)                     null,
   ATTRIBUTE_397        timestamp                      null,
   ATTRIBUTE_398        timestamp                      null
);

/*==============================================================*/
/* Index: MENCATAT_FINGER_FK                                    */
/*==============================================================*/
create index MENCATAT_FINGER_FK on MF_LOAD_FINGER (
ATTRIBUTE_247 ASC
);

/*==============================================================*/
/* Table: MF_ORGZ_SIAGA                                         */
/*==============================================================*/
create table MF_ORGZ_SIAGA 
(
   ATTRIBUTE_335        integer                        not null,
   ATTRIBUTE_336        varchar(50)                    null,
   ATTRIBUTE_337        integer                        null,
   ATTRIBUTE_338        float                          null,
   ATTRIBUTE_339        varchar(50)                    null,
   ATTRIBUTE_340        varchar(2)                     null,
   ATTRIBUTE_341        varchar(50)                    null,
   constraint PK_MF_ORGZ_SIAGA primary key (ATTRIBUTE_335)
);

/*==============================================================*/
/* Index: MF_ORGZ_SIAGA_PK                                      */
/*==============================================================*/
create unique index MF_ORGZ_SIAGA_PK on MF_ORGZ_SIAGA (
ATTRIBUTE_335 ASC
);

/*==============================================================*/
/* Table: MF_POT                                                */
/*==============================================================*/
create table MF_POT 
(
   ATTRIBUTE_186        integer                        not null,
   ATTRIBUTE_187        varchar(50)                    null,
   ATTRIBUTE_188        varchar(50)                    null,
   ATTRIBUTE_189        float                          null,
   ATTRIBUTE_190        timestamp                      null,
   ATTRIBUTE_191        float                          null,
   ATTRIBUTE_192        float                          null,
   ATTRIBUTE_193        varchar(50)                    null,
   ATTRIBUTE_194        varchar(50)                    null,
   ATTRIBUTE_195        timestamp                      null,
   ATTRIBUTE_196        varchar(2)                     null,
   ATTRIBUTE_305        varchar(250)                   null,
   ATTRIBUTE_306        float                          null,
   ATTRIBUTE_307        varchar(10)                    null,
   constraint PK_MF_POT primary key (ATTRIBUTE_186)
);

/*==============================================================*/
/* Index: MF_POTONGAN_PK                                        */
/*==============================================================*/
create unique index MF_POTONGAN_PK on MF_POT (
ATTRIBUTE_186 ASC
);

/*==============================================================*/
/* Table: MF_POTONGAN                                           */
/*==============================================================*/
create table MF_POTONGAN 
(
   ATTRIBUTE_342        integer                        not null,
   ATTRIBUTE_343        varchar(50)                    null,
   ATTRIBUTE_344        varchar(50)                    null,
   ATTRIBUTE_345        float                          null,
   ATTRIBUTE_346        timestamp                      null,
   ATTRIBUTE_347        float                          null,
   ATTRIBUTE_348        float                          null,
   ATTRIBUTE_349        varchar(50)                    null,
   ATTRIBUTE_350        varchar(50)                    null,
   ATTRIBUTE_351        timestamp                      null,
   ATTRIBUTE_352        varchar(2)                     null,
   constraint PK_MF_POTONGAN primary key (ATTRIBUTE_342)
);

/*==============================================================*/
/* Index: MF_POTONGAN_PK                                        */
/*==============================================================*/
create unique index MF_POTONGAN_PK on MF_POTONGAN (
ATTRIBUTE_342 ASC
);

/*==============================================================*/
/* Table: MF_PRIORITY_TRANSAKSI                                 */
/*==============================================================*/
create table MF_PRIORITY_TRANSAKSI 
(
   ATTRIBUTE_319        varchar(50)                    null,
   ATTRIBUTE_320        integer                        null,
   ATTRIBUTE_321        varchar(50)                    null,
   ATTRIBUTE_322        varchar(5)                     null
);

/*==============================================================*/
/* Table: MF_SATUAN                                             */
/*==============================================================*/
create table MF_SATUAN 
(
   ATTRIBUTE_314        integer                        not null,
   ATTRIBUTE_315        varchar(50)                    null,
   ATTRIBUTE_316        varchar(50)                    null,
   ATTRIBUTE_317        varchar(50)                    null,
   ATTRIBUTE_318        integer                        null,
   constraint PK_MF_SATUAN primary key (ATTRIBUTE_314)
);

/*==============================================================*/
/* Index: MF_SATUAN_PK                                          */
/*==============================================================*/
create unique index MF_SATUAN_PK on MF_SATUAN (
ATTRIBUTE_314 ASC
);

/*==============================================================*/
/* Table: MF_SHIFT                                              */
/*==============================================================*/
create table MF_SHIFT 
(
   ATTRIBUTE_308        varchar(10)                    not null,
   ATTRIBUTE_247        integer                        not null,
   ATTRIBUTE_309        varchar(50)                    null,
   ATTRIBUTE_310        varchar(50)                    null,
   ATTRIBUTE_311        timestamp                      null,
   ATTRIBUTE_312        timestamp                      null,
   ATTRIBUTE_313        date                           null,
   constraint PK_MF_SHIFT primary key (ATTRIBUTE_308)
);

/*==============================================================*/
/* Index: MF_SHIFT_PK                                           */
/*==============================================================*/
create unique index MF_SHIFT_PK on MF_SHIFT (
ATTRIBUTE_308 ASC
);

/*==============================================================*/
/* Index: MENCATAT_SHIFT_FK                                     */
/*==============================================================*/
create index MENCATAT_SHIFT_FK on MF_SHIFT (
ATTRIBUTE_247 ASC
);

/*==============================================================*/
/* Table: MF_STATUS                                             */
/*==============================================================*/
create table MF_STATUS 
(
   ATTRIBUTE_221        integer                        not null,
   ATTRIBUTE_222        varchar(50)                    null,
   ATTRIBUTE_223        varchar(50)                    null,
   ATTRIBUTE_224        varchar(50)                    null,
   ATTRIBUTE_225        varchar(50)                    null,
   ATTRIBUTE_226        varchar(50)                    null,
   constraint PK_MF_STATUS primary key (ATTRIBUTE_221)
);

/*==============================================================*/
/* Index: MF_STATUS_PK                                          */
/*==============================================================*/
create unique index MF_STATUS_PK on MF_STATUS (
ATTRIBUTE_221 ASC
);

/*==============================================================*/
/* Table: MF_SU                                                 */
/*==============================================================*/
create table MF_SU 
(
   NIP                  varchar(50)                    not null,
   ATTRIBUTE_391        varchar(50)                    null,
   ATTRIBUTE_392        varchar(50)                    null
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
   ATTRIBUTE_183        varchar(2)                     null,
   ATTRIBUTE_184        varchar(4)                     null,
   ATTRIBUTE_185        varchar(5)                     null,
   ATTRIBUTE_181        varchar(50)                    null,
   ATTRIBUTE_182        timestamp                      null
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
   ATTRIBUTE_247        integer                        not null,
   ATTRIBUTE_390        timestamp                      null
);

/*==============================================================*/
/* Index: MENCATAT_TR_FK                                        */
/*==============================================================*/
create index MENCATAT_TR_FK on MF_TR (
ATTRIBUTE_247 ASC
);

/*==============================================================*/
/* Table: MF_TUNJANGAN                                          */
/*==============================================================*/
create table MF_TUNJANGAN 
(
   TUNJANGAN_ID         integer                        not null,
   ATTRIBUTE_198        varchar(50)                    null,
   ATTRIBUTE_199        varchar(50)                    null,
   ATTRIBUTE_200        float                          null,
   ATTRIBUTE_201        date                           null,
   ATTRIBUTE_202        integer                        null,
   ATTRIBUTE_203        varchar(50)                    null,
   ATTRIBUTE_204        varchar(50)                    null,
   ATTRIBUTE_205        timestamp                      null,
   ATTRIBUTE_206        varchar(250)                   null,
   ATTRIBUTE_207        integer                        null,
   ATTRIBUTE_208        varchar(5)                     null,
   ATTRIBUTE_209        varchar(50)                    null,
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
   ATTRIBUTE_359        integer                        not null,
   ATTRIBUTE_360        varchar(50)                    null,
   constraint PK_MF_UNSUR_KEGIATAN primary key (ATTRIBUTE_359)
);

/*==============================================================*/
/* Index: MF_UNSUR_KEGIATAN_PK                                  */
/*==============================================================*/
create unique index MF_UNSUR_KEGIATAN_PK on MF_UNSUR_KEGIATAN (
ATTRIBUTE_359 ASC
);

/*==============================================================*/
/* Table: MF__SUB_GROUP_JABATAN                                 */
/*==============================================================*/
create table MF__SUB_GROUP_JABATAN 
(
   SUB_GROUP_JABATAN_ID integer                        not null,
   NAMA_SUB_GROUP_JABATAN varchar(150)                   not null,
   constraint PK_MF__SUB_GROUP_JABATAN primary key (SUB_GROUP_JABATAN_ID)
);

/*==============================================================*/
/* Index: MF__SUB_GROUP_JABATAN_PK                              */
/*==============================================================*/
create unique index MF__SUB_GROUP_JABATAN_PK on MF__SUB_GROUP_JABATAN (
SUB_GROUP_JABATAN_ID ASC
);

/*==============================================================*/
/* Table: MONITORING_APP                                        */
/*==============================================================*/
create table MONITORING_APP 
(
   ATTRIBUTE_247        integer                        not null,
   ATTRIBUTE_384        varchar(50)                    null,
   ATTRIBUTE_385        varchar(50)                    null,
   ATTRIBUTE_386        varchar(50)                    null,
   ATTRIBUTE_387        timestamp                      null,
   ATTRIBUTE_388        timestamp                      null,
   ATTRIBUTE_389        varchar(5)                     null
);

/*==============================================================*/
/* Index: MENCATAT_LOG_APP_FK                                   */
/*==============================================================*/
create index MENCATAT_LOG_APP_FK on MONITORING_APP (
ATTRIBUTE_247 ASC
);

/*==============================================================*/
/* Table: OTORISASI                                             */
/*==============================================================*/
create table OTORISASI 
(
   ATTRIBUTE_293        varchar(100)                   not null,
   NIP                  varchar(50)                    null,
   ATTRIBUTE_294        varchar(50)                    null,
   ATTRIBUTE_295        integer                        null,
   ATTRIBUTE_296        varchar(100)                   null,
   ATTRIBUTE_297        integer                        null,
   ATTRIBUTE_298        varchar(50)                    null,
   ATTRIBUTE_299        timestamp                      null,
   ATTRIBUTE_300        varchar(150)                   null,
   ATTRIBUTE_301        varchar(150)                   null,
   ATTRIBUTE_302        integer                        null,
   ATTRIBUTE_303        integer                        null,
   ATTRIBUTE_304        timestamp                      null,
   constraint PK_OTORISASI primary key (ATTRIBUTE_293)
);

/*==============================================================*/
/* Index: OTORISASI_PK                                          */
/*==============================================================*/
create unique index OTORISASI_PK on OTORISASI (
ATTRIBUTE_293 ASC
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
   ATTRIBUTE_420        integer                        not null,
   ATTRIBUTE_293        varchar(100)                   not null,
   NIP                  varchar(50)                    not null,
   UNIT_KERJA_ID        integer                        not null,
   ATTRIBUTE_421        varchar(50)                    null,
   ATTRIBUTE_422        integer                        null,
   ATTRIBUTE_423        varchar(100)                   null,
   ATTRIBUTE_424        integer                        null,
   ATTRIBUTE_425        varchar(50)                    null,
   ATTRIBUTE_426        timestamp                      null,
   ATTRIBUTE_427        varchar(150)                   null,
   ATTRIBUTE_428        varchar(150)                   null,
   ATTRIBUTE_429        integer                        null,
   ATTRIBUTE_430        integer                        null,
   ATTRIBUTE_431        integer                        null,
   ATTRIBUTE_432        integer                        null,
   ATTRIBUTE_433        timestamp                      null,
   ATTRIBUTE_434        timestamp                      null,
   constraint PK_OTORISASI_HISTORY primary key (ATTRIBUTE_420)
);

/*==============================================================*/
/* Index: OTORISASI_HISTORY_PK                                  */
/*==============================================================*/
create unique index OTORISASI_HISTORY_PK on OTORISASI_HISTORY (
ATTRIBUTE_420 ASC
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
ATTRIBUTE_293 ASC
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
   ATTRIBUTE_247        integer                        not null,
   NIP                  varchar(50)                    not null,
   ATTRIBUTE_435        date                           null,
   ATTRIBUTE_436        varchar(50)                    null,
   ATTRIBUTE_437        varchar(50)                    null,
   ATTRIBUTE_438        timestamp                      null,
   ATTRIBUTE_439        varchar(50)                    null,
   ATTRIBUTE_440        varchar(250)                   null
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
ATTRIBUTE_247 ASC
);

/*==============================================================*/
/* Table: PERUBAHAN_JABATAN                                     */
/*==============================================================*/
create table PERUBAHAN_JABATAN 
(
   ATTRIBUTE_413        integer                        not null,
   JABATAN_ID           integer                        null,
   constraint PK_PERUBAHAN_JABATAN primary key (ATTRIBUTE_413)
);

/*==============================================================*/
/* Index: PERUBAHAN_JABATAN_PK                                  */
/*==============================================================*/
create unique index PERUBAHAN_JABATAN_PK on PERUBAHAN_JABATAN (
ATTRIBUTE_413 ASC
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
   JABATAN_ID           integer                        not null,
   NIP                  varchar(50)                    not null,
   GUID_SKP_PEG         varchar(100)                   not null,
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
   constraint PK_SKP_PEGAWAI primary key clustered (JABATAN_ID, NIP, GUID_SKP_PEG)
);

/*==============================================================*/
/* Index: SKP_PEGAWAI_PK                                        */
/*==============================================================*/
create unique clustered index SKP_PEGAWAI_PK on SKP_PEGAWAI (
JABATAN_ID ASC,
NIP ASC,
GUID_SKP_PEG ASC
);

/*==============================================================*/
/* Index: DILAKSANAKAN_DI_FK                                    */
/*==============================================================*/
create index DILAKSANAKAN_DI_FK on SKP_PEGAWAI (
JABATAN_ID ASC
);

/*==============================================================*/
/* Index: DIMILIKI_OLEH_FK                                      */
/*==============================================================*/
create index DIMILIKI_OLEH_FK on SKP_PEGAWAI (
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
   ATTRIBUTE_441        timestamp                      null,
   ATTRIBUTE_442        varchar(50)                    null,
   ATTRIBUTE_443        varchar(50)                    null,
   ATTRIBUTE_444        timestamp                      null,
   ATTRIBUTE_445        timestamp                      null,
   ATTRIBUTE_447        varchar(10)                    null,
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
/* Index: BAWAHAN_USER_FK                                       */
/*==============================================================*/
create index BAWAHAN_USER_FK on SKP_PEGAWAI_HEAD (
JABATAN_ID ASC,
NIP ASC,
GUID_SKP_PEG ASC
);

/*==============================================================*/
/* Index: GOL_PEGAWAI_HEAD_FK                                   */
/*==============================================================*/
create index GOL_PEGAWAI_HEAD_FK on SKP_PEGAWAI_HEAD (
GOL_ID ASC
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
   ATTRIBUTE_288        integer                        null,
   ATTRIBUTE_289        varchar(50)                    null,
   ATTRIBUTE_291        varchar(50)                    null,
   ATTRIBUTE_292        timestamp                      null
);

/*==============================================================*/
/* Index: DIMILIKI_OLEH_USER_FK                                 */
/*==============================================================*/
create index DIMILIKI_OLEH_USER_FK on USER_ACCOUNT (
NIP ASC
);

alter table ABSENSI
   add constraint FK_ABSENSI_DATA_BACK_ABSENSI_ foreign key (ABSENSI_ID2)
      references ABSENSI_BACKUP (ABSENSI_ID2)
      on update restrict
      on delete restrict;

alter table ABSENSI
   add constraint FK_ABSENSI_DATA_TEMP_ABSENSI_ foreign key (ABSENSI_ID3)
      references ABSENSI_TEMP (ABSENSI_ID3)
      on update restrict
      on delete restrict;

alter table ABSENSI
   add constraint FK_ABSENSI_DITERAPKA_MF_POT foreign key (ATTRIBUTE_186)
      references MF_POT (ATTRIBUTE_186)
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
   add constraint FK_BUKU_HAR_TERKAIT_D_SKP_PEGA foreign key (JABATAN_ID, NIP, GUID_SKP_PEG)
      references SKP_PEGAWAI (JABATAN_ID, NIP, GUID_SKP_PEG)
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
   add constraint FK_DRH_MEREKAM_D_LOG_TRAN foreign key (ATTRIBUTE_247)
      references LOG_TRANSAKSI (ATTRIBUTE_247)
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
   add constraint FK_HAK_AKSE_UNTUK_FOR_MF_FORM foreign key (ATTRIBUTE_252)
      references MF_FORM (ATTRIBUTE_252)
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
   add constraint FK_LOG_ACTI_MEMBACKUP_LOG_ACTI foreign key (ATTRIBUTE_290)
      references LOG_ACTIVITIY_BACKUP (ATTRIBUTE_290)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY
   add constraint FK_LOG_ACTI_MEMILIKI__MF_STATU foreign key (ATTRIBUTE_221)
      references MF_STATUS (ATTRIBUTE_221)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY
   add constraint FK_LOG_ACTI_TRANSAKSI_LOG_TRAN foreign key (ATTRIBUTE_247)
      references LOG_TRANSAKSI (ATTRIBUTE_247)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY
   add constraint FK_LOG_ACTI_UNIT_MELA_MF_UNIT_ foreign key (UNIT_KERJA_ID)
      references MF_UNIT_KERJA (UNIT_KERJA_ID)
      on update restrict
      on delete restrict;

alter table LOG_ACTIVITIY_BACKUP
   add constraint FK_LOG_ACTI_MEMBACKUP_LOG_ACTI foreign key (ATTRIBUTE_210)
      references LOG_ACTIVITIY (ATTRIBUTE_210)
      on update restrict
      on delete restrict;

alter table LOG_TRANSAKSI
   add constraint FK_LOG_TRAN_DATA_BACK_LOG_TRAN foreign key (ATTRIBUTE_401)
      references LOG_TRANSAKSI_BACKUP (ATTRIBUTE_401)
      on update restrict
      on delete restrict;

alter table LOG_TRANSAKSI
   add constraint FK_LOG_TRAN_TRANSAKSI_PEGAWAI foreign key (NIP)
      references PEGAWAI (NIP)
      on update restrict
      on delete restrict;

alter table LOG_TRANSAKSI_BACKUP
   add constraint FK_LOG_TRAN_DATA_BACK_LOG_TRAN foreign key (ATTRIBUTE_247)
      references LOG_TRANSAKSI (ATTRIBUTE_247)
      on update restrict
      on delete restrict;

alter table MF_CONFIG
   add constraint FK_MF_CONFI_MENCATAT__LOG_TRAN foreign key (ATTRIBUTE_247)
      references LOG_TRANSAKSI (ATTRIBUTE_247)
      on update restrict
      on delete restrict;

alter table MF_FIELD_CARI
   add constraint FK_MF_FIELD_MENCATAT__LOG_TRAN foreign key (ATTRIBUTE_247)
      references LOG_TRANSAKSI (ATTRIBUTE_247)
      on update restrict
      on delete restrict;

alter table MF_HOST_NAME_FP
   add constraint FK_MF_HOST__HOST_DARI_MF_UNIT_ foreign key (UNIT_KERJA_ID)
      references MF_UNIT_KERJA (UNIT_KERJA_ID)
      on update restrict
      on delete restrict;

alter table MF_JABATAN
   add constraint FK_MF_JABAT_MERUBAH_J_PERUBAHA foreign key (ATTRIBUTE_413)
      references PERUBAHAN_JABATAN (ATTRIBUTE_413)
      on update restrict
      on delete restrict;

alter table MF_JABATAN
   add constraint FK_MF_JABAT_TERMASUK__MF_GROUP foreign key (GROUP_JABATAN_ID)
      references MF_GROUP_JABATAN (GROUP_JABATAN_ID)
      on update restrict
      on delete restrict;

alter table MF_JABATAN
   add constraint FK_MF_JABAT_TERMASUK__MF__SUB_ foreign key (SUB_GROUP_JABATAN_ID)
      references MF__SUB_GROUP_JABATAN (SUB_GROUP_JABATAN_ID)
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
   add constraint FK_MF_LOAD__MENCATAT__LOG_TRAN foreign key (ATTRIBUTE_247)
      references LOG_TRANSAKSI (ATTRIBUTE_247)
      on update restrict
      on delete restrict;

alter table MF_SHIFT
   add constraint FK_MF_SHIFT_MENCATAT__LOG_TRAN foreign key (ATTRIBUTE_247)
      references LOG_TRANSAKSI (ATTRIBUTE_247)
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
   add constraint FK_MF_TR_MENCATAT__LOG_TRAN foreign key (ATTRIBUTE_247)
      references LOG_TRANSAKSI (ATTRIBUTE_247)
      on update restrict
      on delete restrict;

alter table MONITORING_APP
   add constraint FK_MONITORI_MENCATAT__LOG_TRAN foreign key (ATTRIBUTE_247)
      references LOG_TRANSAKSI (ATTRIBUTE_247)
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
   add constraint FK_OTORISAS_OTORISASI_OTORISAS foreign key (ATTRIBUTE_293)
      references OTORISASI (ATTRIBUTE_293)
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
   add constraint FK_PEG_MUTA_MENCATAT__LOG_TRAN foreign key (ATTRIBUTE_247)
      references LOG_TRANSAKSI (ATTRIBUTE_247)
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
   add constraint FK_SKP_PEGA_BAWAHAN_S_SKP_PEGA foreign key (JABATAN_ID, NIP, GUID_SKP_PEG)
      references SKP_PEGAWAI (JABATAN_ID, NIP, GUID_SKP_PEG)
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

