# app/models/mfStatusModel.py
from app import db


class MfStatus(db.Model):
    """
    Model untuk tabel MF_STATUS.
    Menyimpan master status transaksi (digunakan untuk log aktivitas, otorisasi, dsb).

    Primary Key : STATUS_ID
    """
    __tablename__ = 'MF_STATUS'

    STATUS_ID = db.Column(db.Integer, primary_key=True, nullable=False)
    STATUS = db.Column(db.String(50))               # Label status (misal: "Disetujui", "Ditolak")
    BG_STATUS = db.Column(db.String(50))            # Warna background (CSS class)
    ALERT_STATUS = db.Column(db.String(50))         # Tingkat alert (info, warning, danger)
    SPAN_STATUS_LOG_JOB = db.Column(db.String(50))  # Span status log job
    STATUS_LOG_JOB = db.Column(db.String(50))       # Status log job

    def __repr__(self):
        return f'<MfStatus {self.STATUS_ID} - {self.STATUS}>'

    def to_dict(self):
        return {
            'status_id': self.STATUS_ID,
            'status': self.STATUS,
            'bg_status': self.BG_STATUS,
            'alert_status': self.ALERT_STATUS,
            'span_status_log_job': self.SPAN_STATUS_LOG_JOB,
            'status_log_job': self.STATUS_LOG_JOB
        }