# app/models/unitKerjaModel.py
from app import db


class MfUnitKerja(db.Model):
    """
    Model untuk tabel MF_UNIT_KERJA.
    Tabel master/referensi unit kerja, dipakai oleh banyak tabel lain
    seperti PEGAWAI, LOG_ACTIVITIY, MF_HOST_NAME_FP, dan OTORISASI_HISTORY.

    Primary Key : UNIT_KERJA_ID
    Foreign Key : (tidak ada FK keluar pada tabel ini)
    """
    __tablename__ = 'MF_UNIT_KERJA'

    # Primary Key
    UNIT_KERJA_ID = db.Column(db.Integer, primary_key=True)

    # Data unit kerja
    NAMA_UNIT_KERJA = db.Column(db.String(50), nullable=True)
    URUT_REPORT = db.Column(db.Integer, nullable=True)
    IS_PUSAT = db.Column(db.Integer, nullable=True)
    TRANSAC_ID = db.Column(db.Integer, nullable=True)

    # Metadata audit
    UPDATE_IN_BY = db.Column(db.String(50), nullable=True)
    UPDATE_DATE = db.Column(db.DateTime, nullable=True)

    # Representasi objek (memudahkan debugging di console/log)
    def __repr__(self):
        return f'<UnitKerja {self.UNIT_KERJA_ID} - {self.NAMA_UNIT_KERJA}>'

    # Helper: ubah objek jadi dict (berguna untuk response JSON/API)
    def to_dict(self):
        return {
            'unit_kerja_id': self.UNIT_KERJA_ID,
            'nama_unit_kerja': self.NAMA_UNIT_KERJA,
            'urut_report': self.URUT_REPORT,
            'is_pusat': self.IS_PUSAT,
        }