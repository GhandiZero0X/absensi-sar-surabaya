# app/models/skpPegawaiModel.py
from app import db


class SkpPegawai(db.Model):
    """
    Model untuk tabel SKP_PEGAWAI.
    Menyimpan Sasaran Kerja Pegawai (SKP) per individu.
    Tiap baris mewakili satu butir kegiatan SKP.

    Primary Key : GUID_SKP_PEG
    Foreign Key : NIP        -> PEGAWAI (NIP)
                  JABATAN_ID -> MF_JABATAN (JABATAN_ID)
    """
    __tablename__ = 'SKP_PEGAWAI'

    # Primary Key
    GUID_SKP_PEG = db.Column(db.String(100), primary_key=True, nullable=False)

    # Foreign Keys
    NIP = db.Column(db.String(50), db.ForeignKey('PEGAWAI.NIP'), nullable=False)
    JABATAN_ID = db.Column(db.Integer, db.ForeignKey('MF_JABATAN.JABATAN_ID'), nullable=False)

    # Rincian kegiatan SKP
    DESKRIPSI = db.Column(db.String(500))
    AK = db.Column(db.Float)           # Angka Kredit
    QTY = db.Column(db.Float)          # Target kuantitas
    MUTU = db.Column(db.Float)         # Target mutu/kualitas
    WAKTU = db.Column(db.DateTime)     # Target waktu (sebagai timestamp)
    BIAYA = db.Column(db.Float)        # Anggaran/biaya

    # Metadata tambahan
    UNSUR = db.Column(db.String(50))   # Unsur kegiatan
    TYPE = db.Column(db.Integer)       # Tipe kegiatan (utama/tambahan)
    TGL_MULAI = db.Column(db.DateTime) # Tanggal mulai berlaku SKP

    # Satuan target
    SATUAN_QTY = db.Column(db.String(50))
    SATUAN_MUTU = db.Column(db.String(50))
    SATUAN_WAKTU = db.Column(db.String(50))

    def __repr__(self):
        return f'<SkpPegawai {self.GUID_SKP_PEG}>'

    def to_dict(self):
        return {
            'guid_skp_peg': self.GUID_SKP_PEG,
            'nip': self.NIP,
            'jabatan_id': self.JABATAN_ID,
            'deskripsi': self.DESKRIPSI,
            'ak': self.AK,
            'qty': self.QTY,
            'mutu': self.MUTU,
            'waktu': self.WAKTU.isoformat() if self.WAKTU else None,
            'biaya': self.BIAYA,
            'unsur': self.UNSUR,
            'type': self.TYPE,
            'tgl_mulai': self.TGL_MULAI.isoformat() if self.TGL_MULAI else None,
            'satuan_qty': self.SATUAN_QTY,
            'satuan_mutu': self.SATUAN_MUTU,
            'satuan_waktu': self.SATUAN_WAKTU
        }