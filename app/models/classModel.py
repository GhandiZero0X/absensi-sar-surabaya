# app/models/classModel.py
from app import db


class MfClass(db.Model):
    """
    Model untuk tabel MF_CLASS.
    Merepresentasikan data master kelas jabatan/tunjangan kelas pegawai.
    Primary Key : CLASS_ID
    Digunakan sebagai referensi oleh tabel PEGAWAI (CLASS_ID).
    """
    __tablename__ = 'MF_CLASS'

    # Primary Key
    CLASS_ID = db.Column(db.Integer, primary_key=True)

    # Data kelas
    TUNJANGAN = db.Column(db.Float, nullable=True)
    ID = db.Column(db.Integer, nullable=True)
    TGL_MULAI = db.Column(db.DateTime, nullable=True)

    # Metadata audit
    UPDATE_IN_BY = db.Column(db.String(50), nullable=True)
    UPDATE_DATE = db.Column(db.DateTime, nullable=True)
    DOKREFF = db.Column(db.String(250), nullable=True)

    # Representasi objek (memudahkan debugging di console/log)
    def __repr__(self):
        return f'<MfClass {self.CLASS_ID}>'

    # Helper: ubah objek jadi dict (berguna untuk response JSON/API)
    def to_dict(self):
        return {
            'class_id': self.CLASS_ID,
            'tunjangan': self.TUNJANGAN,
            'id': self.ID,
            'tgl_mulai': self.TGL_MULAI.isoformat() if self.TGL_MULAI else None,
            'dokreff': self.DOKREFF,
        }