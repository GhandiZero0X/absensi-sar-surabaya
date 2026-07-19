# controllers/dashboard_1HomeController.py
from flask import render_template, request

def dashboard_pelanggaran():
    """Render halaman Dashboard Pelanggaran."""
    return render_template('pages/dashboard_1/Dashboard Pelanggaran.html')

def dashboard_pensiun():
    """Render halaman Dashboard Pensiun."""
    return render_template('pages/dashboard_1/Dashboard Pensiun.html')


def dashboard_pangkat():
    """Render halaman Dashboard Pangkat."""
    return render_template('pages/dashboard_1/Dashboard Pangkat.html')


def dashboard_kgb():
    """Render halaman Dashboard KGB."""
    return render_template('pages/dashboard_1/Dashboard KGB.html')


def dashboard_trt():
    """Render halaman Dashboard TRT."""
    return render_template('pages/dashboard_1/Dashboard TRT.html')