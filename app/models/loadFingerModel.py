# app/models/loadFingerModel.py
from app import db


class MfLoadFinger(db.Model):
    """
    Model untuk tabel MF_LOAD_FINGER.
    Menyimpan pengaturan jadwal load data finger dari mesin absensi.

    Primary Key : TRAKSAKSI_ID (sekaligus foreign key ke LOG_TRANSAKSI)
    Foreign Key : TRAKSAKSI_ID -> LOG_TRANSAKSI (TRAKSAKSI_ID)
    """
    __tablename__ = 'MF_LOAD_FINGER'

    # Primary Key & Foreign Key
    TRAKSAKSI_ID = db.Column(
        db.Integer,
        db.ForeignKey('LOG_TRANSAKSI.TRAKSAKSI_ID'),
        primary_key=True,
        nullable=False
    )

    # Rentang waktu load finger (scan masuk)
    START_FINGER = db.Column(db.DateTime)
    END_FINGER = db.Column(db.DateTime)

    # Tanggal mulai berlaku pengaturan
    TGL_MULAI_BERLAKU = db.Column(db.Date)

    # Metadata audit
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    # Kode shift kerja (misal: "1", "2", "3")
    SHIFT_KERJA = db.Column(db.String(2))

    # Rentang waktu load finger (scan pulang)
    START_FINGER_OUT = db.Column(db.DateTime)
    END_FINGER_OUT = db.Column(db.DateTime)

    def __repr__(self):
        return f'<MfLoadFinger {self.TRAKSAKSI_ID}>'

    def to_dict(self):
        return {
            'traksaksi_id': self.TRAKSAKSI_ID,
            'start_finger': self.START_FINGER.isoformat() if self.START_FINGER else None,
            'end_finger': self.END_FINGER.isoformat() if self.END_FINGER else None,
            'tgl_mulai_berlaku': self.TGL_MULAI_BERLAKU.isoformat() if self.TGL_MULAI_BERLAKU else None,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'shift_kerja': self.SHIFT_KERJA,
            'start_finger_out': self.START_FINGER_OUT.isoformat() if self.START_FINGER_OUT else None,
            'end_finger_out': self.END_FINGER_OUT.isoformat() if self.END_FINGER_OUT else None
        }