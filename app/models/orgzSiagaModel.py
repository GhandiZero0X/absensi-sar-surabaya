# app/models/orgzSiagaModel.py
from app import db


class MfOrgzSiaga(db.Model):
    """
    Model untuk tabel MF_ORGZ_SIAGA.
    Menyimpan struktur organisasi siaga (tim jaga).

    Primary Key : ORGZ_SIAGA_ID
    """
    __tablename__ = 'MF_ORGZ_SIAGA'

    # Primary Key
    ORGZ_SIAGA_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Nama fungsional (misal: Komandan Jaga, Anggota)
    FUNGSIONAL = db.Column(db.String(50))

    # Referensi ke induk organisasi siaga (self-referencing)
    PARENT_ID = db.Column(db.Integer)

    # Urutan tampil fungsional (bisa desimal untuk sub-urutan)
    URUT_FUNGSIONAL = db.Column(db.Float)

    # Deskripsi tambahan
    DESKRIPSI = db.Column(db.String(50))

    # Inisial singkat (misal: KJ, A)
    INISIAL = db.Column(db.String(2))

    # Flag marker (bisa untuk status atau pengelompokan)
    FLAG = db.Column(db.String(50))

    def __repr__(self):
        return f'<MfOrgzSiaga {self.ORGZ_SIAGA_ID} - {self.FUNGSIONAL}>'

    def to_dict(self):
        return {
            'orgz_siaga_id': self.ORGZ_SIAGA_ID,
            'fungsional': self.FUNGSIONAL,
            'parent_id': self.PARENT_ID,
            'urut_fungsional': self.URUT_FUNGSIONAL,
            'deskripsi': self.DESKRIPSI,
            'inisial': self.INISIAL,
            'flag': self.FLAG
        }