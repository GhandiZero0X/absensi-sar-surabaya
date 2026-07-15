# app/models/pegMutasiUnitModel.py
from app import db


class PegMutasiUnit(db.Model):
    """
    Model untuk tabel PEG_MUTASI_UNIT.
    Mencatat mutasi/pemindahan unit kerja seorang pegawai.

    Composite Primary Key : TRAKSAKSI_ID + NIP
    Foreign Key           : TRAKSAKSI_ID -> LOG_TRANSAKSI (TRAKSAKSI_ID)
                            NIP          -> PEGAWAI (NIP)
    """
    __tablename__ = 'PEG_MUTASI_UNIT'

    # Composite Primary Key
    TRAKSAKSI_ID = db.Column(db.Integer, primary_key=True, nullable=False)
    NIP = db.Column(db.String(50), primary_key=True, nullable=False)

    # Data mutasi
    TGL_MUTASI = db.Column(db.Date)
    UNIT_KERJA = db.Column(db.String(50))       # Nama/ID unit kerja (teks)

    # Metadata
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)
    NO_SK = db.Column(db.String(50))            # Nomor surat keputusan mutasi
    KETERANGAN = db.Column(db.String(250))

    def __repr__(self):
        return f'<PegMutasiUnit {self.NIP} Trx:{self.TRAKSAKSI_ID}>'

    def to_dict(self):
        return {
            'traksaksi_id': self.TRAKSAKSI_ID,
            'nip': self.NIP,
            'tgl_mutasi': self.TGL_MUTASI.isoformat() if self.TGL_MUTASI else None,
            'unit_kerja': self.UNIT_KERJA,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'no_sk': self.NO_SK,
            'keterangan': self.KETERANGAN
        }