# app/models/sprinHeaderModel.py
from app import db


class SprinHeader(db.Model):
    """
    Model untuk tabel SPRIN_HEADER.
    Menyimpan header Surat Perintah (SPRIN) seperti dinas luar,
    penugasan, dan perjalanan resmi.

    Primary Key : GUID_SPRIN
    Foreign Key : TYPE_SPRIN_ID -> MF_TYPE_SPRIN (TYPE_SPRIN_ID)
    """
    __tablename__ = 'SPRIN_HEADER'

    # Primary Key
    GUID_SPRIN = db.Column(db.String(50), primary_key=True, nullable=False)

    # Foreign Key ke MF_TYPE_SPRIN
    TYPE_SPRIN_ID = db.Column(
        db.String(20),  # CHAR(20) di DDL
        db.ForeignKey('MF_TYPE_SPRIN.TYPE_SPRIN_ID'),
        nullable=False
    )

    # Metadata audit
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    # Nomor urut peran dalam SPRIN
    ROLE_NUMBER = db.Column(db.Integer)

    # Flag pengecualian finger (ya/tidak)
    ABSENSI_FINGER = db.Column(db.String(2))

    # Tanggal SPRIN
    TGL_SPRIN = db.Column(db.Date)

    # Perihal surat perintah
    PERIHAL_SPRIN = db.Column(db.String(250))

    # Pertimbangan / menimbang (maks 3 poin)
    MENIMBANG_1 = db.Column(db.String(250))
    MENIMBANG_2 = db.Column(db.String(250))
    MENIMBANG_3 = db.Column(db.String(250))

    # Dasar hukum / dasar (maks 3 poin)
    DASAR_1 = db.Column(db.String(250))
    DASAR_2 = db.Column(db.String(250))
    DASAR_3 = db.Column(db.String(250))

    # Untuk perintah (maks 5 poin)
    UNTUK_1 = db.Column(db.String(250))
    UNTUK_2 = db.Column(db.String(250))
    UNTUK_3 = db.Column(db.String(250))
    UNTUK_4 = db.Column(db.String(250))
    UNTUK_5 = db.Column(db.String(250))

    # Data pejabat otorisasi SPRIN
    JABATAN_OTO = db.Column(db.String(100))
    NIP_OTO = db.Column(db.String(50))

    # Penomoran surat
    NO_URUT_SPRIN = db.Column(db.String(5))
    NO_SISIPAN = db.Column(db.String(50))
    NO_SPRIN = db.Column(db.String(50))           # Nomor SPRIN lengkap

    # Tanggal berlaku surat
    TGL_AWAL_SPRIN = db.Column(db.Date)
    TGL_AKHIR_SPRIN = db.Column(db.String(50))    # DDL asli VARCHAR, bisa diisi teks

    # Lokasi penempatan tugas
    PENEMPATAN = db.Column(db.String(150))

    # Status umum (mungkin untuk flag integrasi)
    STATUS_UM = db.Column(db.Integer)

    def __repr__(self):
        return f'<SprinHeader {self.GUID_SPRIN}>'

    def to_dict(self):
        return {
            'guid_sprin': self.GUID_SPRIN,
            'type_sprin_id': self.TYPE_SPRIN_ID,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'role_number': self.ROLE_NUMBER,
            'absensi_finger': self.ABSENSI_FINGER,
            'tgl_sprin': self.TGL_SPRIN.isoformat() if self.TGL_SPRIN else None,
            'perihal_sprin': self.PERIHAL_SPRIN,
            'menimbang_1': self.MENIMBANG_1,
            'menimbang_2': self.MENIMBANG_2,
            'menimbang_3': self.MENIMBANG_3,
            'dasar_1': self.DASAR_1,
            'dasar_2': self.DASAR_2,
            'dasar_3': self.DASAR_3,
            'untuk_1': self.UNTUK_1,
            'untuk_2': self.UNTUK_2,
            'untuk_3': self.UNTUK_3,
            'untuk_4': self.UNTUK_4,
            'untuk_5': self.UNTUK_5,
            'jabatan_oto': self.JABATAN_OTO,
            'nip_oto': self.NIP_OTO,
            'no_urut_sprin': self.NO_URUT_SPRIN,
            'no_sisipan': self.NO_SISIPAN,
            'no_sprin': self.NO_SPRIN,
            'tgl_awal_sprin': self.TGL_AWAL_SPRIN.isoformat() if self.TGL_AWAL_SPRIN else None,
            'tgl_akhir_sprin': self.TGL_AKHIR_SPRIN,
            'penempatan': self.PENEMPATAN,
            'status_um': self.STATUS_UM
        }