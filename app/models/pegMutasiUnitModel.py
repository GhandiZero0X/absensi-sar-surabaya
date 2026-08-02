# app/models/pegMutasiUnitModel.py
from app import db

class PegMutasiUnit(db.Model):
    """
    Model untuk tabel PEG_MUTASI_UNIT.
    """
    __tablename__ = 'PEG_MUTASI_UNIT'

    # Composite Primary Key
    TRAKSAKSI_ID = db.Column(db.Integer, primary_key=True, nullable=False, autoincrement=True)  # ✅ Tambahkan autoincrement
    NIP = db.Column(db.String(50), primary_key=True, nullable=False)

    TGL_MUTASI = db.Column(db.Date)
    UNIT_KERJA = db.Column(db.String(50))
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)
    NO_SK = db.Column(db.String(50))
    KETERANGAN = db.Column(db.String(250))

    def __repr__(self):
        return f'<PegMutasiUnit {self.NIP} Trx:{self.TRAKSAKSI_ID}>'