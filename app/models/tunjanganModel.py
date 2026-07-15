# app/models/tunjanganModel.py
from app import db


class MfTunjangan(db.Model):
    """
    Model untuk tabel MF_TUNJANGAN.
    Merepresentasikan data master tunjangan pegawai.
    Primary Key : TUNJANGAN_ID
    Digunakan sebagai referensi oleh tabel PEGAWAI (TUNJANGAN_ID).
    """
    __tablename__ = 'MF_TUNJANGAN'

    # Primary Key
    TUNJANGAN_ID = db.Column(db.Integer, primary_key=True)

    # Data tunjangan
    JENIS_TUNJANGAN = db.Column(db.String(50), nullable=True)
    ACTIVITY = db.Column(db.String(50), nullable=True)
    NOMINAL = db.Column(db.Float, nullable=True)
    TGL_MULAI = db.Column(db.Date, nullable=True)
    HARI_KERJA = db.Column(db.Integer, nullable=True)
    FUNGSIONAL = db.Column(db.String(50), nullable=True)
    STATUS_PEG = db.Column(db.Integer, nullable=True)
    SHIFT = db.Column(db.String(5), nullable=True)
    UNIT_KERJA_ID = db.Column(db.String(50), nullable=True)

    # Metadata audit
    UPDATE_BY = db.Column(db.String(50), nullable=True)
    UPDATE_DATE = db.Column(db.DateTime, nullable=True)
    DOKREFF = db.Column(db.String(250), nullable=True)

    # Representasi objek (memudahkan debugging di console/log)
    def __repr__(self):
        return f'<MfTunjangan {self.TUNJANGAN_ID} - {self.JENIS_TUNJANGAN}>'

    # Helper: ubah objek jadi dict (berguna untuk response JSON/API)
    def to_dict(self):
        return {
            'tunjangan_id': self.TUNJANGAN_ID,
            'jenis_tunjangan': self.JENIS_TUNJANGAN,
            'activity': self.ACTIVITY,
            'nominal': self.NOMINAL,
            'tgl_mulai': self.TGL_MULAI.isoformat() if self.TGL_MULAI else None,
            'hari_kerja': self.HARI_KERJA,
            'fungsional': self.FUNGSIONAL,
            'status_peg': self.STATUS_PEG,
            'shift': self.SHIFT,
            'unit_kerja_id': self.UNIT_KERJA_ID,
            'dokreff': self.DOKREFF,
        }