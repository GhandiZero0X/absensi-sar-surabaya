# controllers/dashboard_2OtoritasPersetujuanController.py
from flask import render_template, request

def otorisasi_persetujuan_kepala_kantor():
    """Render halaman Otorisasi Persetujuan Kepala Kantor."""
    # PERHATIKAN: nama file punya spasi sebelum "_Kepala" — harus sama persis dgn file di disk.
    return render_template('pages/dashboard_2/Otorisasi_Persetujuan _Kepala_Kantor.html')

def otorisasi_persetujuan_kepala_seksi_operasi():
    """Render halaman Otorisasi Persetujuan Kepala Seksi Operasi."""
    return render_template('pages/dashboard_2/Otorisasi_Persetujuan_Kepala_Seksi_Operasi.html')