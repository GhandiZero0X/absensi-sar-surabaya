# app/models/logActivityModel.py
from app import db


class LogActivity(db.Model):
    """
    Model untuk tabel LOG_ACTIVITIY.
    Mencatat aktivitas harian/tugas personel (kegiatan, lokasi, hasil).

    Primary Key : GUID_LOG
    Foreign Keys:
      - TRAKSAKSI_ID   -> LOG_TRANSAKSI
      - UNIT_KERJA_ID  -> MF_UNIT_KERJA
      - GUID_LOG_BACKUP-> LOG_ACTIVITIY_BACKUP
      - GUID_TIM       -> MF_TIM_SIAGA
      - STATUS_ID      -> MF_STATUS
      - NIP            -> PEGAWAI
    """
    __tablename__ = 'LOG_ACTIVITIY'

    # Primary Key
    GUID_LOG = db.Column(db.String(50), primary_key=True, nullable=False)

    # Foreign Keys (semuanya NOT NULL di DDL)
    TRAKSAKSI_ID = db.Column(
        db.Integer,
        db.ForeignKey('LOG_TRANSAKSI.TRAKSAKSI_ID'),
        nullable=False
    )
    UNIT_KERJA_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_UNIT_KERJA.UNIT_KERJA_ID'),
        nullable=False
    )
    GUID_LOG_BACKUP = db.Column(
        db.String(50),
        db.ForeignKey('LOG_ACTIVITIY_BACKUP.GUID_LOG_BACKUP'),
        nullable=False
    )
    GUID_TIM = db.Column(
        db.String(50),
        db.ForeignKey('MF_TIM_SIAGA.GUID_TIM'),
        nullable=False
    )
    STATUS_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_STATUS.STATUS_ID'),
        nullable=False
    )
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        nullable=False
    )

    # Isi log aktivitas
    TRX = db.Column(db.String(50))
    ACTIVITY = db.Column(db.String(50))
    ACTIVITY_DATE = db.Column(db.Date)
    NOTE = db.Column(db.String(150))
    TEMPAT = db.Column(db.String(150))
    PERIHAL = db.Column(db.String(150))

    # Metadata
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    # Fungsi / peran saat aktivitas
    FUNGSIONAL = db.Column(db.String(50))

    # Closing / penyelesaian
    TGL_CLOSING = db.Column(db.Date)

    # Shift terkait
    SHIFT_1 = db.Column(db.Integer)
    SHIFT_2 = db.Column(db.Integer)
    PENGGANTI = db.Column(db.Integer)        # ID pengganti jika ada

    # Status transaksi & keterangan perubahan
    STATUS_TRX = db.Column(db.String(50))
    KET_UPDATE = db.Column(db.String(250))
    NIP_PENGGANTI = db.Column(db.String(50))

    # Biaya & kuantitas
    BIAYA = db.Column(db.Float)
    QTY = db.Column(db.Float)
    SATUAN_QTY = db.Column(db.String(50))

    # Shift kerja (string pendek, misal "PAGI")
    SHIFT = db.Column(db.String(5))
    TRANSAKSI_FORM = db.Column(db.String(50))

    # Waktu kerja aktual dan baku
    TGL_JAM_IN = db.Column(db.DateTime)
    TGL_JAM_OUT = db.Column(db.DateTime)
    TGL_JAM_BAKU_IN = db.Column(db.DateTime)
    TGL_JAM_BAKU_OUT = db.Column(db.DateTime)

    def __repr__(self):
        return f'<LogActivity {self.GUID_LOG}>'

    def to_dict(self):
        return {
            'guid_log': self.GUID_LOG,
            'traksaksi_id': self.TRAKSAKSI_ID,
            'unit_kerja_id': self.UNIT_KERJA_ID,
            'guid_log_backup': self.GUID_LOG_BACKUP,
            'guid_tim': self.GUID_TIM,
            'status_id': self.STATUS_ID,
            'nip': self.NIP,
            'trx': self.TRX,
            'activity': self.ACTIVITY,
            'activity_date': self.ACTIVITY_DATE.isoformat() if self.ACTIVITY_DATE else None,
            'note': self.NOTE,
            'tempat': self.TEMPAT,
            'perihal': self.PERIHAL,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'fungsional': self.FUNGSIONAL,
            'tgl_closing': self.TGL_CLOSING.isoformat() if self.TGL_CLOSING else None,
            'shift_1': self.SHIFT_1,
            'shift_2': self.SHIFT_2,
            'pengganti': self.PENGGANTI,
            'status_trx': self.STATUS_TRX,
            'ket_update': self.KET_UPDATE,
            'nip_pengganti': self.NIP_PENGGANTI,
            'biaya': self.BIAYA,
            'qty': self.QTY,
            'satuan_qty': self.SATUAN_QTY,
            'shift': self.SHIFT,
            'transaksi_form': self.TRANSAKSI_FORM,
            'tgl_jam_in': self.TGL_JAM_IN.isoformat() if self.TGL_JAM_IN else None,
            'tgl_jam_out': self.TGL_JAM_OUT.isoformat() if self.TGL_JAM_OUT else None,
            'tgl_jam_baku_in': self.TGL_JAM_BAKU_IN.isoformat() if self.TGL_JAM_BAKU_IN else None,
            'tgl_jam_baku_out': self.TGL_JAM_BAKU_OUT.isoformat() if self.TGL_JAM_BAKU_OUT else None
        }