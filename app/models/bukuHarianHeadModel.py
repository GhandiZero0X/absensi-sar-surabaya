# app/models/bukuHarianHeadModel.py
from app import db


class BukuHarianHead(db.Model):
    """
    Model untuk tabel BUKU_HARIAN_HEAD.
    Menyimpan header laporan harian kegiatan pegawai (laporan kinerja).

    Primary Key : GUID
    Foreign Key : NIP                -> PEGAWAI (NIP)
                  JABATAN_ID         -> MF_JABATAN (JABATAN_ID)
                  ITEM_ID            -> MF_JABATAN_KEGIATAN (ITEM_ID)
                  GUID_SKP_PEG       -> SKP_PEGAWAI (GUID_SKP_PEG)
    """
    __tablename__ = 'BUKU_HARIAN_HEAD'

    # Primary Key
    GUID = db.Column(db.String(100), primary_key=True, nullable=False)

    # Foreign Keys
    JABATAN_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_JABATAN.JABATAN_ID'),
        nullable=False
    )
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        nullable=False
    )
    ITEM_ID = db.Column(
        db.String(50),
        db.ForeignKey('MF_JABATAN_KEGIATAN.ITEM_ID'),
        nullable=False
    )
    GUID_SKP_PEG = db.Column(
        db.String(100),
        db.ForeignKey('SKP_PEGAWAI.GUID_SKP_PEG'),
        nullable=False
    )

    # Rincian kegiatan
    DESKRIPSI = db.Column(db.String(350))
    AK = db.Column(db.Float)
    QTY = db.Column(db.Float)
    GOL = db.Column(db.String(10))               # Golongan ruang (label teks)
    GOL_PARENT = db.Column(db.String(10))        # Golongan atasan
    BIAYA = db.Column(db.Float)
    UNSUR = db.Column(db.String(50))
    TGL_MULAI = db.Column(db.Date)
    SATUAN_QTY = db.Column(db.String(50))
    KETERANGAN = db.Column(db.String(350))

    # Metadata
    UPDATE_DATE = db.Column(db.DateTime)
    CREATE_DATE = db.Column(db.DateTime)
    NIP_PARENT = db.Column(db.String(50))        # NIP atasan penilai
    JABATAN_ID_PARENT = db.Column(db.Integer)    # Jabatan atasan (ID, bukan FK formal)

    # Status & pengajuan
    STATUS = db.Column(db.Integer)
    KETERANGAN_PENGAJUAN = db.Column(db.String(150))

    def __repr__(self):
        return f'<BukuHarianHead {self.GUID}>'

    def to_dict(self):
        return {
            'guid': self.GUID,
            'jabatan_id': self.JABATAN_ID,
            'nip': self.NIP,
            'item_id': self.ITEM_ID,
            'guid_skp_peg': self.GUID_SKP_PEG,
            'deskripsi': self.DESKRIPSI,
            'ak': self.AK,
            'qty': self.QTY,
            'gol': self.GOL,
            'gol_parent': self.GOL_PARENT,
            'biaya': self.BIAYA,
            'unsur': self.UNSUR,
            'tgl_mulai': self.TGL_MULAI.isoformat() if self.TGL_MULAI else None,
            'satuan_qty': self.SATUAN_QTY,
            'keterangan': self.KETERANGAN,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'create_date': self.CREATE_DATE.isoformat() if self.CREATE_DATE else None,
            'nip_parent': self.NIP_PARENT,
            'jabatan_id_parent': self.JABATAN_ID_PARENT,
            'status': self.STATUS,
            'keterangan_pengajuan': self.KETERANGAN_PENGAJUAN
        }