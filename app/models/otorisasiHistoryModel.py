# app/models/otorisasiHistoryModel.py
from app import db


class OtorisasiHistory(db.Model):
    """
    Model untuk tabel OTORISASI_HISTORY.
    Menyimpan riwayat (log) proses otorisasi/approval.

    Primary Key : OTO_HISTORY_ID
    Foreign Key : GUID_OTO      -> OTORISASI (GUID_OTO)
                  NIP           -> PEGAWAI (NIP)
                  UNIT_KERJA_ID -> MF_UNIT_KERJA (UNIT_KERJA_ID)
    """
    __tablename__ = 'OTORISASI_HISTORY'

    # Primary Key
    OTO_HISTORY_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Foreign Keys
    GUID_OTO = db.Column(
        db.String(100),
        db.ForeignKey('OTORISASI.GUID_OTO'),
        nullable=False
    )
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        nullable=False
    )
    UNIT_KERJA_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_UNIT_KERJA.UNIT_KERJA_ID'),
        nullable=False
    )

    # Data transaksi otorisasi
    TRX = db.Column(db.String(50))
    LEVEL_OTO = db.Column(db.Integer)
    JABATAN = db.Column(db.String(100))
    ACT = db.Column(db.Integer)

    # Metadata
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    # Deskripsi pengajuan
    PERIHAL = db.Column(db.String(150))
    KETERANGAN = db.Column(db.String(150))

    # Periode anggaran / waktu
    BULAN = db.Column(db.Integer)
    TAHUN = db.Column(db.Integer)

    # Shift terkait (bisa ID shift atau nama shift)
    SHIFT_1 = db.Column(db.Integer)
    SHIFT_2 = db.Column(db.Integer)

    # Tanggal pencatatan history (REC_DATE)
    REC_DATE = db.Column(db.DateTime)
    TGL_PENGAJUAN = db.Column(db.DateTime)

    def __repr__(self):
        return f'<OtorisasiHistory {self.OTO_HISTORY_ID}>'

    def to_dict(self):
        return {
            'oto_history_id': self.OTO_HISTORY_ID,
            'guid_oto': self.GUID_OTO,
            'nip': self.NIP,
            'unit_kerja_id': self.UNIT_KERJA_ID,
            'trx': self.TRX,
            'level_oto': self.LEVEL_OTO,
            'jabatan': self.JABATAN,
            'act': self.ACT,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'perihal': self.PERIHAL,
            'keterangan': self.KETERANGAN,
            'bulan': self.BULAN,
            'tahun': self.TAHUN,
            'shift_1': self.SHIFT_1,
            'shift_2': self.SHIFT_2,
            'rec_date': self.REC_DATE.isoformat() if self.REC_DATE else None,
            'tgl_pengajuan': self.TGL_PENGAJUAN.isoformat() if self.TGL_PENGAJUAN else None
        }