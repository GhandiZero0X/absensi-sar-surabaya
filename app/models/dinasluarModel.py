# app/models/izinModel.py
from app import db


class DinasLuar(db.Model):
    """
    Model untuk tabel DINAS_LUAR.
    Merepresentasikan data izin dinas luar pegawai
    berdasarkan Surat Perintah (SPRIN).
    Primary Key : DINAS_TRANSAKSI_ID
    Foreign Key : GUID_SPRIN -> SPRIN_HEADER.GUID_SPRIN
                  NIP        -> PEGAWAI.NIP
    """
    __tablename__ = 'DINAS_LUAR'

    # Primary Key
    DINAS_TRANSAKSI_ID = db.Column(db.String(50), primary_key=True)

    # Foreign Key (NOT NULL sesuai DDL asli)
    GUID_SPRIN = db.Column(
        db.String(50),
        db.ForeignKey('SPRIN_HEADER.GUID_SPRIN'),
        nullable=False
    )
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        nullable=False
    )

    # Periode dinas luar
    TGL_AWAL_DINAS_LUAR = db.Column(db.DateTime, nullable=True)
    TGL_AKHIR_DINAS_LUAR = db.Column(db.DateTime, nullable=True)
    KETERANGAN_DINAS_LUAR = db.Column(db.String(450), nullable=True)
    PENEMPATAN_DINAS_LUAR = db.Column(db.String(350), nullable=True)

    # Info transaksi & dokumen pendukung
    TRANSAKSI = db.Column(db.String(50), nullable=True)
    PENDUKUNG = db.Column(db.String(50), nullable=True)
    NO_SURAT = db.Column(db.String(250), nullable=True)
    JENIS = db.Column(db.String(10), nullable=True)
    NAMA_FILE = db.Column(db.String(100), nullable=True)

    # Periode surat (bisa berbeda dengan periode dinas aktual)
    TGL_AWAL_SURAT = db.Column(db.Date, nullable=True)
    TGL_AKHIR_SURAT = db.Column(db.Date, nullable=True)

    # Info email notifikasi
    TGL_EMAIL = db.Column(db.DateTime, nullable=True)
    TIPE = db.Column(db.Integer, nullable=True)
    STATUS_UM = db.Column(db.Integer, nullable=True)

    # Metadata audit
    UPDATE_BY = db.Column(db.String(50), nullable=True)
    UPDATE_DATE = db.Column(db.DateTime, nullable=True)

    # Relationship (opsional, memudahkan akses objek terkait)
    pegawai = db.relationship('Pegawai', backref='dinas_luar_list', lazy=True)
    sprin_header = db.relationship('SprinHeader', backref='dinas_luar_list', lazy=True)

    # Representasi objek (memudahkan debugging di console/log)
    def __repr__(self):
        return f'<DinasLuar {self.DINAS_TRANSAKSI_ID} - NIP: {self.NIP}>'

    # Helper: ubah objek jadi dict (berguna untuk response JSON/API)
    def to_dict(self):
        return {
            'dinas_transaksi_id': self.DINAS_TRANSAKSI_ID,
            'guid_sprin': self.GUID_SPRIN,
            'nip': self.NIP,
            'tgl_awal_dinas_luar': (
                self.TGL_AWAL_DINAS_LUAR.isoformat()
                if self.TGL_AWAL_DINAS_LUAR else None
            ),
            'tgl_akhir_dinas_luar': (
                self.TGL_AKHIR_DINAS_LUAR.isoformat()
                if self.TGL_AKHIR_DINAS_LUAR else None
            ),
            'keterangan_dinas_luar': self.KETERANGAN_DINAS_LUAR,
            'penempatan_dinas_luar': self.PENEMPATAN_DINAS_LUAR,
            'no_surat': self.NO_SURAT,
            'jenis': self.JENIS,
            'tgl_awal_surat': (
                self.TGL_AWAL_SURAT.isoformat()
                if self.TGL_AWAL_SURAT else None
            ),
            'tgl_akhir_surat': (
                self.TGL_AKHIR_SURAT.isoformat()
                if self.TGL_AKHIR_SURAT else None
            ),
            'status_um': self.STATUS_UM,
            'tipe': self.TIPE,
        }