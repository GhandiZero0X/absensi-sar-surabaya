# app/models/userAccountModel.py
from app import db


class UserAccount(db.Model):
    """
    Model untuk tabel USER_ACCOUNT.
    Menyimpan data akun/hak akses sistem milik seorang pegawai.

    Primary Key : NIP (sekaligus Foreign Key ke PEGAWAI)
    Foreign Key : NIP -> PEGAWAI.NIP

    Catatan: Pada DDL asli, tabel USER_ACCOUNT tidak mendefinisikan
    PRIMARY KEY terpisah. Karena setiap pegawai hanya memiliki satu
    akun (relasi one-to-one dengan PEGAWAI), NIP dijadikan primary key
    sekaligus foreign key di model ini.
    """
    __tablename__ = 'USER_ACCOUNT'

    # Primary Key sekaligus Foreign Key ke PEGAWAI
    NIP = db.Column(
        db.String(50),
        db.ForeignKey('PEGAWAI.NIP', onupdate='RESTRICT', ondelete='RESTRICT'),
        primary_key=True
    )

    # Data akun/hak akses
    INIT_LEVEL = db.Column(db.Integer, nullable=True)
    MODUL = db.Column(db.String(50), nullable=True)

    # Metadata audit
    UPDATE_BY = db.Column(db.String(50), nullable=True)
    UPDATE_DATE = db.Column(db.DateTime, nullable=True)

    # Relasi ke Pegawai (akses balik: pegawai.user_account)
    pegawai = db.relationship(
        'Pegawai',
        backref=db.backref('user_account', uselist=False)
    )

    # Representasi objek (memudahkan debugging di console/log)
    def __repr__(self):
        return f'<UserAccount {self.NIP} - {self.MODUL}>'

    # Helper: ubah objek jadi dict (berguna untuk response JSON/API)
    def to_dict(self):
        return {
            'nip': self.NIP,
            'init_level': self.INIT_LEVEL,
            'modul': self.MODUL,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
        }