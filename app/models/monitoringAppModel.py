# app/models/monitoringAppModel.py
from app import db


class MonitoringApp(db.Model):
    """
    Model untuk tabel MONITORING_APP.
    Mencatat aktivitas login/logout user per aplikasi.

    ⚠️ Tabel asli tidak memiliki primary key.
    Model ini menambahkan kolom `id` (auto‑increment) sebagai pengganti
    agar kompatibel dengan ORM SQLAlchemy.

    Foreign Key : TRAKSAKSI_ID -> LOG_TRANSAKSI (TRAKSAKSI_ID)
    """
    __tablename__ = 'MONITORING_APP'

    # Synthetic primary key (tambahan, bukan dari DDL asli)
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    # Foreign Key ke LOG_TRANSAKSI
    TRAKSAKSI_ID = db.Column(
        db.Integer,
        db.ForeignKey('LOG_TRANSAKSI.TRAKSAKSI_ID'),
        nullable=False
    )

    # Data login
    APLICATION = db.Column(db.String(50))
    USER_NAME = db.Column(db.String(50))
    COMPUTER_IP = db.Column(db.String(50))
    LOGIN_TIME = db.Column(db.DateTime)
    LOGIN_DATE = db.Column(db.DateTime)
    IS_ON = db.Column(db.String(5))          # Status login (Y/N)

    def __repr__(self):
        return f'<MonitoringApp id:{self.id} App:{self.APLICATION} User:{self.USER_NAME}>'

    def to_dict(self):
        return {
            'id': self.id,
            'traksaksi_id': self.TRAKSAKSI_ID,
            'aplication': self.APLICATION,
            'user_name': self.USER_NAME,
            'computer_ip': self.COMPUTER_IP,
            'login_time': self.LOGIN_TIME.isoformat() if self.LOGIN_TIME else None,
            'login_date': self.LOGIN_DATE.isoformat() if self.LOGIN_DATE else None,
            'is_on': self.IS_ON
        }