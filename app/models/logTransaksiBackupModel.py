# app/models/logTransaksiBackupModel.py
from app import db


class LogTransaksiBackup(db.Model):
    """
    Model untuk tabel LOG_TRANSAKSI_BACKUP.
    Menyimpan salinan historis (backup) dari data LOG_TRANSAKSI.

    Primary Key : TRAKSAKSI_BACKUP_ID
    Foreign Key : TRAKSAKSI_ID -> LOG_TRANSAKSI (TRAKSAKSI_ID)
    """
    __tablename__ = 'LOG_TRANSAKSI_BACKUP'

    # Primary Key
    TRAKSAKSI_BACKUP_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Foreign Key ke LOG_TRANSAKSI (nullable sesuai DDL)
    TRAKSAKSI_ID = db.Column(
        db.Integer,
        db.ForeignKey('LOG_TRANSAKSI.TRAKSAKSI_ID'),
        nullable=True
    )

    # Data transaksi
    GUID_SKP_PEG = db.Column(db.String(100))
    TRANSAKSI = db.Column(db.String(50))
    ACTIVITY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    def __repr__(self):
        return f'<LogTransaksiBackup {self.TRAKSAKSI_BACKUP_ID}>'

    def to_dict(self):
        return {
            'traksaksi_backup_id': self.TRAKSAKSI_BACKUP_ID,
            'traksaksi_id': self.TRAKSAKSI_ID,
            'guid_skp_peg': self.GUID_SKP_PEG,
            'transaksi': self.TRANSAKSI,
            'activity': self.ACTIVITY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None
        }