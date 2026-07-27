# controllers/dashboard_3KirimController.py
from flask import render_template, request


def kirim_kritik_saran():
    """Render halaman Kirim - Kritik & Saran."""
    return render_template('pages/dashboard_3/Kirim_Kritik_Saran.html')


def kirim_forum_media_informasi():
    """Render halaman Kirim - Forum Media Informasi (FJB)."""
    return render_template('pages/dashboard_3/Kirim_Forum_Media_Informasi.html')