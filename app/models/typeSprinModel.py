# app/models/typeSprinModel.py
from app import db


class MfTypeSprin(db.Model):
    """Model untuk tabel MF_TYPE_SPRIN"""
    __tablename__ = 'mf_type_sprin'

    TYPE_SPRIN_ID = db.Column(db.String(20), primary_key=True)
    TYPE_SPRIN_NAME = db.Column(db.String(50))

    def __repr__(self):
        return f'<MfTypeSprin {self.TYPE_SPRIN_ID} - {self.TYPE_SPRIN_NAME}>'