# app/models/jabatanModel.py
from app import db


class MfJabatan(db.Model):
    __tablename__ = 'MF_JABATAN'

    JABATAN_ID = db.Column(db.Integer, primary_key=True)

    JABATAN_ID_BARU = db.Column(
        db.Integer,
        db.ForeignKey('PERUBAHAN_JABATAN.JABATAN_ID_BARU', onupdate='RESTRICT', ondelete='RESTRICT'),
        nullable=False
    )
    GROUP_JABATAN_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_GROUP_JABATAN.GROUP_JABATAN_ID', onupdate='RESTRICT', ondelete='RESTRICT'),
        nullable=False
    )
    SUB_GROUP_JABATAN_ID = db.Column(
        db.Integer,
        db.ForeignKey('MF_SUB_GROUP_JABATAN.SUB_GROUP_JABATAN_ID', onupdate='RESTRICT', ondelete='RESTRICT'),
        nullable=False
    )

    JABATAN_MANAGE = db.Column(db.Integer, nullable=True)
    JABATAN_ID_OLD = db.Column(db.Integer, nullable=True)
    NAMA_JABATAN = db.Column(db.String(100), nullable=False)
    URUT_JABATAN = db.Column(db.Integer, nullable=False)
    TYPE_JABATAN = db.Column(db.String(10), nullable=False)
    IS_USE = db.Column(db.SmallInteger, nullable=False)

    UPDATE_IN_BY = db.Column(db.String(50), nullable=True)
    UPDATE_DATE = db.Column(db.DateTime, nullable=True)

    # --- DIPERBAIKI: nama class harus 'MfGroupJabatan' & 'MfSubGroupJabatan' ---
    group_jabatan = db.relationship(
        'MfGroupJabatan',
        foreign_keys=[GROUP_JABATAN_ID],
        backref=db.backref('jabatan_list', lazy='dynamic')
    )
    sub_group_jabatan = db.relationship(
        'MfSubGroupJabatan',
        foreign_keys=[SUB_GROUP_JABATAN_ID],
        backref=db.backref('jabatan_list', lazy='dynamic')
    )

    def __repr__(self):
        return f'<Jabatan {self.JABATAN_ID} - {self.NAMA_JABATAN}>'

    def to_dict(self):
        return {
            'jabatan_id': self.JABATAN_ID,
            'nama_jabatan': self.NAMA_JABATAN,
            'group_jabatan_id': self.GROUP_JABATAN_ID,
            'sub_group_jabatan_id': self.SUB_GROUP_JABATAN_ID,
            'urut_jabatan': self.URUT_JABATAN,
            'type_jabatan': self.TYPE_JABATAN,
            'is_use': self.IS_USE,
        }