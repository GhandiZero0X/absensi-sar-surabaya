# app/models/absensiModel.py
from app import db


class Absensi(db.Model):
    """
    Model untuk tabel ABSENSI.
    Merepresentasikan data transaksi kehadiran (absensi) pegawai.
    Primary Key : ABSENSI_ID
    Foreign Key : POTONGAN_ID   -> MF_POT.POTONGAN_ID
                  FINGER_ID     -> TIME_RECORDER.FINGER_ID
                  TGL_KERJA     -> KALENDER.TGL_KERJA
                  ABSENSI_BACKUP_ID -> ABSENSI_BACKUP.ABSENSI_BACKUP_ID
                  ABSENSI_TEMP_ID   -> ABSENSI_TEMP.ABSENSI_TEMP_ID
    """
    __tablename__ = 'ABSENSI'

    # Primary Key
    ABSENSI_ID = db.Column(db.Integer, primary_key=True)

    # Foreign Key (NOT NULL sesuai DDL asli)
    POTONGAN_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_POT.POTONGAN_ID'),
        nullable=False
    )
    TGL_KERJA = db.Column(
        db.DateTime,
        db.ForeignKey('KALENDER.TGL_KERJA'),
        nullable=False
    )
    ABSENSI_BACKUP_ID = db.Column(
        db.Integer,
        db.ForeignKey('ABSENSI_BACKUP.ABSENSI_BACKUP_ID'),
        nullable=False
    )
    ABSENSI_TEMP_ID = db.Column(
        db.Integer,
        db.ForeignKey('ABSENSI_TEMP.ABSENSI_TEMP_ID'),
        nullable=False
    )
    FINGER_ID = db.Column(
        db.Integer,
        db.ForeignKey('TIME_RECORDER.FINGER_ID'),
        nullable=False
    )

    # Jam masuk / keluar aktual
    TGL_JAM_IN = db.Column(db.DateTime, nullable=True)
    TGL_JAM_OUT = db.Column(db.DateTime, nullable=True)
    KET_IN = db.Column(db.String(850), nullable=True)
    TRANSAKSI_IN = db.Column(db.String(50), nullable=True)  # CHAR(50) di DDL
    UPDATE_IN_BY = db.Column(db.String(50), nullable=True)
    UPDATE_IN_DATE = db.Column(db.DateTime, nullable=True)
    KET_OUT = db.Column(db.String(850), nullable=True)
    TRANSAKSI_OUT = db.Column(db.String(50), nullable=True)
    UPDATE_OUT_BY = db.Column(db.String(50), nullable=True)
    UPDATE_OUT_DATE = db.Column(db.DateTime, nullable=True)

    # Keterlambatan & pulang sebelum