# controllers/dashboard_1DataAbsensiController.py
from flask import render_template, request


def data_absensi_non_finger():
    """
    Render halaman Data Absensi Non Finger.
    TODO: lengkapi query data absensi non-finger setelah model terkait dikirim.
    """
    return render_template('pages/dashboard_1/Data Absensi Non Finger.html')


def data_absensi_normalisasi_finger():
    """
    Render halaman Data Absensi Normalisasi Absensi Finger.
    TODO: lengkapi query/proses normalisasi log finger setelah model terkait dikirim.
    """
    return render_template('pages/dashboard_1/Data Absensi Normalisasi Absensi Finger.html')


def data_absensi_pegawai_manual():
    """
    Render halaman Data Absensi Pegawai Absensi Manual.
    """
    return render_template('pages/dashboard_1/Data Absensi Pegawai Absensi Manual.html')


def data_absensi_pegawai_lembur_manual():
    """
    Render halaman Data Absensi Pegawai Lembur Manual.
    """
    return render_template('pages/dashboard_1/Data Absensi Pegawai Lembur Manual.html')


def data_absensi_trace_tunjangan():
    """
    Render halaman Data Absensi Trace Tunjangan.
    """
    return render_template('pages/dashboard_1/Data Absensi Trace Tunjangan.html')


def data_absensi_trace():
    """
    Render halaman Data Absensi Trace.
    """
    return render_template('pages/dashboard_1/Data Absensi Trace.html')


# ---- Cari Absensi (pencarian) ----

def cari_absensi_non_finger():
    """
    Render halaman Cari Absensi Non Finger.
    """
    return render_template('pages/dashboard_1/Cari Absensi Non Finger.html')


def cari_absensi_normalisasi_finger():
    """
    Render halaman Cari Absensi Normalisasi Absensi Finger.
    """
    return render_template('pages/dashboard_1/Cari Absensi Normalisasi Absensi Finger.html')


def cari_absensi_pegawai_manual():
    """
    Render halaman Cari Absensi Pegawai Absen Manual.
    """
    return render_template('pages/dashboard_1/Cari Absensi Pegawai Absen Manual.html')


def cari_absensi_pegawai_lembur_manual():
    """
    Render halaman Cari Absensi Pegawai Lembur Manual.
    """
    return render_template('pages/dashboard_1/Cari Absensi Pegawai Lembur Manual.html')