# controllers/dashboard_2DataSiagaController.py
from flask import render_template, request

def data_siaga_absensi_kehadiran():
    """Render halaman Data Siaga Absensi Kehadiran."""
    return render_template('pages/dashboard_2/Data_Siaga_Absensi_Kehadiran.html')

def data_siaga_cetak_daftar_lembur_siaga():
    """Render halaman Data Siaga Cetak Daftar Lembur Siaga."""
    return render_template('pages/dashboard_2/Data_Siaga_Cetak_Daftar_Lembur_Siaga.html')

def data_siaga_cetak_rekap_siaga():
    """Render halaman Data Siaga Cetak Rekap Siaga."""
    return render_template('pages/dashboard_2/Data_Siaga_Cetak_Rekap_Siaga.html')

def data_siaga_cetak_uang_siaga():
    """Render halaman Data Siaga Cetak Uang Siaga."""
    return render_template('pages/dashboard_2/Data_Siaga_Cetak_Uang_Siaga.html')

def data_siaga_jadwal_ulang():
    """Render halaman Data Siaga Jadwal Ulang."""
    return render_template('pages/dashboard_2/Data_Siaga_Jadwal_Ulang.html')

def data_siaga_membuat_jadwal_piket_siaga():
    """Render halaman Data Siaga Membuat Jadwal Piket Siaga."""
    return render_template('pages/dashboard_2/Data_Siaga_Membuat_Jadwal_Piket_Siaga.html')