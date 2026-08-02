from app import db


class MfEmailSend(db.Model):
    """
    Model untuk tabel MF_EMAIL_SEND.
    Menyimpan konfigurasi akun email untuk pengiriman notifikasi.
    
    Struktur tabel di database:
    - EMAIL_SEND varchar(50)
    - PASS_SEND varchar(50)
    - UPDATE_BY varchar(50)
    - UPDATE_DATE timestamp
    - SMTP_SEND varchar(50)
    - PORT_SENT varchar(10)  ← Perhatikan: PORT_SENT (bukan PORT_SEND)
    """
    __tablename__ = 'MF_EMAIL_SEND'

    # Gunakan EMAIL_SEND sebagai primary key (tabel hanya 1 record)
    EMAIL_SEND = db.Column(db.String(50), primary_key=True)
    PASS_SEND = db.Column(db.String(50))
    SMTP_SEND = db.Column(db.String(50))
    PORT_SENT = db.Column(db.String(10))  # ✅ PORT_SENT sesuai database
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    def __repr__(self):
        return f'<MfEmailSend {self.EMAIL_SEND}>'

    def to_dict(self):
        return {
            'email_send': self.EMAIL_SEND,
            'smtp_send': self.SMTP_SEND,
            'port_send': self.PORT_SENT,  # ✅ Gunakan PORT_SENT
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
        }