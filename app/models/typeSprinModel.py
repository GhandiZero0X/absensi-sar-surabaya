# app/models/typeSprinModel.py
from app import db


class MfTypeSprin(db.Model):
    """
    Model untuk tabel MF_TYPE_SPRIN.
    Menyimpan master jenis Surat Perintah (SPRIN).

    Primary Key : TYPE_SPRIN_ID (CHAR 20)
    """
    __tablename__ = 'MF_TYPE_SPRIN'

    # Primary Key
    TYPE_SPRIN_ID = db.Column(db.String(20), primary_key=True, nullable=False)

    # Nama tipe SPRIN
    TYPE_SPRIN_NAME = db.Column(db.String(50), nullable=True)

    def __repr__(self):
        return f'<MfTypeSprin {self.TYPE_SPRIN_ID}>'

    def to_dict(self):
        return {
            'type_sprin_id': self.TYPE_SPRIN_ID,
            'type_sprin_name': self.TYPE_SPRIN_NAME
        }