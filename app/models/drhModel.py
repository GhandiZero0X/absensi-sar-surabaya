# app/models/drhModel.py
from app import db


class DRH(db.Model):
    """
    Model untuk tabel DRH (Daftar Riwayat Hidup/Hierarchy Jabatan).
    Merekam perubahan jabatan seorang pegawai beserta dasar transaksinya.

    Composite Primary Key : NIP + JABATAN_ID + TRAKSAKSI_ID
    Foreign Key           : NIP         -> PEGAWAI (NIP)
                            JABATAN_ID  -> MF_JABATAN (JABATAN_ID)
                            TRAKSAKSI_ID-> LOG_TRANSAKSI (TRAKSAKSI_ID)
    """
    __tablename__ = 'DRH'

    # Composite Primary Key
    NIP = db.Column(db.String(50), primary_key=True, nullable=False)
    JABATAN_ID = db.Column(db.Integer, primary_key=True, nullable=False)
    TRAKSAKSI_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Data tambahan riwayat jabatan
    GUID_TRANSAKSI = db.Column(db.String(50))
    TGL_MULAI = db.Column(db.Date)
    NO_SK = db.Column(db.String(150))

    def __repr__(self):
        return f'<DRH {self.NIP} - Jabatan:{self.JABATAN_ID} Trx:{self.TRAKSAKSI_ID}>'

    def to_dict(self):
        return {
            'nip': self.NIP,
            'jabatan_id': self.JABATAN_ID,
            'traksaksi_id': self.TRAKSAKSI_ID,
            'guid_transaksi': self.GUID_TRANSAKSI,
            'tgl_mulai': self.TGL_MULAI.isoformat() if self.TGL_MULAI else None,
            'no_sk': self.NO_SK
        }