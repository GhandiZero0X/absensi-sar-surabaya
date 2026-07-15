# app/models/skpPegawaiHeadModel.py
from app import db


class SkpPegawaiHead(db.Model):
    """
    Model untuk tabel SKP_PEGAWAI_HEAD.
    Menyimpan header/ringkasan SKP pegawai.

    Primary Key : SKP_PEGAWAI_HEAD_ID
    Foreign Key : GUID_SKP_PEG      -> SKP_PEGAWAI (GUID_SKP_PEG)
                  NIP               -> PEGAWAI (NIP)
                  GOL_ID            -> MF_GOL (GOL_ID)
                  JABATAN_ID        -> MF_JABATAN (JABATAN_ID)
    """
    __tablename__ = 'SKP_PEGAWAI_HEAD'

    # Primary Key
    SKP_PEGAWAI_HEAD_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Foreign Keys
    GUID_SKP_PEG = db.Column(
        db.String(100),
        db.ForeignKey('SKP_PEGAWAI.GUID_SKP_PEG'),
        nullable=False
    )
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        nullable=False
    )
    GOL_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_GOL.GOL_ID'),
        nullable=False
    )
    JABATAN_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_JABATAN.JABATAN_ID'),
        nullable=False
    )

    # Tanggal mulai berlaku SKP
    TGL_MULAI = db.Column(db.DateTime)

    # Data atasan langsung (pejabat penilai)
    NIP_PARENT = db.Column(db.String(50))
    JABATAN_ID_PARENT = db.Column(db.String(50))   # Bukan foreign key, hanya teks

    # Metadata
    UPDATE_DATE = db.Column(db.DateTime)
    TGL_PEMBUATAN = db.Column(db.DateTime)

    # Golongan atasan (teks)
    GOL_PARENT = db.Column(db.String(10))

    def __repr__(self):
        return f'<SkpPegawaiHead {self.SKP_PEGAWAI_HEAD_ID}>'

    def to_dict(self):
        return {
            'skp_pegawai_head_id': self.SKP_PEGAWAI_HEAD_ID,
            'guid_skp_peg': self.GUID_SKP_PEG,
            'nip': self.NIP,
            'gol_id': self.GOL_ID,
            'jabatan_id': self.JABATAN_ID,
            'tgl_mulai': self.TGL_MULAI.isoformat() if self.TGL_MULAI else None,
            'nip_parent': self.NIP_PARENT,
            'jabatan_id_parent': self.JABATAN_ID_PARENT,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'tgl_pembuatan': self.TGL_PEMBUATAN.isoformat() if self.TGL_PEMBUATAN else None,
            'gol_parent': self.GOL_PARENT
        }