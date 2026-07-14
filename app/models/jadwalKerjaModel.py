# app/models/jadwalKerjaModel.py
from app import db


class MfJamKerja(db.Model):
    """
    Model untuk tabel MF_JAM_KERJA.
    Merepresentasikan data master jadwal/jam kerja (termasuk shift).
    Primary Key : JAM_KERJA_ID
    Tidak ada foreign key eksplisit pada tabel ini di DDL asli.
    """
    __tablename__ = 'MF_JAM_KERJA'

    # Primary Key
    JAM_KERJA_ID = db.Column(db.Integer, primary_key=True)

    # Jadwal jam standar
    STD_JAM_IN = db.Column(db.DateTime, nullable=True)
    STD_JAM_OUT = db.Column(db.DateTime, nullable=True)
    TGL_MULAI_BERLAKU = db.Column(db.DateTime, nullable=True)

    # Info shift & agenda
    SHIFT = db.Column(db.String(50), nullable=True)
    AGENDA = db.Column(db.String(50), nullable=True)
    PENGGANTIAN_TLM1 = db.Column(db.String(5), nullable=True)
    SHIFT_KERJA = db.Column(db.String(2), nullable=True)

    # Metadata audit
    UPDATE_BY = db.Column(db.String(50), nullable=True)
    UPDATE_DATE = db.Column(db.DateTime, nullable=True)

    # Representasi objek (memudahkan debugging di console/log)
    def __repr__(self):
        return f'<MfJamKerja {self.JAM_KERJA_ID} - {self.SHIFT}>'

    # Helper: ubah objek jadi dict (berguna untuk response JSON/API)
    def to_dict(self):
        return {
            'jam_kerja_id': self.JAM_KERJA_ID,
            'std_jam_in': self.STD_JAM_IN.isoformat() if self.STD_JAM_IN else None,
            'std_jam_out': self.STD_JAM_OUT.isoformat() if self.STD_JAM_OUT else None,
            'tgl_mulai_berlaku': self.TGL_MULAI_BERLAKU.isoformat() if self.TGL_MULAI_BERLAKU else None,
            'shift': self.SHIFT,
            'agenda': self.AGENDA,
            'penggantian_tlm1': self.PENGGANTIAN_TLM1,
            'shift_kerja': self.SHIFT_KERJA,
        }