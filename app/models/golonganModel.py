# app/models/golonganModel.py
from app import db


class MfGolongan(db.Model):
    """
    Model untuk tabel MF_GOL.
    Tabel master golongan/pangkat pegawai.

    Primary Key : GOL_ID
    Foreign Key : (tidak ada FK keluar pada tabel ini)
    """
    __tablename__ = 'MF_GOL'

    # Primary Key
    GOL_ID = db.Column(db.Integer, primary_key=True)

    # Data golongan
    NAMA_GOL = db.Column(db.String(50), nullable=True)
    PANGKAT_GOL = db.Column(db.String(50), nullable=True)
    URUT_GOL = db.Column(db.Integer, nullable=True)
    TRANSAC_ID = db.Column(db.Integer, nullable=True)
    GROUP_GOL = db.Column(db.String(2), nullable=True)

    # Representasi objek (memudahkan debugging di console/log)
    def __repr__(self):
        return f'<Golongan {self.GOL_ID} - {self.NAMA_GOL}>'

    # Helper: ubah objek jadi dict (berguna untuk response JSON/API)
    def to_dict(self):
        return {
            'gol_id': self.GOL_ID,
            'nama_gol': self.NAMA_GOL,
            'pangkat_gol': self.PANGKAT_GOL,
            'urut_gol': self.URUT_GOL,
            'group_gol': self.GROUP_GOL,
        }