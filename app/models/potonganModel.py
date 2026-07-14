# app/models/mfPotonganModel.py
from app import db


class MfPotongan(db.Model):
    """
    Model untuk tabel MF_POTONGAN.
    Menyimpan aturan pemotongan (deduction rules) – kemungkinan versi lama/simplifikasi dari MF_POT.
    Tidak dilengkapi kolom durasi dan tindakan.

    Primary Key : POT_ID
    """
    __tablename__ = 'MF_POTONGAN'

    POT_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    KATEGORI = db.Column(db.String(50))
    TINGKAT = db.Column(db.String(50))
    PERSEN_POT = db.Column(db.Float)
    TGL_MULAI = db.Column(db.DateTime)
    RANGE_AWAL = db.Column(db.Float)
    RANGE_AKHIR = db.Column(db.Float)
    NAMA_POT = db.Column(db.String(50))

    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    # Penanda perlu/tidak dokumen pendukung
    IS_PENDUKUNG = db.Column(db.String(2))

    def __repr__(self):
        return f'<MfPotongan {self.POT_ID} - {self.NAMA_POT}>'

    def to_dict(self):
        return {
            'pot_id': self.POT_ID,
            'kategori': self.KATEGORI,
            'tingkat': self.TINGKAT,
            'persen_pot': self.PERSEN_POT,
            'tgl_mulai': self.TGL_MULAI.isoformat() if self.TGL_MULAI else None,
            'range_awal': self.RANGE_AWAL,
            'range_akhir': self.RANGE_AKHIR,
            'nama_pot': self.NAMA_POT,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'is_pendukung': self.IS_PENDUKUNG
        }