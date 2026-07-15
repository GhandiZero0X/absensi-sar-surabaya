# app/models/priorityTransaksiModel.py
from app import db


class MfPriorityTransaksi(db.Model):
    """
    Model untuk tabel MF_PRIORITY_TRANSAKSI.
    Menentukan prioritas/urutan proses transaksi per modul.

    ⚠️ Tabel asli tidak memiliki primary key.
    Model ini menambahkan kolom `id` (auto‑increment) sebagai pengganti
    agar kompatibel dengan ORM SQLAlchemy.
    """
    __tablename__ = 'MF_PRIORITY_TRANSAKSI'

    # Synthetic primary key
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    MODUL = db.Column(db.String(50))
    PRIORITY_TRANSAKSI = db.Column(db.Integer)
    TRANSAKSI = db.Column(db.String(50))
    INISIAL_TRANSAKSI = db.Column(db.String(5))

    def __repr__(self):
        return f'<MfPriorityTransaksi id:{self.id} {self.MODUL} - {self.TRANSAKSI}>'

    def to_dict(self):
        return {
            'id': self.id,
            'modul': self.MODUL,
            'priority_transaksi': self.PRIORITY_TRANSAKSI,
            'transaksi': self.TRANSAKSI,
            'inisial_transaksi': self.INISIAL_TRANSAKSI
        }