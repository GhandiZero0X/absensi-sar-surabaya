# app/models/jabatanKegiatanModel.py
from app import db


class MfJabatanKegiatan(db.Model):
    """
    Model untuk tabel MF_JABATAN_KEGIATAN.
    Mendefinisikan item-item kegiatan yang melekat pada suatu jabatan.
    Digunakan sebagai acuan Sasaran Kerja Pegawai (SKP).

    Primary Key : ITEM_ID
    Foreign Key : JABATAN_ID -> MF_JABATAN (JABATAN_ID)
    """
    __tablename__ = 'MF_JABATAN_KEGIATAN'

    # Primary Key
    ITEM_ID = db.Column(db.String(50), primary_key=True, nullable=False)

    # Foreign Key ke jabatan induk
    JABATAN_ID = db.Column(db.Integer, db.ForeignKey('MF_JABATAN.JABATAN_ID'), nullable=False)

    # Rincian kegiatan
    DESKRIPSI = db.Column(db.String(500))
    AK = db.Column(db.Float)                         # Angka Kredit
    QTY = db.Column(db.Float)                        # Target kuantitas
    MUTU = db.Column(db.Float)                       # Target mutu/kualitas
    WAKTU = db.Column(db.DateTime)                   # Target waktu penyelesaian
    BIAYA = db.Column(db.Float)                      # Anggaran/biaya

    # Metadata tambahan
    TYPE = db.Column(db.Integer)                     # Tipe kegiatan (misal: utama/tambahan)
    UNSUR = db.Column(db.String(50))                 # Unsur kegiatan
    SATUAN_QTY = db.Column(db.String(50))
    SATUAN_MUTU = db.Column(db.String(50))
    SATUAN_WAKTU = db.Column(db.String(50))

    def __repr__(self):
        return f'<MfJabatanKegiatan {self.ITEM_ID} - Jabatan:{self.JABATAN_ID}>'

    def to_dict(self):
        return {
            'item_id': self.ITEM_ID,
            'jabatan_id': self.JABATAN_ID,
            'deskripsi': self.DESKRIPSI,
            'ak': self.AK,
            'qty': self.QTY,
            'mutu': self.MUTU,
            'waktu': self.WAKTU.isoformat() if self.WAKTU else None,
            'biaya': self.BIAYA,
            'type': self.TYPE,
            'unsur': self.UNSUR,
            'satuan_qty': self.SATUAN_QTY,
            'satuan_mutu': self.SATUAN_MUTU,
            'satuan_waktu': self.SATUAN_WAKTU
        }