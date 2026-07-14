# app/models/klasifikasiSuratModel.py
from app import db


class MfKlasifikasiSurat(db.Model):
    """
    Model untuk tabel MF_KLASIFIKASI_SURAT.
    Mengelompokkan jenis SPRIN ke dalam klasifikasi surat tertentu.

    Primary Key : KLASIFIKASI_ID
    Foreign Key : TYPE_SPRIN_ID -> MF_TYPE_SPRIN (TYPE_SPRIN_ID)
    """
    __tablename__ = 'MF_KLASIFIKASI_SURAT'

    # Primary Key
    KLASIFIKASI_ID = db.Column(db.String(5), primary_key=True, nullable=False)

    # Foreign Key ke MF_TYPE_SPRIN
    TYPE_SPRIN_ID = db.Column(
        db.String(20),
        db.ForeignKey('MF_TYPE_SPRIN.TYPE_SPRIN_ID'),
        nullable=False
    )

    # Nama klasifikasi surat
    KLASIFIKASI_NAME = db.Column(db.String(50))

    def __repr__(self):
        return f'<MfKlasifikasiSurat {self.KLASIFIKASI_ID}>'

    def to_dict(self):
        return {
            'klasifikasi_id': self.KLASIFIKASI_ID,
            'type_sprin_id': self.TYPE_SPRIN_ID,
            'klasifikasi_name': self.KLASIFIKASI_NAME
        }