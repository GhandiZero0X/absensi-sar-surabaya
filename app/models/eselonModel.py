# app/models/eselonModel.py
from app import db


class Eselon(db.Model):
    """
    Model untuk tabel MF_ESELON.
    Tabel master eselon jabatan pegawai.

    Primary Key : ESELON (string, bukan angka)
    Foreign Key : (tidak ada FK keluar pada tabel ini)
    """
    __tablename__ = 'MF_ESELON'

    # Primary Key
    ESELON = db.Column(db.String(50), primary_key=True)

    # Data eselon
    URUT_ESELON = db.Column(db.Integer, nullable=True)

    # Representasi objek (memudahkan debugging di console/log)
    def __repr__(self):
        return f'<Eselon {self.ESELON}>'

    # Helper: ubah objek jadi dict (berguna untuk response JSON/API)
    def to_dict(self):
        return {
            'eselon': self.ESELON,
            'urut_eselon': self.URUT_ESELON,
        }