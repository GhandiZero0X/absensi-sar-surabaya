# app/models/lemburModel.py
from app import db
from datetime import datetime


class Lembur(db.Model):
    """
    Model untuk tabel LEMBUR.
    Menyimpan data lembur pegawai.
    """
    __tablename__ = 'LEMBUR'

    # Primary key synthetic
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    # Data pegawai & tanggal kerja
    NIP = db.Column(db.String(50), nullable=True)
    TGL_KERJA = db.Column(db.DateTime, nullable=True)

    # Jam lembur aktual (timestamp di DB)
    JAM_IN = db.Column(db.DateTime, nullable=True)
    JAM_OUT = db.Column(db.DateTime, nullable=True)

    # Jam baku (setelah validasi/pembulatan)
    JAM_BAKU_IN = db.Column(db.DateTime, nullable=True)
    JAM_BAKU_OUT = db.Column(db.DateTime, nullable=True)

    # Keterangan & surat pendukung
    KETERANGAN = db.Column(db.String(50), nullable=True)
    NO_SURAT = db.Column(db.String(250), nullable=True)

    # Metadata audit
    UPDATE_BY = db.Column(db.String(50), nullable=True)
    UPDATE_DATE = db.Column(db.DateTime, nullable=True)

    def __repr__(self):
        return f'<Lembur id:{self.id} NIP:{self.NIP} TGL:{self.TGL_KERJA}>'

    def to_dict(self):
        return {
            'id': self.id,
            'nip': self.NIP,
            'tgl_kerja': self.TGL_KERJA.isoformat() if self.TGL_KERJA else None,
            'jam_in': self.JAM_IN.strftime('%H:%M:%S') if self.JAM_IN else None,
            'jam_out': self.JAM_OUT.strftime('%H:%M:%S') if self.JAM_OUT else None,
            'jam_baku_in': self.JAM_BAKU_IN.strftime('%H:%M:%S') if self.JAM_BAKU_IN else None,
            'jam_baku_out': self.JAM_BAKU_OUT.strftime('%H:%M:%S') if self.JAM_BAKU_OUT else None,
            'keterangan': self.KETERANGAN,
            'no_surat': self.NO_SURAT,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None
        }