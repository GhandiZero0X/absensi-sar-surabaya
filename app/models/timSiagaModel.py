# app/models/timSiagaModel.py
from app import db


class MfTimSiaga(db.Model):
    """
    Model untuk tabel MF_TIM_SIAGA.
    Menyimpan data tim siaga/jaga.

    Primary Key : GUID_TIM
    """
    __tablename__ = 'MF_TIM_SIAGA'

    # Primary Key
    GUID_TIM = db.Column(db.String(50), primary_key=True, nullable=False)

    # Informasi tim
    NO_URUT_TIM = db.Column(db.Integer)
    NAMA_TIM = db.Column(db.String(50))
    ID_UNIT_KERJA = db.Column(db.String(50))   # Meski namanya "ID", tetap VARCHAR(50) sesuai DDL
    BULAN_PERIODE = db.Column(db.String(2))
    TAHUN_PERIODE = db.Column(db.String(4))
    FUNGSIONAL_TIM = db.Column(db.String(50))
    SHIFT = db.Column(db.String(5))
    IS_AKTIF = db.Column(db.String(1))

    # Metadata
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    def __repr__(self):
        return f'<MfTimSiaga {self.GUID_TIM}>'

    def to_dict(self):
        return {
            'guid_tim': self.GUID_TIM,
            'no_urut_tim': self.NO_URUT_TIM,
            'nama_tim': self.NAMA_TIM,
            'id_unit_kerja': self.ID_UNIT_KERJA,
            'bulan_periode': self.BULAN_PERIODE,
            'tahun_periode': self.TAHUN_PERIODE,
            'fungsional_tim': self.FUNGSIONAL_TIM,
            'shift': self.SHIFT,
            'is_aktif': self.IS_AKTIF,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None
        }