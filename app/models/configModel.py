# app/models/mfConfigModel.py
from app import db


class MfConfig(db.Model):
    """
    Model untuk tabel MF_CONFIG.
    Menyimpan konfigurasi per transaksi (misal pengaturan tanggal/jam khusus).

    Primary Key : TRAKSAKSI_ID (sekaligus foreign key ke LOG_TRANSAKSI)
    Foreign Key : TRAKSAKSI_ID -> LOG_TRANSAKSI (TRAKSAKSI_ID)
    """
    __tablename__ = 'MF_CONFIG'

    # Primary Key & Foreign Key
    TRAKSAKSI_ID = db.Column(
        db.Integer,
        db.ForeignKey('LOG_TRANSAKSI.TRAKSAKSI_ID'),
        primary_key=True,
        nullable=False
    )

    # Nama konfigurasi
    CONFIG_NAME = db.Column(db.String(50))

    # Nilai timestamp 1 dan 2
    TGL_JAM1 = db.Column(db.DateTime)
    TGL_JAM2 = db.Column(db.DateTime)

    def __repr__(self):
        return f'<MfConfig {self.TRAKSAKSI_ID} - {self.CONFIG_NAME}>'

    def to_dict(self):
        return {
            'traksaksi_id': self.TRAKSAKSI_ID,
            'config_name': self.CONFIG_NAME,
            'tgl_jam1': self.TGL_JAM1.isoformat() if self.TGL_JAM1 else None,
            'tgl_jam2': self.TGL_JAM2.isoformat() if self.TGL_JAM2 else None
        }