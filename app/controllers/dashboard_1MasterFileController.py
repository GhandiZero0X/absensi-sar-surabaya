# controllers/dashboard_1MasterFileController.py
from flask import render_template, request

def master_butir_kegiatan():
    """Render halaman Master File Butir Kegiatan."""
    return render_template('pages/dashboard_1/Master File Butir Kegiatan.html')

def master_jabatan():
    """Render halaman Master File Master Jabatan."""
    return render_template('pages/dashboard_1/Master File Master Jabatan.html')

def master_jam_finger():
    """Render halaman Master File Master Jam Finger."""
    return render_template('pages/dashboard_1/Master File Master Jam Finger.html')

def master_jam_kerja():
    """Render halaman Master File Master Jam Kerja."""
    return render_template('pages/dashboard_1/Master File Master Jam Kerja.html')

def master_kalender():
    """Render halaman Master File Master Kalender."""
    return render_template('pages/dashboard_1/Master File Master Kalender.html')

def master_pegawai_vip():
    """Render halaman Master File Master Pegawai VIP."""
    return render_template('pages/dashboard_1/Master File Master Pegawai VIP.html')

def master_potongan():
    """Render halaman Master File Master Potongan."""
    return render_template('pages/dashboard_1/Master File Master Potongan.html')

def master_trt():
    """Render halaman Master File Master TRT."""
    return render_template('pages/dashboard_1/Master File Master TRT.html')

def master_tunkin_class():
    """Render halaman Master File Master Tunkin Class."""
    return render_template('pages/dashboard_1/Master File Master Tunkin Class.html')

def master_unit_kerja():
    """Render halaman Master File Master Unit Kerja."""
    return render_template('pages/dashboard_1/Master File Master Unit Kerja.html')

def master_user():
    """Render halaman Master File Master User."""
    return render_template('pages/dashboard_1/Master File Master User.html')

def master_uang_makan():
    """Render halaman Master File Uang Makan."""
    return render_template('pages/dashboard_1/Master File Uang Makan.html')

# ---- Cari Master (pencarian) ----
def cari_master_jabatan():
    """Render halaman Cari Master Jabatan."""
    return render_template('pages/dashboard_1/Cari Master Jabatan.html')

def cari_master_jam_finger():
    """Render halaman Cari Master Jam Finger."""
    return render_template('pages/dashboard_1/Cari Master Jam Finger.html')

def cari_master_jam_kerja():
    """Render halaman Cari Master Jam Kerja."""
    return render_template('pages/dashboard_1/Cari Master Jam Kerja.html')

def cari_master_kalender():
    """Render halaman Cari Master Kalender."""
    return render_template('pages/dashboard_1/Cari Master Kalender.html')

def cari_master_potongan():
    """Render halaman Cari Master Potongan."""
    return render_template('pages/dashboard_1/Cari Master Potongan.html')

def cari_master_tunkin_class():
    """Render halaman Cari Master Tunkin Class."""
    return render_template('pages/dashboard_1/Cari Master Tunkin Class.html')

def cari_master_uang_makan():
    """Render halaman Cari Master Uang Makan."""
    return render_template('pages/dashboard_1/Cari Master Uang Makan.html')

def cari_master_unit_kerja():
    """Render halaman Cari Master Unit Kerja."""
    return render_template('pages/dashboard_1/Cari Master Unit Kerja.html')

def cari_user_account():
    """Render halaman Cari User Account."""
    return render_template('pages/dashboard_1/Cari User Account.html')


# ---- Create ----
def create_kalender():
    """Render halaman Create Kalender."""
    return render_template('pages/dashboard_1/Create Kalender.html')