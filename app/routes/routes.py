# app/routes/routes.py

from flask import Blueprint, jsonify
from app.controllers.homeDashboard_1Controller import (
    dashboard_kgb, dashboard_pangkat, dashboard_pelanggaran, dashboard_pensiun, dashboard_trt)
from app.controllers.masterFileDashboard_1Controller import (
    master_butir_kegiatan,
    master_jabatan,
    master_jam_finger,
    master_jam_kerja,
    master_kalender,
    master_pegawai_vip,
    master_potongan,
    master_trt as master_file_trt,
    master_tunkin_class,
    master_unit_kerja,
    master_user,
    master_uang_makan,
    cari_master_jabatan,
    cari_master_jam_finger,
    cari_master_jam_kerja,
    cari_master_kalender,
    cari_master_potongan,
    cari_master_tunkin_class,
    cari_master_uang_makan,
    cari_master_unit_kerja,
    cari_user_account,
    create_kalender,
)
from app.controllers.homeController import get_pelanggaran_disiplin, get_piket_siaga, home, search_buku_telp
from app.controllers.loginController import login, logout
from app.controllers.mediaInformasiDashboard_1Controller import media_informasi, media_informasi_detail

from app.models.pegawaiModel import Pegawai

main = Blueprint('main', __name__)

@main.route('/')
def index():
    return home()

@main.route('/api/search_pegawai')
def api_search_pegawai():
    return search_buku_telp()

@main.route('/api/piket_siaga')
def api_piket_siaga():
    return get_piket_siaga()

@main.route('/api/pelanggaran_disiplin')
def api_pelanggaran_disiplin():
    return get_pelanggaran_disiplin()

@main.route('/api/login', methods=['POST'])
def api_login():
    return login()

@main.route('/api/logout', methods=['POST'])
def api_logout():
    return logout()

@main.route('/api/pegawai/preview', methods=['GET'])
def preview_pegawai():
    data = Pegawai.query.order_by(Pegawai.NIP.asc()).limit(20).all()
    return jsonify({
        'count': len(data),
        'data': [pegawai.to_dict() for pegawai in data]
    })

# ---- Dashboard 1 Routes ----
# Dasboard :
@main.route('/dashboard/pelanggaran')
def view_dashboard_pelanggaran():
    return dashboard_pelanggaran()

@main.route('/dashboard/pensiun')
def view_dashboard_pensiun():
    return dashboard_pensiun()

@main.route('/dashboard/pangkat')
def view_dashboard_pangkat():
    return dashboard_pangkat()

@main.route('/dashboard/kgb')
def view_dashboard_kgb():
    return dashboard_kgb()

@main.route('/dashboard/trt')
def view_dashboard_trt():
    return dashboard_trt()

# Master File :
@main.route('/master/butir-kegiatan')
def view_master_butir_kegiatan():
    return master_butir_kegiatan()

@main.route('/master/jabatan')
def view_master_jabatan():
    return master_jabatan()

@main.route('/master/jam-finger')
def view_master_jam_finger():
    return master_jam_finger()

@main.route('/master/jam-kerja')
def view_master_jam_kerja():
    return master_jam_kerja()

@main.route('/master/kalender')
def view_master_kalender():
    return master_kalender()

@main.route('/master/pegawai-vip')
def view_master_pegawai_vip():
    return master_pegawai_vip()

@main.route('/master/potongan')
def view_master_potongan():
    return master_potongan()

@main.route('/master/trt')
def view_master_trt():
    return master_file_trt()

@main.route('/master/tunkin-class')
def view_master_tunkin_class():
    return master_tunkin_class()

@main.route('/master/unit-kerja')
def view_master_unit_kerja():
    return master_unit_kerja()

@main.route('/master/user')
def view_master_user():
    return master_user()

@main.route('/master/uang-makan')
def view_master_uang_makan():
    return master_uang_makan()

# Cari Master :
@main.route('/master/cari/jabatan')
def view_cari_master_jabatan():
    return cari_master_jabatan()

@main.route('/master/cari/jam-finger')
def view_cari_master_jam_finger():
    return cari_master_jam_finger()

@main.route('/master/cari/jam-kerja')
def view_cari_master_jam_kerja():
    return cari_master_jam_kerja()

@main.route('/master/cari/kalender')
def view_cari_master_kalender():
    return cari_master_kalender()

@main.route('/master/cari/potongan')
def view_cari_master_potongan():
    return cari_master_potongan()

@main.route('/master/cari/tunkin-class')
def view_cari_master_tunkin_class():
    return cari_master_tunkin_class()

@main.route('/master/cari/uang-makan')
def view_cari_master_uang_makan():
    return cari_master_uang_makan()

@main.route('/master/cari/unit-kerja')
def view_cari_master_unit_kerja():
    return cari_master_unit_kerja()

@main.route('/master/cari/user-account')
def view_cari_user_account():
    return cari_user_account()

# Create :
@main.route('/master/create/kalender')
def view_create_kalender():
    return create_kalender()

# Media Informasi :
@main.route('/media-informasi')
def view_media_informasi():
    return media_informasi()

@main.route('/media-informasi/detail')
def view_media_informasi_detail():
    return media_informasi_detail()