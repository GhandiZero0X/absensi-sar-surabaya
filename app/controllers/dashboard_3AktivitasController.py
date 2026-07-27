# controllers/dashboard_3AktivitasController.py
from flask import render_template, request


def aktifitasku_dashboard():
    """Render halaman Aktifitasku Dashboard."""
    return render_template('pages/dashboard_3/Aktifitasku_Dashboard.html')


def aktifitasku_buku_harian():
    """Render halaman Aktifitasku Buku Harian."""
    return render_template('pages/dashboard_3/Aktifitasku_Buku_Harian.html')


def aktifitasku_buku_harian_baru_utama():
    """
    Render halaman form tambah Buku Harian - Utama.
    """
    return render_template('pages/dashboard_3/Aktifitasku_Buku_Harian_Baru_Utama.html')


def aktifitasku_buku_harian_baru_tambahan():
    """
    Render halaman form tambah Buku Harian - Tambahan.
    """
    return render_template('pages/dashboard_3/Aktifitasku_Buku_Harian_Baru_Tambahan.html')


def aktifitasku_buku_harian_baru_penunjang():
    """
    Render halaman form tambah Buku Harian - Penunjang.
    """
    return render_template('pages/dashboard_3/Aktifitasku_Buku_Harian_Baru_Penunjang.html')


def aktifitasku_dupak():
    """Render halaman Aktifitasku Dupak."""
    return render_template('pages/dashboard_3/Aktifitasku_Dupak.html')


def aktifitasku_skp():
    """Render halaman Aktifitasku SKP."""
    return render_template('pages/dashboard_3/Aktifitasku_SKP.html')


def aktifitasku_jadwal_piket():
    """Render halaman Aktifitasku Jadwal Piket (Jadwal Siaga)."""
    return render_template('pages/dashboard_3/Aktifitasku_Jadwal_Piket.html')


def aktifitasku_dinas_luar():
    """Render halaman Aktifitasku Dinas Luar."""
    return render_template('pages/dashboard_3/Aktifitasku_Dinas_Luar.html')


def aktifitasku_update_pendukung():
    """Render halaman Aktifitasku Update Pendukung."""
    return render_template('pages/dashboard_3/Aktifitasku_Update_Pendukung.html')