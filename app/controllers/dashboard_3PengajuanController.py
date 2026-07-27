# controllers/dashboard_3PengajuanController.py
from flask import render_template, request


def pengajuan_skp():
    """Render halaman Pengajuan SKP."""
    return render_template('pages/dashboard_3/Pengajuan_SKP.html')


def pengajuan_absensi():
    """Render halaman Pengajuan Absensi."""
    return render_template('pages/dashboard_3/Pengajuan_Absensi.html')