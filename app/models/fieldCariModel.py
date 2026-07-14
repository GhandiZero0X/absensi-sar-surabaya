# app/models/fieldCariModel.py
from app import db


class MfFieldCari(db.Model):
    """
    Model untuk tabel MF_FIELD_CARI.
    Menyimpan definisi field pencarian untuk setiap modul transaksi.

    Primary Key : FIELD_ID
    Foreign Key : TRAKSAKSI_ID -> LOG_TRANSAKSI (TRAKSAKSI_ID)
    """
    __tablename__ = 'MF_FIELD_CARI'

    FIELD_ID = db.Column(db.String(50), primary_key=True, nullable=False)

    TRAKSAKSI_ID = db.Column(
        db.Integer,
        db.ForeignKey('LOG_TRANSAKSI.TRAKSAKSI_ID'),
        nullable=False
    )

    FIELD_NAME = db.Column(db.String(50))
    TYPE_CARI = db.Column(db.String(50))
    IS_CMB = db.Column(db.String(5))          # Apakah berbentuk combo box (Y/N)
    NO_URUT = db.Column(db.Integer)
    APLIKASI = db.Column(db.String(50))

    def __repr__(self):
        return f'<MfFieldCari {self.FIELD_ID}>'

    def to_dict(self):
        return {
            'field_id': self.FIELD_ID,
            'traksaksi_id': self.TRAKSAKSI_ID,
            'field_name': self.FIELD_NAME,
            'type_cari': self.TYPE_CARI,
            'is_cmb': self.IS_CMB,
            'no_urut': self.NO_URUT,
            'aplikasi': self.APLIKASI
        }