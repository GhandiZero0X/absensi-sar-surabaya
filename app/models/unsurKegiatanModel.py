# app/models/unsurKegiatanModel.py
from app import db


class MfUnsurKegiatan(db.Model):
    """
    Model untuk tabel MF_UNSUR_KEGIATAN.
    Menyimpan daftar unsur kegiatan dalam SKP.

    Primary Key : UNSUR_ID
    """
    __tablename__ = 'MF_UNSUR_KEGIATAN'

    UNSUR_ID = db.Column(db.Integer, primary_key=True, nullable=False)
    DESKRIPSI_UNSUR = db.Column(db.String(50))

    def __repr__(self):
        return f'<MfUnsurKegiatan {self.UNSUR_ID} - {self.DESKRIPSI_UNSUR}>'

    def to_dict(self):
        return {
            'unsur_id': self.UNSUR_ID,
            'deskripsi_unsur': self.DESKRIPSI_UNSUR
        }