# app/models/timeRecorderModel.py
from app import db


class TimeRecorder(db.Model):
    """
    Model untuk tabel TIME_RECORDER.
    Menyimpan log mentah sidik jari (raw fingerprint log) dari mesin absensi.

    Primary Key : FINGER_ID
    """
    __tablename__ = 'TIME_RECORDER'

    # Primary Key
    FINGER_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Data waktu rekaman
    WAKTU = db.Column(db.DateTime)
    STATUS = db.Column(db.String(3))           # Kode status mesin (misal: 0/1)

    # Informasi mesin
    MESIN = db.Column(db.String(100))

    # Keterangan & transaksi
    KET = db.Column(db.String(50))
    TRANSAKSI = db.Column(db.String(50))
    KET_INJECT = db.Column(db.String(150))     # Keterangan saat injeksi manual
    REF_INJECT = db.Column(db.String(150))     # Referensi data injeksi
    TRX = db.Column(db.String(50))

    # Metadata
    UPDATE_IN_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    def __repr__(self):
        return f'<TimeRecorder {self.FINGER_ID}>'

    def to_dict(self):
        return {
            'finger_id': self.FINGER_ID,
            'waktu': self.WAKTU.isoformat() if self.WAKTU else None,
            'status': self.STATUS,
            'mesin': self.MESIN,
            'ket': self.KET,
            'transaksi': self.TRANSAKSI,
            'ket_inject': self.KET_INJECT,
            'ref_inject': self.REF_INJECT,
            'trx': self.TRX,
            'update_in_by': self.UPDATE_IN_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None
        }