#  controllers/dashboard_1KepegawaianController.py
from flask import render_template, request, jsonify
from datetime import datetime
from app import db
from app.models.pegawaiModel import Pegawai
from app.models.unitKerjaModel import MfUnitKerja
from app.models.jabatanModel import MfJabatan
from app.models.golonganModel import MfGolongan
from app.models.eselonModel import MfEselon
from app.models.classModel import MfClass


def kepegawaian_cari_data_pegawai():
    """Render halaman Kepegawaian Cari Data Pegawai."""
    return render_template('pages/dashboard_1/Kepegawaian Cari Data Pegawai.html')


def kepegawaian_cari_dinas_luar_umum():
    """Render halaman Kepegawaian Cari Dinas Luar Umum."""
    return render_template('pages/dashboard_1/Kepegawaian Cari Dinas Luar Umum.html')


def kepegawaian_data_pegawai():
    """Render halaman Kepegawaian Data Pegawai."""
    unit_kerja_list = MfUnitKerja.query.order_by(MfUnitKerja.NAMA_UNIT_KERJA.asc()).all()
    jabatan_list = MfJabatan.query.filter(
        MfJabatan.NAMA_JABATAN.isnot(None)
    ).order_by(MfJabatan.URUT_JABATAN.asc()).all()
    golongan_list = MfGolongan.query.order_by(MfGolongan.URUT_GOL.asc()).all()
    eselon_list = MfEselon.query.order_by(MfEselon.URUT_ESELON.asc()).all()
    class_list = MfClass.query.order_by(MfClass.CLASS_ID.asc()).all()
    
    return render_template(
        'pages/dashboard_1/Kepegawaian Data Pegawai.html',
        unit_kerja_list=unit_kerja_list,
        jabatan_list=jabatan_list,
        golongan_list=golongan_list,
        eselon_list=eselon_list,
        class_list=class_list
    )


def _safe_int(value, default=None):
    """Helper: konversi ke int dengan aman"""
    try:
        if value is None or value == '':
            return default
        return int(value)
    except (ValueError, TypeError):
        return default


def _safe_date(value):
    """Helper: konversi string ke date dengan aman"""
    try:
        if value:
            return datetime.strptime(value, '%Y-%m-%d')
        return None
    except (ValueError, TypeError):
        return None


