# controllers/dashboard_3BenefitController.py
from flask import render_template, request


def benefit_tunjangan_kinerja():
    """Render halaman Benefit - Tunjangan Kinerja."""
    return render_template('pages/dashboard_3/Benefit_Tunjangan_Kinerja.html')


def benefit_rekap_uang_makan():
    """Render halaman Benefit - Rekap Uang Makan."""
    return render_template('pages/dashboard_3/Benefit_Rekap_Uang_Makan.html')