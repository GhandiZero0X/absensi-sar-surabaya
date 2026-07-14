# app/models/satuanModel.py
from app import db


class MfSatuan(db.Model):
    """
    Model untuk tabel MF_SATUAN.
    Menyimpan master satuan pengukuran kegiatan (SKP).

    Primary Key : SATUAN_ID
    """
    __tablename__ = 'MF_SATUAN'

    SATUAN_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    ACTIVITY = db.Column(db.String(50))      # Jenis aktivitas terkait satuan
    SATUAN = db.Column(db.String(50))        # Nama satuan (misal: buah, lembar)
    PARAMETER = db.Column(db.String(50))     # Parameter tambahan
    URUT_SATUAN = db.Column(db.Integer)      # Urutan tampilan

    def __repr__(self):
        return f'<MfSatuan {self.SATUAN_ID} - {self.SATUAN}>'

    def to_dict(self):
        return {
            'satuan_id': self.SATUAN_ID,
            'activity': self.ACTIVITY,
            'satuan': self.SATUAN,
            'parameter': self.PARAMETER,
            'urut_satuan': self.URUT_SATUAN
        }