# app/models/mfTimSiagaAnggotaModel.py
from app import db


class MfTimSiagaAnggota(db.Model):
    """
    Model untuk tabel MF_TIM_SIAGA_ANGGOTA.
    Menyimpan anggota tim siaga (siapa saja yang termasuk dalam tim jaga).

    Composite Primary Key : NIP + GUID_TIM
    Foreign Key           : NIP      -> PEGAWAI (NIP)
                            GUID_TIM -> MF_TIM_SIAGA (GUID_TIM)
    """
    __tablename__ = 'MF_TIM_SIAGA_ANGGOTA'

    # Primary Keys (sekaligus foreign keys)
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP'),
        primary_key=True,
        nullable=False
    )
    GUID_TIM = db.Column(
        db.String(50),
        db.ForeignKey('MF_TIM_SIAGA.GUID_TIM'),
        primary_key=True,
        nullable=False
    )

    # Data keanggotaan
    FUNGSIONAL = db.Column(db.String(50))      # Peran dalam tim (Komandan, Anggota, dll.)
    IS_AKTIF = db.Column(db.String(1))
    ID_UNIT_KERJA = db.Column(db.String(50))   # Unit kerja saat menjadi anggota
    NO_URUT = db.Column(db.Integer)
    BULAN_PERIODE = db.Column(db.String(2))
    TAHUN_PERIODE = db.Column(db.String(4))
    SHIFT = db.Column(db.String(5))

    # Metadata
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    def __repr__(self):
        return f'<MfTimSiagaAnggota {self.NIP} - Tim:{self.GUID_TIM}>'

    def to_dict(self):
        return {
            'nip': self.NIP,
            'guid_tim': self.GUID_TIM,
            'fungsional': self.FUNGSIONAL,
            'is_aktif': self.IS_AKTIF,
            'id_unit_kerja': self.ID_UNIT_KERJA,
            'no_urut': self.NO_URUT,
            'bulan_periode': self.BULAN_PERIODE,
            'tahun_periode': self.TAHUN_PERIODE,
            'shift': self.SHIFT,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None
        }