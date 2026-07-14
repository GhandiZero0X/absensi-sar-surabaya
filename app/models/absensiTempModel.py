# app/models/absensiTempModel.py
from app import db


class AbsensiTemp(db.Model):
    """
    Model untuk tabel ABSENSI_TEMP.
    Menyimpan data absensi sementara (temporary) sebelum finalisasi.

    Primary Key : ABSENSI_TEMP_ID
    Foreign Key : ABSENSI_ID -> ABSENSI (ABSENSI_ID)
    """
    __tablename__ = 'ABSENSI_TEMP'

    # Primary Key
    ABSENSI_TEMP_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Foreign Key ke tabel ABSENSI
    ABSENSI_ID = db.Column(db.Integer, db.ForeignKey('ABSENSI.ABSENSI_ID'), nullable=True)

    # Data absen masuk (in)
    TGL_JAM_IN = db.Column(db.DateTime)
    KET_IN = db.Column(db.String(850))
    TRANSAKSI_IN = db.Column(db.String(50))      # CHAR(50)
    UPDATE_IN_BY = db.Column(db.String(50))
    UPDATE_IN_DATE = db.Column(db.DateTime)
    PENDUKUNG_IN = db.Column(db.String(50))
    HISTORY_TRANSAKSI_IN = db.Column(db.String(450))

    # Data absen pulang (out)
    TGL_JAM_OUT = db.Column(db.DateTime)
    KET_OUT = db.Column(db.String(850))
    TRANSAKSI_OUT = db.Column(db.String(50))
    UPDATE_OUT_BY = db.Column(db.String(50))
    UPDATE_OUT_DATE = db.Column(db.DateTime)
    PENDUKUNG_OUT = db.Column(db.String(50))
    HISTORY_TRANSAKSI_OUT = db.Column(db.String(450))

    # Data potongan keterlambatan / pulang cepat
    TINGKAT_TLM = db.Column(db.String(50))
    TOTAL_TLM = db.Column(db.Float)
    TINGKAT_PSW = db.Column(db.String(50))
    TOTAL_PSW = db.Column(db.Float)
    AWAL_TLM = db.Column(db.Float)
    PERSEN_POT_TLM = db.Column(db.Float)
    PERSEN_POT_PSW = db.Column(db.Float)

    # Data validasi dan baku
    IS_INVALID = db.Column(db.String(1))
    IS_OUTVALID = db.Column(db.String(1))
    TGL_JAM_BAKU_IN = db.Column(db.DateTime)
    TGL_JAM_BAKU_OUT = db.Column(db.DateTime)

    # Lain-lain
    TRAKSAKSI_ID_FROM = db.Column(db.String(250))
    STATUS_UM = db.Column(db.Integer)

    def __repr__(self):
        return f'<AbsensiTemp {self.ABSENSI_TEMP_ID}>'

    def to_dict(self):
        return {
            'absensi_temp_id': self.ABSENSI_TEMP_ID,
            'absensi_id': self.ABSENSI_ID,
            'tgl_jam_in': self.TGL_JAM_IN.isoformat() if self.TGL_JAM_IN else None,
            'ket_in': self.KET_IN,
            'transaksi_in': self.TRANSAKSI_IN,
            'update_in_by': self.UPDATE_IN_BY,
            'update_in_date': self.UPDATE_IN_DATE.isoformat() if self.UPDATE_IN_DATE else None,
            'pendukung_in': self.PENDUKUNG_IN,
            'history_transaksi_in': self.HISTORY_TRANSAKSI_IN,
            'tgl_jam_out': self.TGL_JAM_OUT.isoformat() if self.TGL_JAM_OUT else None,
            'ket_out': self.KET_OUT,
            'transaksi_out': self.TRANSAKSI_OUT,
            'update_out_by': self.UPDATE_OUT_BY,
            'update_out_date': self.UPDATE_OUT_DATE.isoformat() if self.UPDATE_OUT_DATE else None,
            'pendukung_out': self.PENDUKUNG_OUT,
            'history_transaksi_out': self.HISTORY_TRANSAKSI_OUT,
            'tingkat_tlm': self.TINGKAT_TLM,
            'total_tlm': self.TOTAL_TLM,
            'tingkat_psw': self.TINGKAT_PSW,
            'total_psw': self.TOTAL_PSW,
            'awal_tlm': self.AWAL_TLM,
            'persen_pot_tlm': self.PERSEN_POT_TLM,
            'persen_pot_psw': self.PERSEN_POT_PSW,
            'is_invalid': self.IS_INVALID,
            'is_outvalid': self.IS_OUTVALID,
            'tgl_jam_baku_in': self.TGL_JAM_BAKU_IN.isoformat() if self.TGL_JAM_BAKU_IN else None,
            'tgl_jam_baku_out': self.TGL_JAM_BAKU_OUT.isoformat() if self.TGL_JAM_BAKU_OUT else None,
            'traksaksi_id_from': self.TRAKSAKSI_ID_FROM,
            'status_um': self.STATUS_UM
        }