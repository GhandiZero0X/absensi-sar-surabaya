# app/models/jamKerjaModel.py
from app import db


class MfJamKerja(db.Model):
    """
    Model untuk tabel MF_JAM_KERJA.
    Menyimpan konfigurasi standar jam kerja per shift/agenda.

    Primary Key : JAM_KERJA_ID
    """
    __tablename__ = 'MF_JAM_KERJA'

    # Primary Key
    JAM_KERJA_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Standar jam masuk dan pulang
    STD_JAM_IN = db.Column(db.DateTime)
    STD_JAM_OUT = db.Column(db.DateTime)

    # Tanggal mulai berlaku konfigurasi
    TGL_MULAI_BERLAKU = db.Column(db.DateTime)

    # Keterangan shift
    SHIFT = db.Column(db.String(50))
    AGENDA = db.Column(db.String(50))

    # Penggantian toleransi keterlambatan 1 (ya/tidak)
    PENGGANTIAN_TLM1 = db.Column(db.String(5))

    # Metadata audit
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    # Kode shift kerja (2 karakter)
    SHIFT_KERJA = db.Column(db.String(2))

    def __repr__(self):
        return f'<MfJamKerja {self.JAM_KERJA_ID}>'

    def to_dict(self):
        return {
            'jam_kerja_id': self.JAM_KERJA_ID,
            'std_jam_in': self.STD_JAM_IN.isoformat() if self.STD_JAM_IN else None,
            'std_jam_out': self.STD_JAM_OUT.isoformat() if self.STD_JAM_OUT else None,
            'tgl_mulai_berlaku': self.TGL_MULAI_BERLAKU.isoformat() if self.TGL_MULAI_BERLAKU else None,
            'shift': self.SHIFT,
            'agenda': self.AGENDA,
            'penggantian_tlm1': self.PENGGANTIAN_TLM1,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'shift_kerja': self.SHIFT_KERJA
        }