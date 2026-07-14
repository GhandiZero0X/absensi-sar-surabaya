# app/models/logTransaksiModel.py
from app import db


class LogTransaksi(db.Model):
    """
    Model untuk tabel LOG_TRANSAKSI.
    Mencatat log setiap transaksi yang dilakukan oleh pegawai.

    Primary Key : TRAKSAKSI_ID
    Foreign Key : NIP                -> PEGAWAI (NIP)
                  TRAKSAKSI_BACKUP_ID -> LOG_TRANSAKSI_BACKUP (TRAKSAKSI_BACKUP_ID)
    """
    __tablename__ = 'LOG_TRANSAKSI'

    # Primary Key
    TRAKSAKSI_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Foreign Keys
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        nullable=False
    )
    TRAKSAKSI_BACKUP_ID = db.Column(
        db.Integer,
        db.ForeignKey('LOG_TRANSAKSI_BACKUP.TRAKSAKSI_BACKUP_ID'),
        nullable=False
    )

    # Data transaksi
    GUID_SKP_PEG = db.Column(db.String(100), nullable=True)   # Opsional, bisa null
    TRANSAKSI = db.Column(db.String(50))
    ACTIVITY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    def __repr__(self):
        return f'<LogTransaksi {self.TRAKSAKSI_ID}>'

    def to_dict(self):
        return {
            'traksaksi_id': self.TRAKSAKSI_ID,
            'nip': self.NIP,
            'traksaksi_backup_id': self.TRAKSAKSI_BACKUP_ID,
            'guid_skp_peg': self.GUID_SKP_PEG,
            'transaksi': self.TRANSAKSI,
            'activity': self.ACTIVITY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None
        }