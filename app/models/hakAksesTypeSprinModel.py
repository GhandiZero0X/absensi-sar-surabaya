# app/models/hakAksesTypeSprinModel.py
from app import db


class HakAksesTypeSprin(db.Model):
    """
    Model untuk tabel HAK_AKSES_TYPE_SPRIN.
    Menentukan hak akses pegawai terhadap jenis SPRIN tertentu.

    Composite Primary Key : TYPE_SPRIN_ID + NIP
    Foreign Key           : TYPE_SPRIN_ID -> MF_TYPE_SPRIN (TYPE_SPRIN_ID)
                            NIP           -> PEGAWAI (NIP)
    """
    __tablename__ = 'HAK_AKSES_TYPE_SPRIN'

    # Primary Keys (sekaligus foreign keys)
    TYPE_SPRIN_ID = db.Column(
        db.String(20),
        db.ForeignKey('MF_TYPE_SPRIN.TYPE_SPRIN_ID'),
        primary_key=True,
        nullable=False
    )
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        primary_key=True,
        nullable=False
    )

    # Jenis akses (misal: read, write, admin)
    TYPE_AKSES = db.Column(db.String(10))   # CHAR(10)

    # Metadata
    UPDATE_BY = db.Column(db.String(10))
    UPDATE_DATE = db.Column(db.String(10))   # DDL asli pakai CHAR(10), bukan datetime

    def __repr__(self):
        return f'<HakAksesTypeSprin {self.TYPE_SPRIN_ID} - {self.NIP}>'

    def to_dict(self):
        return {
            'type_sprin_id': self.TYPE_SPRIN_ID,
            'nip': self.NIP,
            'type_akses': self.TYPE_AKSES,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE
        }