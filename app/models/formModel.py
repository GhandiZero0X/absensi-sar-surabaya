# app/models/formModel.py
from app import db


class MfForm(db.Model):
    """
    Model untuk tabel MF_FORM.
    Menyimpan definisi form/modul aplikasi (menu dan navigasi).

    Primary Key : FORM_ID
    """
    __tablename__ = 'MF_FORM'

    FORM_ID = db.Column(db.String(50), primary_key=True, nullable=False)

    FORM_NAME = db.Column(db.String(70))
    FORM_TYPE = db.Column(db.String(20))
    NO_URUT = db.Column(db.Integer)
    BERKAS = db.Column(db.String(50))
    PANEL_PAGE = db.Column(db.String(50))
    IMG_URL = db.Column(db.String(50))
    NO_URUT_PANEL = db.Column(db.Integer)
    MODUL = db.Column(db.String(50))
    PARENT_FORM = db.Column(db.String(50))
    MODEL = db.Column(db.Integer)
    ICON_FA = db.Column(db.String(50))          # FontAwesome icon class
    HIRARKI_LV = db.Column(db.Integer)          # Level hirarki menu
    TRANSAKSI_ID = db.Column(db.Integer)        # Referensi ID transaksi (bukan FK formal)

    def __repr__(self):
        return f'<MfForm {self.FORM_ID} - {self.FORM_NAME}>'

    def to_dict(self):
        return {
            'form_id': self.FORM_ID,
            'form_name': self.FORM_NAME,
            'form_type': self.FORM_TYPE,
            'no_urut': self.NO_URUT,
            'berkas': self.BERKAS,
            'panel_page': self.PANEL_PAGE,
            'img_url': self.IMG_URL,
            'no_urut_panel': self.NO_URUT_PANEL,
            'modul': self.MODUL,
            'parent_form': self.PARENT_FORM,
            'model': self.MODEL,
            'icon_fa': self.ICON_FA,
            'hirarki_lv': self.HIRARKI_LV,
            'transaksi_id': self.TRANSAKSI_ID
        }