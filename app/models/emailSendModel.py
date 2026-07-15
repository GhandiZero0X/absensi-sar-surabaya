# app/models/emailSendModel.py
from app import db


class MfEmailSend(db.Model):
    """
    Model untuk tabel MF_EMAIL_SEND.
    Menyimpan konfigurasi akun email untuk pengiriman notifikasi.

    ⚠️ Tabel asli tidak memiliki primary key.
    Model ini menambahkan kolom `id` (auto‑increment) sebagai pengganti
    agar kompatibel dengan ORM SQLAlchemy. Saat membuat tabel via migrasi
    Flask‑Migrate, pastikan kolom ini ada.
    """
    __tablename__ = 'MF_EMAIL_SEND'

    # Synthetic primary key (tambahan, bukan dari DDL asli)
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    # Konfigurasi email pengirim
    EMAIL_SEND = db.Column(db.String(50))
    PASS_SEND = db.Column(db.String(50))       # Password email (sebaiknya terenkripsi di level aplikasi)

    # Metadata audit
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    # Konfigurasi SMTP server
    SMTP_SEND = db.Column(db.String(50))
    PORT_SENT = db.Column(db.String(10))

    def __repr__(self):
        return f'<MfEmailSend id:{self.id} {self.EMAIL_SEND}>'

    def to_dict(self):
        return {
            'id': self.id,
            'email_send': self.EMAIL_SEND,
            'pass_send': '***' if self.PASS_SEND else None,  # Sembunyikan password di output
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'smtp_send': self.SMTP_SEND,
            'port_sent': self.PORT_SENT
        }