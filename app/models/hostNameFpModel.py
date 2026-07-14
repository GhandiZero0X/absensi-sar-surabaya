# app/models/hostNameFpModel.py
from app import db


class MfHostNameFp(db.Model):
    """
    Model untuk tabel MF_HOST_NAME_FP.
    Menyimpan pemetaan antara unit kerja dengan host name mesin fingerprint.

    Primary Key : UNIT_KERJA_ID (sekaligus foreign key ke MF_UNIT_KERJA)
    Foreign Key : UNIT_KERJA_ID -> MF_UNIT_KERJA (UNIT_KERJA_ID)
    """
    __tablename__ = 'MF_HOST_NAME_FP'

    # Primary Key & Foreign Key ke MF_UNIT_KERJA
    UNIT_KERJA_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_UNIT_KERJA.UNIT_KERJA_ID'),
        primary_key=True,
        nullable=False
    )

    # Nama host/alamat mesin fingerprint
    HOST_NAME_FP = db.Column(db.String(50), nullable=True)

    def __repr__(self):
        return f'<MfHostNameFp Unit:{self.UNIT_KERJA_ID} Host:{self.HOST_NAME_FP}>'

    def to_dict(self):
        return {
            'unit_kerja_id': self.UNIT_KERJA_ID,
            'host_name_fp': self.HOST_NAME_FP
        }