def api_pegawai_get():
    """API: Get data pegawai by NIP"""
    try:
        nip = request.args.get('nip', '').strip()
        
        if not nip:
            return jsonify({'error': 'NIP tidak boleh kosong'})
        
        pegawai = Pegawai.query.get(nip)
        
        if not pegawai:
            return jsonify({'error': 'Pegawai tidak ditemukan'})
        
        return jsonify({
            'success': True,
            'data': pegawai.to_dict()
        })
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def api_pegawai_save():
    """API: Simpan/Update data pegawai"""
    try:
        data = request.get_json()
        
        # Debug: lihat data yang masuk
        print("📥 Data diterima:", data)
        
        nip = data.get('nip', '').strip() if data.get('nip') else ''
        
        if not nip:
            return jsonify({'error': 'NIP tidak boleh kosong'})
        
        # Validasi wajib
        nama = data.get('nama', '').strip() if data.get('nama') else ''
        tgl_masuk = data.get('tgl_masuk', '')
        
        if not nama:
            return jsonify({'error': 'Nama tidak boleh kosong'})
        if not tgl_masuk:
            return jsonify({'error': 'Tanggal Masuk tidak boleh kosong'})
        
        # Cek existing
        pegawai = Pegawai.query.get(nip)
        is_update = pegawai is not None
        
        # Data umum
        unit_kerja_id = _safe_int(data.get('unit_kerja_id'), 1)
        jabatan_id = _safe_int(data.get('jabatan_id'), None)
        gol_id = _safe_int(data.get('gol_id'), None)
        eselon = data.get('eselon', '') or ''
        class_id = _safe_int(data.get('class_id'), None)
        alamat = data.get('alamat', '') or ''
        jenis_kel = data.get('jenis_kel', '') or ''
        tgl_lahir = _safe_date(data.get('tgl_lahir'))
        kelurahan = data.get('kelurahan', '') or ''
        kecamatan = data.get('kecamatan', '') or ''
        kota = data.get('kota', '') or ''
        no_telp = data.get('no_telp', '') or ''
        email = data.get('email', '') or ''
        tmt_pangkat = _safe_date(data.get('tmt_pangkat'))
        tmt_cpns = _safe_date(data.get('tmt_cpns'))
        tmt_pns = _safe_date(data.get('tmt_pns'))
        tmt_class = _safe_date(data.get('tmt_class'))
        tmt_jabatan = _safe_date(data.get('tmt_jabatan'))
        gol_recruit = data.get('gol_recruit', '') or ''
        status_peg = _safe_int(data.get('status_peg'), 2)
        is_keluar_val = data.get('is_keluar', 'N') or 'N'
        is_keluar = 1 if is_keluar_val == 'Y' else 0
        tgl_keluar = _safe_date(data.get('tgl_keluar'))
        alasan_keluar = data.get('alasan_keluar', '') or ''
        
        if is_update:
            # Update
            pegawai.NAMA = nama
            pegawai.UNIT_KERJA_ID = unit_kerja_id
            pegawai.JABATAN_ID = jabatan_id
            pegawai.GOL_ID = gol_id
            pegawai.ESELON = eselon
            pegawai.CLASS_ID = class_id
            pegawai.ALAMAT = alamat
            pegawai.JENIS_KEL = jenis_kel
            pegawai.TGL_LAHIR = tgl_lahir
            pegawai.KELURAHAN = kelurahan
            pegawai.KECAMATAN = kecamatan
            pegawai.KOTA = kota
            pegawai.NO_TELP = no_telp
            pegawai.MAIL = email
            pegawai.TGL_MASUK = _safe_date(tgl_masuk)
            pegawai.TMT_PANGKAT = tmt_pangkat
            pegawai.TMT_CPNS = tmt_cpns
            pegawai.TMT_PNS = tmt_pns
            pegawai.TMT_CLASS = tmt_class
            pegawai.TMT_JABATAN = tmt_jabatan
            pegawai.GOL_RECRUIT = gol_recruit
            pegawai.STATUS_PEG = status_peg
            pegawai.IS_KELUAR = is_keluar
            pegawai.TGL_KELUAR = tgl_keluar
            pegawai.ALASAN_KELUAR = alasan_keluar
            pegawai.UPDATE_IN_BY = 'admin'
            pegawai.UPDATE_DATE = datetime.now()
            
            db.session.commit()
            
            return jsonify({'success': True, 'message': 'Data pegawai berhasil diupdate'})
        else:
            # Insert
            new_pegawai = Pegawai(
                NIP=nip,
                NAMA=nama,
                UNIT_KERJA_ID=unit_kerja_id,
                JABATAN_ID=jabatan_id,
                GOL_ID=gol_id,
                ESELON=eselon,
                CLASS_ID=class_id,
                ABSENSI_ID=1,
                TUNJANGAN_ID=1,
                NO_TELP=no_telp,
                MAIL=email,
                PASS='surabaya-02',
                ALAMAT=alamat,
                JENIS_KEL=jenis_kel,
                TGL_LAHIR=tgl_lahir,
                KELURAHAN=kelurahan,
                KECAMATAN=kecamatan,
                KOTA=kota,
                TGL_MASUK=_safe_date(tgl_masuk),
                TMT_PANGKAT=tmt_pangkat,
                TMT_CPNS=tmt_cpns,
                TMT_PNS=tmt_pns,
                TMT_CLASS=tmt_class,
                TMT_JABATAN=tmt_jabatan,
                GOL_RECRUIT=gol_recruit,
                STATUS_PEG=status_peg,
                IS_KELUAR=is_keluar,
                TGL_KELUAR=tgl_keluar,
                ALASAN_KELUAR=alasan_keluar,
                UPDATE_IN_BY='admin',
                UPDATE_DATE=datetime.now()
            )
            db.session.add(new_pegawai)
            db.session.commit()
            
            return jsonify({'success': True, 'message': 'Data pegawai berhasil disimpan'})
        
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def api_pegawai_delete():
    """API: Delete pegawai"""
    try:
        data = request.get_json()
        nip = data.get('nip', '').strip() if data.get('nip') else ''
        
        if not nip:
            return jsonify({'error': 'NIP tidak boleh kosong'})
        
        Pegawai.query.filter(Pegawai.NIP == nip).delete()
        db.session.commit()
        
        return jsonify({'success': True, 'message': 'Data pegawai berhasil dihapus'})
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)})


def kepegawaian_dinas_luar_operasi():
    """
    Render halaman Kepegawaian Dinas Luar Operasi.
    """
    return render_template('pages/dashboard_1/Kepegawaian Dinas Luar Operasi.html')


def kepegawaian_dinas_luar_pelatihan():
    """
    Render halaman Kepegawaian Dinas Luar Pelatihan.
    """
    return render_template('pages/dashboard_1/Kepegawaian Dinas Luar Pelatihan.html')


def kepegawaian_dinas_luar_umum():
    """
    Render halaman Kepegawaian Dinas Luar Umum.
    """
    return render_template('pages/dashboard_1/Kepegawaian Dinas Luar Umum.html')


def kepegawaian_mutasi_penempatan_pegawai():
    """
    Render halaman Kepegawaian Mutasi Penempatan Pegawai.
    """
    return render_template('pages/dashboard_1/Kepegawaian Mutasi Penempatan Pegawai.html')


def kepegawaian_pegawai_cuti():
    """
    Render halaman Kepegawaian Pegawai Cuti.
    """
    return render_template('pages/dashboard_1/Kepegawaian Pegawai Cuti.html')


def kepegawaian_pegawai_sakit():
    """
    Render halaman Kepegawaian Pegawai Sakit.
    """
    return render_template('pages/dashboard_1/Kepegawaian Pegawai Sakit.html')


def kepegawaian_pegawai_tidak_hadir():
    """
    Render halaman Kepegawaian Pegawai Tidak Hadir.
    """
    return render_template('pages/dashboard_1/Kepegawaian Pegawai Tidak Hadir.html')


def kepegawaian_update_pendukung():
    """
    Render halaman Kepegawaian Update Pendukung.
    """
    return render_template('pages/dashboard_1/Kepegawaian Update Pendukung.html')