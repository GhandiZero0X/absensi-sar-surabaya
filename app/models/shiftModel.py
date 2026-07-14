# app/models/shiftModel.py
from app import db


class MfShift(db.Model):
    """
    Model untuk tabel MF_SHIFT.
    Merepresentasikan data master shift kerja.
    Primary Key : SHIFT_ID
    Foreign Key : TRAKSAKSI_ID -> LOG_TRANSAKSI.TRAKSAKSI_ID
    """
    __tablename__ = 'MF_SHIFT'

    # Primary Key
    SHIFT_ID = db.Column(db.String(10), primary_key=True)

    # Foreign Key (NOT NULL sesuai DDL asli)
    TRAKSAKSI_ID = db.Column(
        db.Integer,
        db.ForeignKey('LOG_TRANSAKSI.TRAKSAKSI_ID'),
        nullable=False
    )

    # Data shift
    NAMA_SHIFT = db.Column(db.String(50), nullable=True)
    JADWAL = db.Column(db.String(50), nullable=True)
    START_SHIFT = db.Column(db.DateTime, nullable=True)
    END_SHIFT = db.Column(db.DateTime, nullable=True)
    TGL_MULAI_BERLAKU = db.Column(db.Date, nullable=True)

    # Relationship (opsional, memudahkan akses objek terkait)
    log_transaksi = db.relationship('LogTransaksi', backref='shift_list', lazy=True)

    # Representasi objek (memudahkan debugging di console/log)
    def __repr__(self):
        return f'<MfShift {self.SHIFT_ID} - {self.NAMA_SHIFT}>'

    # Helper: ubah objek jadi dict (berguna untuk response JSON/API)
    def to_dict(self):
        return {
            'shift_id': self.SHIFT_ID,
            'traksaksi_id': self.TRAKSAKSI_ID,
            'nama_shift': self.NAMA_SHIFT,
            'jadwal': self.JADWAL,
            'start_shift': self.START_SHIFT.isoformat() if self.START_SHIFT else None,
            'end_shift': self.END_SHIFT.isoformat() if self.END_SHIFT else None,
            'tgl_mulai_berlaku': self.TGL_MULAI_BERLAKU.isoformat() if self.TGL_MULAI_BERLAKU else None,
        }