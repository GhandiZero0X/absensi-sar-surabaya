# controllers/dashboard_3ProfileController.py
from flask import render_template, request


def profile():
    """Render halaman Profile (Pribadi)."""
    return render_template('pages/dashboard_3/Profile.html')