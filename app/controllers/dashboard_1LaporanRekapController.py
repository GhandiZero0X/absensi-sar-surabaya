# controllers/dashboard_1LaporanRekapController.py
from flask import render_template, request


def laporan_cetak_daftar_lembur_umum():
    """
    Render halaman Laporan Cetak Daftar Lembur Umum.
    """
    return render_template('pages/dashboard_1/Laporan Cetak Daftar Lembur Umum.html')


def laporan_rekap_absensi_all():
    """
    Render halaman Laporan Rekap Absensi All.
    """
    return render_template('pages/dashboard_1/Laporan Rekap Absensi All.html')


def laporan_rekap_absensi_individu():
    """
    Render halaman Laporan Rekap Absensi Individu.
    """
    return render_template('pages/dashboard_1/Laporan Rekap Absensi Individu.html')


def laporan_rekap_absensi_log_finger():
    """
    Render halaman Laporan Rekap Absensi Log Finger.
    """
    return render_template('pages/dashboard_1/Laporan Rekap Absensi Log Finger.html')


def laporan_rekap_clock_exception():
    """
    Render halaman Laporan Rekap Clock Exception.
    """
    return render_template('pages/dashboard_1/Laporan Rekap Clock Exception.html')


def laporan_rekap_ketidakhadiran_pegawai():
    """
    Render halaman Laporan Rekap Ketidakhadiran Pegawai.
    """
    return render_template('pages/dashboard_1/Laporan Rekap Ketidakhadiran Pegawai.html')


def laporan_rekap_pelanggaran_disiplin():
    """
    Render halaman Laporan Rekap Pelanggaran Disiplin.
    Catatan: logika dasarnya kemungkinan mirip _get_data_pelanggaran() di
    dashboard_1HomeController.py, tapi dalam bentuk laporan rekap (bisa filter periode).
    """
    return render_template('pages/dashboard_1/Laporan Rekap Pelanggaran Disiplin.html')


def laporan_rekap_uang_makan():
    """
    Render halaman Laporan Rekap Uang Makan.
    """
    return render_template('pages/dashboard_1/Laporan Rekap Uang Makan.html')

def laporan_rekap_tunjangan_kinerja():
    """
    Render halaman Laporan Rekap Tunjangan Kinerja.
    """
    return render_template('pages/dashboard_1/Laporan Rincian Pembayaran Tunjangan.html')