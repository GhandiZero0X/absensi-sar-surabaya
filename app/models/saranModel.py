# app/models/saranModel.py
from app import db


class Saran(db.Model):
    """
    Model untuk tabel SARAN.
    Menyimpan saran/masukan dari pengguna.

    Primary Key : ID_SARAN
    Foreign Key : NIP -> PEGAWAI (NIP)
    """
    __tablename__ = 'SARAN'

    # Primary Key
    ID_SARAN = db.Column(db.Integer, primary_key=True, nullable=False)

    # Foreign Key ke PEGAWAI
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        nullable=False
    )

    # Isi saran & asal instansi
    SARAN = db.Column(db.String(350), nullable=False)
    INSTANSI = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return f'<Saran {self.ID_SARAN} by {self.NIP}>'

    def to_dict(self):
        return {
            'id_saran': self.ID_SARAN,
            'nip': self.NIP,
            'saran': self.SARAN,
            'instansi': self.INSTANSI
        }