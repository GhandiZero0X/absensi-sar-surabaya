# app/models/perubahanJabatanModel.py
from app import db


class PerubahanJabatan(db.Model):
    """
    Model untuk tabel PERUBAHAN_JABATAN.
    Menyimpan pemetaan antara jabatan lama (JABATAN_ID) dan
    jabatan baru (JABATAN_ID_BARU) dalam proses restrukturisasi.

    Primary Key : JABATAN_ID_BARU
    Foreign Key : JABATAN_ID -> MF_JABATAN (JABATAN_ID)
    """
    __tablename__ = 'PERUBAHAN_JABATAN'

    # Primary Key
    JABATAN_ID_BARU = db.Column(db.Integer, primary_key=True, nullable=False)

    # Foreign Key ke MF_JABATAN (jabatan lama)
    JABATAN_ID = db.Column(db.Integer, db.ForeignKey('MF_JABATAN.JABATAN_ID'), nullable=True)

    def __repr__(self):
        return f'<PerubahanJabatan Baru:{self.JABATAN_ID_BARU} Lama:{self.JABATAN_ID}>'

    def to_dict(self):
        return {
            'jabatan_id_baru': self.JABATAN_ID_BARU,
            'jabatan_id': self.JABATAN_ID
        }