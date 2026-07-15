# app/models/hakAksesFormModel.py
from app import db


class HakAksesForm(db.Model):
    """
    Model untuk tabel HAK_AKSES_FORM.
    Menentukan hak akses user terhadap form/menu tertentu.

    Composite Primary Key : FORM_ID + NIP
    Foreign Key           : FORM_ID -> MF_FORM (FORM_ID)
                            NIP     -> PEGAWAI (NIP)
    """
    __tablename__ = 'HAK_AKSES_FORM'

    # Primary Keys (sekaligus foreign keys)
    FORM_ID = db.Column(
        db.String(50),
        db.ForeignKey('MF_FORM.FORM_ID'),
        primary_key=True,
        nullable=False
    )
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        primary_key=True,
        nullable=False
    )

    # Hak akses
    IS_AKSES = db.Column(db.String(5))    # Y/N
    TYPE_AKSES = db.Column(db.String(5))  # Jenis akses (misal: R, W, X)
    MODUL = db.Column(db.String(50))

    # Metadata
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    def __repr__(self):
        return f'<HakAksesForm Form:{self.FORM_ID} NIP:{self.NIP}>'

    def to_dict(self):
        return {
            'form_id': self.FORM_ID,
            'nip': self.NIP,
            'is_akses': self.IS_AKSES,
            'type_akses': self.TYPE_AKSES,
            'modul': self.MODUL,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None
        }