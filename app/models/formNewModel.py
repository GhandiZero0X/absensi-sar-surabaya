# app/models/formNewModel.py
from app import db


class MfFormNew(db.Model):
    """
    Model untuk tabel MF_FORM_NEW.
    Versi baru / pengembangan dari MF_FORM, menyimpan definisi form/modul aplikasi.

    Primary Key : NEW_FORM_ID
    """
    __tablename__ = 'MF_FORM_NEW'

    NEW_FORM_ID = db.Column(db.String(50), primary_key=True, nullable=False)

    NEW_FORM_NAME = db.Column(db.String(70))
    NEW_FORM_TYPE = db.Column(db.String(20))
    NO_URUT = db.Column(db.Integer)
    BERKAS = db.Column(db.String(50))
    PANEL_PAGE = db.Column(db.String(50))
    IMG_URL = db.Column(db.String(50))
    NO_URUT_PANEL = db.Column(db.Integer)
    MODUL = db.Column(db.String(50))
    PARENT_FORM = db.Column(db.String(50))
    MODEL = db.Column(db.Integer)
    ICONFA = db.Column(db.String(50))          # FontAwesome icon class (nama kolom berbeda: ICONFA)
    HIRARKI_LV = db.Column(db.Integer)

    def __repr__(self):
        return f'<MfFormNew {self.NEW_FORM_ID} - {self.NEW_FORM_NAME}>'

    def to_dict(self):
        return {
            'new_form_id': self.NEW_FORM_ID,
            'new_form_name': self.NEW_FORM_NAME,
            'new_form_type': self.NEW_FORM_TYPE,
            'no_urut': self.NO_URUT,
            'berkas': self.BERKAS,
            'panel_page': self.PANEL_PAGE,
            'img_url': self.IMG_URL,
            'no_urut_panel': self.NO_URUT_PANEL,
            'modul': self.MODUL,
            'parent_form': self.PARENT_FORM,
            'model': self.MODEL,
            'iconfa': self.ICONFA,
            'hirarki_lv': self.HIRARKI_LV
        }