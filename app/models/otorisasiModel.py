# app/models/otorisasiModel.py
from app import db


class Otorisasi(db.Model):
    """
    Model untuk tabel OTORISASI.
    Menyimpan data pengajuan otorisasi (approval) kegiatan.

    Primary Key : GUID_OTO
    Foreign Key : NIP -> PEGAWAI (NIP)  -- nullable, karena bisa tanpa pegawai tertentu
    """
    __tablename__ = 'OTORISASI'

    # Primary Key
    GUID_OTO = db.Column(db.String(100), primary_key=True, nullable=False)

    # Foreign Key ke PEGAWAI (nullable sesuai DDL)
    NIP = db.Column(db.String(50), db.ForeignKey('PEGAWAI.NIP'), nullable=True)

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
    TGL_PENGAJUAN = db.Column(db.DateTime)

    def __repr__(self):
        return f'<Otorisasi {self.GUID_OTO}>'

    def to_dict(self):
        return {
            'guid_oto': self.GUID_OTO,
            'nip': self.NIP,
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
            'tgl_pengajuan': self.TGL_PENGAJUAN.isoformat() if self.TGL_PENGAJUAN else None
        }