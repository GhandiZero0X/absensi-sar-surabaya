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
                  NIP           -> PEGAWAI.NIP  (TAMBAHAN BARU)
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

    # ============================================================
    # TAMBAHAN BARU: Foreign Key ke PEGAWAI
    # ============================================================
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        nullable=True  # NULL dulu supaya data lama tidak error
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

    # Keterlambatan & pulang sebelum waktunya
    TINGKAT_TLM = db.Column(db.String(50), nullable=True)
    TOTAL_TLM = db.Column(db.Float, nullable=True)
    TOTAL_PSW = db.Column(db.Float, nullable=True)
    TINGKAT_PSW = db.Column(db.String(50), nullable=True)
    IS_INVALID = db.Column(db.String(1), nullable=True)
    IS_OUTVALID = db.Column(db.String(1), nullable=True)
    AWAL_TLM = db.Column(db.Float, nullable=True)
    PERSEN_POT_TLM = db.Column(db.Float, nullable=True)
    PERSEN_POT_PSW = db.Column(db.Float, nullable=True)

    # Jam baku (standar)
    TGL_JAM_BAKU_IN = db.Column(db.DateTime, nullable=True)
    TGL_JAM_BAKU_OUT = db.Column(db.DateTime, nullable=True)

    # Referensi transaksi asal
    TRAKSAKSI_ID_FROM = db.Column(db.String(250), nullable=True)

    # Dokumen pendukung
    PENDUKUNG_IN = db.Column(db.String(50), nullable=True)
    PENDUKUNG_OUT = db.Column(db.String(50), nullable=True)

    # History perubahan
    HISTORY_TRANSAKSI_IN = db.Column(db.String(450), nullable=True)
    HISTORY_TRANSAKSI_OUT = db.Column(db.String(450), nullable=True)

    # Status umum (mungkin untuk flag integrasi)
    STATUS_UM = db.Column(db.Integer, nullable=True)

    # ============================================================
    # Relationship
    # ============================================================
    pegawai = db.relationship(
        'Pegawai',
        backref='absensi_list',
        lazy=True
    )

    # Representasi objek
    def __repr__(self):
        return f'<Absensi {self.ABSENSI_ID} - NIP: {self.NIP} - Tgl: {self.TGL_KERJA}>'

    # Helper: ubah objek jadi dict
    def to_dict(self):
        return {
            'absensi_id': self.ABSENSI_ID,
            'nip': self.NIP,
            'finger_id': self.FINGER_ID,
            'tgl_kerja': self.TGL_KERJA.isoformat() if self.TGL_KERJA else None,
            'tgl_jam_in': self.TGL_JAM_IN.isoformat() if self.TGL_JAM_IN else None,
            'tgl_jam_out': self.TGL_JAM_OUT.isoformat() if self.TGL_JAM_OUT else None,
            'transaksi_in': self.TRANSAKSI_IN,
            'transaksi_out': self.TRANSAKSI_OUT,
            'tingkat_tlm': self.TINGKAT_TLM,
            'tingkat_psw': self.TINGKAT_PSW,
            'total_tlm': self.TOTAL_TLM,
            'total_psw': self.TOTAL_PSW,
            'pendukung_in': self.PENDUKUNG_IN,
            'pendukung_out': self.PENDUKUNG_OUT,
        }