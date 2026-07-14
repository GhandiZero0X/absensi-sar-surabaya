# app/models/joblistModel.py
from app import db


class MfJoblist(db.Model):
    """
    Model untuk tabel MF_JOBLIST.
    Menghubungkan item kegiatan (dari MF_JABATAN_KEGIATAN) dengan grup jabatan (MF_GROUP_JABATAN).
    Mewakili daftar pekerjaan standar yang melekat pada suatu kelompok jabatan.

    Composite Primary Key : GROUP_JABATAN_ID + ITEM_ID
    Foreign Key           : GROUP_JABATAN_ID -> MF_GROUP_JABATAN (GROUP_JABATAN_ID)
                            ITEM_ID          -> MF_JABATAN_KEGIATAN (ITEM_ID)
    """
    __tablename__ = 'MF_JOBLIST'

    # Composite Primary Key (sekaligus foreign key)
    GROUP_JABATAN_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_GROUP_JABATAN.GROUP_JABATAN_ID'),
        primary_key=True,
        nullable=False
    )
    ITEM_ID = db.Column(
        db.String(50),
        db.ForeignKey('MF_JABATAN_KEGIATAN.ITEM_ID'),
        primary_key=True,
        nullable=False
    )

    # Rincian standar kegiatan
    DESKRIPSI = db.Column(db.String(500))
    AK = db.Column(db.Float)          # Angka Kredit
    QTY = db.Column(db.Float)         # Target kuantitas standar
    MUTU = db.Column(db.Float)        # Target mutu standar
    WAKTU = db.Column(db.DateTime)    # Target waktu (sebagai timestamp)
    BIAYA = db.Column(db.Float)       # Biaya standar

    def __repr__(self):
        return f'<MfJoblist Group:{self.GROUP_JABATAN_ID} Item:{self.ITEM_ID}>'

    def to_dict(self):
        return {
            'group_jabatan_id': self.GROUP_JABATAN_ID,
            'item_id': self.ITEM_ID,
            'deskripsi': self.DESKRIPSI,
            'ak': self.AK,
            'qty': self.QTY,
            'mutu': self.MUTU,
            'waktu': self.WAKTU.isoformat() if self.WAKTU else None,
            'biaya': self.BIAYA
        }