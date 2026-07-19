# app/routes/routes.py

from flask import Blueprint, jsonify
from app.utils.decorators import login_required
from app.controllers.dashboard_1HomeController import (
    dashboard_kgb, dashboard_pangkat, dashboard_pelanggaran, dashboard_pensiun, dashboard_trt)
from app.controllers.dashboard_1MasterFileController import (
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
from app.controllers.dashboard_2DataSiagaController import (
    data_siaga_absensi_kehadiran,
    data_siaga_cetak_daftar_lembur_siaga,
    data_siaga_cetak_rekap_siaga,
    data_siaga_cetak_uang_siaga,
    data_siaga_jadwal_ulang,
    data_siaga_membuat_jadwal_piket_siaga,
)
from app.controllers.dashboard_2MasterDataController import (
    master_data_email_broadcast,
    master_data_kgr,
    master_data_nominal_ut_piket,
    master_data_tim_siaga,
    master_data_user_account,
)
from app.controllers.dashboard_2OtoritasPersetujuanController import (
    otorisasi_persetujuan_kepala_kantor,
    otorisasi_persetujuan_kepala_seksi_operasi,
)
from app.controllers.homeController import get_pelanggaran_disiplin, get_piket_siaga, home, search_buku_telp
from app.controllers.loginController import login, logout
from app.controllers.dashboard_1MediaInformasiController import (
    media_informasi, media_informasi_detail,
    save_media_informasi, save_media_informasi_slide,
    get_media_informasi_list, get_media_informasi_by_id,
    update_media_informasi, nonaktifkan_media_informasi
)

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
@login_required
def view_dashboard_pelanggaran():
    return dashboard_pelanggaran()

@main.route('/dashboard/pensiun')
@login_required
def view_dashboard_pensiun():
    return dashboard_pensiun()

@main.route('/dashboard/pangkat')
@login_required
def view_dashboard_pangkat():
    return dashboard_pangkat()

@main.route('/dashboard/kgb')
@login_required
def view_dashboard_kgb():
    return dashboard_kgb()

@main.route('/dashboard/trt')
@login_required
def view_dashboard_trt():
    return dashboard_trt()

# Master File :
@main.route('/master/butir-kegiatan')
@login_required
def view_master_butir_kegiatan():
    return master_butir_kegiatan()

@main.route('/master/jabatan')
@login_required
def view_master_jabatan():
    return master_jabatan()

@main.route('/master/jam-finger')
@login_required
def view_master_jam_finger():
    return master_jam_finger()

@main.route('/master/jam-kerja')
@login_required
def view_master_jam_kerja():
    return master_jam_kerja()

@main.route('/master/kalender')
@login_required
def view_master_kalender():
    return master_kalender()

@main.route('/master/pegawai-vip')
@login_required
def view_master_pegawai_vip():
    return master_pegawai_vip()

@main.route('/master/potongan')
@login_required
def view_master_potongan():
    return master_potongan()

@main.route('/master/trt')
@login_required
def view_master_trt():
    return master_file_trt()

@main.route('/master/tunkin-class')
@login_required
def view_master_tunkin_class():
    return master_tunkin_class()

@main.route('/master/unit-kerja')
@login_required
def view_master_unit_kerja():
    return master_unit_kerja()

@main.route('/master/user')
@login_required
def view_master_user():
    return master_user()

@main.route('/master/uang-makan')
@login_required
def view_master_uang_makan():
    return master_uang_makan()

# Cari Master :
@main.route('/master/cari/jabatan')
@login_required
def view_cari_master_jabatan():
    return cari_master_jabatan()

@main.route('/master/cari/jam-finger')
@login_required
def view_cari_master_jam_finger():
    return cari_master_jam_finger()

@main.route('/master/cari/jam-kerja')
@login_required
def view_cari_master_jam_kerja():
    return cari_master_jam_kerja()

@main.route('/master/cari/kalender')
@login_required
def view_cari_master_kalender():
    return cari_master_kalender()

@main.route('/master/cari/potongan')
@login_required
def view_cari_master_potongan():
    return cari_master_potongan()

@main.route('/master/cari/tunkin-class')
@login_required
def view_cari_master_tunkin_class():
    return cari_master_tunkin_class()

@main.route('/master/cari/uang-makan')
@login_required
def view_cari_master_uang_makan():
    return cari_master_uang_makan()

@main.route('/master/cari/unit-kerja')
@login_required
def view_cari_master_unit_kerja():
    return cari_master_unit_kerja()

@main.route('/master/cari/user-account')
@login_required
def view_cari_user_account():
    return cari_user_account()

# Create :
@main.route('/master/create/kalender')
@login_required
def view_create_kalender():
    return create_kalender()

# Media Informasi :
@main.route('/media-informasi')
@login_required
def view_media_informasi():
    return media_informasi()

@main.route('/api/media-informasi', methods=['POST'])
@login_required
def api_save_media_informasi():
    return save_media_informasi()

@main.route('/api/media-informasi/slide', methods=['POST'])
@login_required
def api_save_media_informasi_slide():
    return save_media_informasi_slide()

@main.route('/api/media-informasi/list', methods=['GET'])
@login_required
def api_get_media_informasi_list():
    return get_media_informasi_list()

@main.route('/api/media-informasi/<int:med_infor_id>', methods=['GET'])
@login_required
def api_get_media_informasi_by_id(med_infor_id):
    return get_media_informasi_by_id(med_infor_id)

@main.route('/api/media-informasi/<int:med_infor_id>', methods=['PUT'])
@login_required
def api_update_media_informasi(med_infor_id):
    return update_media_informasi(med_infor_id)

@main.route('/api/media-informasi/<int:med_infor_id>/nonaktif', methods=['POST'])
@login_required
def api_nonaktifkan_media_informasi(med_infor_id):
    return nonaktifkan_media_informasi(med_infor_id)

@main.route('/media-informasi/detail')
@login_required
def view_media_informasi_detail():
    return media_informasi_detail()

# ---- Dashboard 2 Routes ----
# Data Siaga:
@main.route('/siaga/absensi-kehadiran')
@login_required
def view_data_siaga_absensi_kehadiran():
    return data_siaga_absensi_kehadiran()

@main.route('/siaga/cetak-daftar-lembur')
@login_required
def view_data_siaga_cetak_daftar_lembur_siaga():
    return data_siaga_cetak_daftar_lembur_siaga()

@main.route('/siaga/cetak-rekap')
@login_required
def view_data_siaga_cetak_rekap_siaga():
    return data_siaga_cetak_rekap_siaga()

@main.route('/siaga/cetak-uang-siaga')
@login_required
def view_data_siaga_cetak_uang_siaga():
    return data_siaga_cetak_uang_siaga()

@main.route('/siaga/jadwal-ulang')
@login_required
def view_data_siaga_jadwal_ulang():
    return data_siaga_jadwal_ulang()

@main.route('/siaga/buat-jadwal-piket')
@login_required
def view_data_siaga_membuat_jadwal_piket_siaga():
    return data_siaga_membuat_jadwal_piket_siaga()

# Master Data:
@main.route('/siaga/master-data/email-broadcast')
@login_required
def view_master_data_email_broadcast():
    return master_data_email_broadcast()

@main.route('/siaga/master-data/kgr')
@login_required
def view_master_data_kgr():
    return master_data_kgr()

@main.route('/siaga/master-data/nominal-ut-piket')
@login_required
def view_master_data_nominal_ut_piket():
    return master_data_nominal_ut_piket()

@main.route('/siaga/master-data/tim-siaga')
@login_required
def view_master_data_tim_siaga():
    return master_data_tim_siaga()

@main.route('/siaga/master-data/user-account')
@login_required
def view_master_data_user_account():
    return master_data_user_account()

# Otorisasi Persetujuan:
@main.route('/siaga/otorisasi/kepala-kantor')
@login_required
def view_otorisasi_persetujuan_kepala_kantor():
    return otorisasi_persetujuan_kepala_kantor()

@main.route('/siaga/otorisasi/kepala-seksi-operasi')
@login_required
def view_otorisasi_persetujuan_kepala_seksi_operasi():
    return otorisasi_persetujuan_kepala_seksi_operasi()