# controllers/mediaInformasiDashboard_1Controller.py
from flask import render_template, request

def media_informasi():
    """Render halaman Media Informasi."""
    return render_template('pages/dashboard_1/Media Informasi.html')

def media_informasi_detail():
    """Render halaman Detail Media Informasi."""
    return render_template('pages/dashboard_1/Media Informasi Slide JPG.html')