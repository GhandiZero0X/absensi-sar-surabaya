# app/models/hariLiburModel.py
from app import db


class MfKalender(db.Model):
    """
    Model untuk tabel KALENDER.
    Merepresentasikan data kalender kerja termasuk penanda hari libur.
    Primary Key : TGL_KERJA
    Direferensikan oleh : ABSENSI.TGL_KERJA
                          LEMBUR.TGL_KERJA
    """
    __tablename__ = 'KALENDER'

    # Primary Key
    TGL_KERJA = db.Column(db.DateTime, primary_key=True)

    # Status hari libur
    IS_LIBUR = db.Column(db.String(1), nullable=True)   # 'Y' / 'N'
    KET = db.Column(db.String(50), nullable=True)        # keterangan hari libur

    # Metadata audit
    UPDATE_BY = db.Column(db.String(50), nullable=True)
    UPDATE_DATE = db.Column(db.DateTime, nullable=True)

    # Representasi objek (memudahkan debugging di console/log)
    def __repr__(self):
        return f'<Kalender {self.TGL_KERJA} - Libur: {self.IS_LIBUR}>'

    # Helper: ubah objek jadi dict (berguna untuk response JSON/API)
    def to_dict(self):
        return {
            'tgl_kerja': self.TGL_KERJA.isoformat() if self.TGL_KERJA else None,
            'is_libur': self.IS_LIBUR,
            'ket': self.KET,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
        }