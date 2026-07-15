# app/models/subGroupJabatanModel.py
from app import db


class MfSubGroupJabatan(db.Model):
    """
    Model untuk tabel MF_SUB_GROUP_JABATAN.
    Menyimpan data master sub-kelompok jabatan.

    Primary Key : SUB_GROUP_JABATAN_ID
    """
    __tablename__ = 'MF_SUB_GROUP_JABATAN'

    # Primary Key
    SUB_GROUP_JABATAN_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Nama sub-kelompok jabatan
    NAMA_SUB_GROUP_JABATAN = db.Column(db.String(150), nullable=False)

    def __repr__(self):
        return f'<MfSubGroupJabatan {self.SUB_GROUP_JABATAN_ID} - {self.NAMA_SUB_GROUP_JABATAN}>'

    def to_dict(self):
        return {
            'sub_group_jabatan_id': self.SUB_GROUP_JABATAN_ID,
            'nama_sub_group_jabatan': self.NAMA_SUB_GROUP_JABATAN
        }