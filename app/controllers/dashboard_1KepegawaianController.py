#  controllers/dashboard_1KepegawaianController.py
from operator import and_
import uuid

from flask import render_template, request, jsonify
from datetime import datetime
from datetime import timedelta

from sqlalchemy import or_
from app import db
from app.models.pegawaiModel import Pegawai
from app.models.sprinHeaderModel import SprinHeader
from app.models.unitKerjaModel import MfUnitKerja
from app.models.jabatanModel import MfJabatan
from app.models.golonganModel import MfGolongan
from app.models.eselonModel import MfEselon
from app.models.classModel import MfClass
from app.models.dinasLuarModel import DinasLuar
from app.models.absensiModel import Absensi
from app.models.kalenderModel import MfKalender
from app.models.mediaInformasiModel import MediaInformasi
from app.models.emailSendModel import MfEmailSend


def kepegawaian_cari_data_pegawai():
    """Render halaman Kepegawaian Cari Data Pegawai."""
    return render_template('pages/dashboard_1/Kepegawaian Cari Data Pegawai.html')

def api_pegawai_cari():
    """
    API: Cari data pegawai dengan filter
    Mirip dengan BtnRefresh_Click di VB.NET
    """
    try:
        # Get parameter filter
        filter_field1 = request.args.get('filter_field1', '')
        filter_value1 = request.args.get('filter_value1', '')
        filter_field2 = request.args.get('filter_field2', '')
        filter_value2 = request.args.get('filter_value2', '')
        status_pegawai = request.args.get('status_pegawai', 'aktif')  # aktif/keluar
        status_jenis = request.args.get('status_jenis', 'pns')  # pns/non_pns
        
        # Base query
        query = (
            db.session.query(
                Pegawai,
                MfUnitKerja,
                MfGolongan,
                MfJabatan
            )
            .outerjoin(MfUnitKerja, Pegawai.UNIT_KERJA_ID == MfUnitKerja.UNIT_KERJA_ID)
            .outerjoin(MfGolongan, Pegawai.GOL_ID == MfGolongan.GOL_ID)
            .outerjoin(MfJabatan, Pegawai.JABATAN_ID == MfJabatan.JABATAN_ID)
        )
        
        # Filter status pegawai (aktif/keluar)
        if status_pegawai == 'aktif':
            query = query.filter(Pegawai.IS_KELUAR == 0)
        else:
            query = query.filter(Pegawai.IS_KELUAR == 1)
        
        # Filter status jenis (PNS/NON PNS)
        if status_jenis == 'pns':
            query = query.filter(Pegawai.STATUS_PEG == 1)
        else:
            query = query.filter(Pegawai.STATUS_PEG == 2)
        
        # Field mapping untuk filter
        field_mapping = {
            'NIP': Pegawai.NIP,
            'Nama Peg': Pegawai.NAMA,
            'Gol': MfGolongan.NAMA_GOL,
            'Jabatan': MfJabatan.NAMA_JABATAN,
            'Unit Kerja': MfUnitKerja.NAMA_UNIT_KERJA,
            'Jenis Kelamin': Pegawai.JENIS_KEL,
        }
        
        # Filter 1
        if filter_field1 and filter_value1:
            field = field_mapping.get(filter_field1)
            if field is not None:
                query = query.filter(field.ilike(f'%{filter_value1}%'))
        
        # Filter 2
        if filter_field2 and filter_value2:
            field = field_mapping.get(filter_field2)
            if field is not None:
                query = query.filter(field.ilike(f'%{filter_value2}%'))
        
        # Order
        query = query.order_by(
            MfJabatan.URUT_JABATAN.asc(),
            MfGolongan.URUT_GOL.asc(),
            Pegawai.NIP.asc()
        )
        
        results = query.limit(500).all()
        
        # Format data
        data = []
        for i, (peg, unit, gol, jab) in enumerate(results, 1):
            # Keterangan
            keterangan = ''
            if peg.IS_KELUAR == 1:
                tgl = peg.TGL_KELUAR.strftime('%Y.%m.%d') if peg.TGL_KELUAR else ''
                keterangan = f"Tanggal keluar {tgl} {peg.ALASAN_KELUAR or ''}"
            
            data.append({
                'no': i,
                'nip': peg.NIP,
                'nama': peg.NAMA or '',
                'gol_pangkat': f"{gol.NAMA_GOL or ''} - {gol.PANGKAT_GOL or ''}" if gol else '-',
                'unit_kerja': unit.NAMA_UNIT_KERJA if unit else '-',
                'jabatan': jab.NAMA_JABATAN if jab else '-',
                'status_peg': 'PNS' if peg.STATUS_PEG == 1 else 'NON PNS',
                'keterangan': keterangan,
            })
        
        return jsonify({
            'success': True,
            'data': data,
            'total': len(data)
        })
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e), 'data': []})


def api_pegawai_get_filter_fields():
    """API: Get list field untuk filter dropdown"""
    try:
        fields = [
            {'field_id': 'NIP', 'field_name': 'NIP'},
            {'field_id': 'Nama Peg', 'field_name': 'Nama Peg'},
            {'field_id': 'Gol', 'field_name': 'Gol'},
            {'field_id': 'Jabatan', 'field_name': 'Jabatan'},
            {'field_id': 'Unit Kerja', 'field_name': 'Unit Kerja'},
            {'field_id': 'Jenis Kelamin', 'field_name': 'Jenis Kelamin'},
        ]
        
        return jsonify({
            'success': True,
            'data': fields
        })
    except Exception as e:
        return jsonify({'error': str(e), 'data': []})


def kepegawaian_cari_dinas_luar_umum():
    """Render halaman Kepegawaian Cari Dinas Luar Umum."""
    return render_template('pages/dashboard_1/Kepegawaian Cari Dinas Luar Umum.html')

def api_dinas_luar_cari():
    """
    API: Cari data Dinas Luar (Umum & Operasi)
    """
    try:
        filter_field1 = request.args.get('filter_field1', '')
        filter_value1 = request.args.get('filter_value1', '')
        filter_field2 = request.args.get('filter_field2', '')
        filter_value2 = request.args.get('filter_value2', '')
        periode = request.args.get('periode', '')
        periode_type = request.args.get('periode_type', 'bulan')
        type_sprin = request.args.get('type_sprin', 'DL')  # ✅ Filter by type
        
        # Base query - filter by TYPE_SPRIN_ID
        query = SprinHeader.query.filter(SprinHeader.TYPE_SPRIN_ID == type_sprin)
        
        # ... (sisa filter sama)
        
        # Order
        query = query.order_by(SprinHeader.TGL_AWAL_SPRIN.desc())
        
        results = query.limit(500).all()
        
        # Format data
        data = []
        for i, sprin in enumerate(results, 1):
            update_by_name = ''
            if sprin.UPDATE_BY:
                peg = Pegawai.query.get(sprin.UPDATE_BY)
                update_by_name = peg.NAMA if peg else sprin.UPDATE_BY
            
            update_date_str = sprin.UPDATE_DATE.strftime('%d-%b-%Y') if sprin.UPDATE_DATE else ''
            tgl_awal = sprin.TGL_AWAL_SPRIN.strftime('%d-%b-%Y') if sprin.TGL_AWAL_SPRIN else '-'
            tgl_akhir = sprin.TGL_SPRIN.strftime('%d-%b-%Y') if sprin.TGL_SPRIN else '-'
            
            # Tentukan jenis berdasarkan TYPE_SPRIN_ID
            jenis = 'Umum' if sprin.TYPE_SPRIN_ID == 'DL' else (
                'Operasi' if sprin.TYPE_SPRIN_ID == 'OPR' else 'Potensi'
            )
            
            data.append({
                'no': i,
                'no_surat': sprin.NO_SPRIN or '-',
                'tgl_sprin': f"{tgl_awal} - {tgl_akhir}",
                'keterangan': sprin.PERIHAL_SPRIN or '-',
                'penempatan': sprin.PENEMPATAN or '-',
                'update_by': f"{update_by_name} - {update_date_str}" if update_by_name else '-',
                'guid_sprin': sprin.GUID_SPRIN,
                'jenis': jenis,  # ✅ Tambahkan info jenis
            })
        
        return jsonify({
            'success': True,
            'data': data,
            'total': len(data)
        })
        
    except Exception as e:
        import traceback
        print("❌ ERROR in api_dinas_luar_cari:")
        traceback.print_exc()
        return jsonify({'error': str(e), 'data': [], 'success': False})


def api_dinas_luar_get_filter_fields():
    """API: Get list field untuk filter dropdown"""
    try:
        fields = [
            {'field_id': 'KeteranganDinasLuar', 'field_name': 'Keterangan'},
            {'field_id': 'PenempatanDinasLuar', 'field_name': 'Penempatan'},
            {'field_id': 'NoSurat', 'field_name': 'No. Surat'},
            {'field_id': 'NamaFile', 'field_name': 'Nama File (Y/N)'},
        ]
        return jsonify({'success': True, 'data': fields})
    except Exception as e:
        return jsonify({'error': str(e), 'data': []})


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

def api_dinas_luar_operasi_save():
    """
    API: Simpan Dinas Luar Operasi
    Logic: Header dulu, baru peserta (seperti Dinas Luar Umum)
    """
    try:
        data = request.get_json()
        print("📥 Data Dinas Luar Operasi:", data)
        
        no_surat = data.get('no_surat', '').strip()
        tgl_awal_surat = data.get('tgl_awal_surat', '')
        tgl_akhir_surat = data.get('tgl_akhir_surat', '')
        keterangan = data.get('keterangan', '')
        penempatan = data.get('penempatan', '')
        jenis_operasi = data.get('jenis_operasi', True)
        status_um = data.get('status_um', '1')
        peserta_list = data.get('peserta', [])
        nama_file = data.get('nama_file', '-')
        is_update = data.get('is_update', False)
        guid_sprin_existing = data.get('guid_sprin', '')
        save_header_only = data.get('save_header_only', False)
        
        if not no_surat:
            return jsonify({'success': False, 'error': 'No. Surat tidak boleh kosong'})
        if not tgl_awal_surat or not tgl_akhir_surat:
            return jsonify({'success': False, 'error': 'Tanggal Surat tidak boleh kosong'})
        
        # STEP 1: Simpan/Cari SPRIN_HEADER dulu
        if guid_sprin_existing:
            existing_sprin = SprinHeader.query.get(guid_sprin_existing)
            if existing_sprin:
                guid_sprin = guid_sprin_existing
                # Update header
                existing_sprin.NO_SPRIN = no_surat
                existing_sprin.TGL_AWAL_SPRIN = datetime.strptime(tgl_awal_surat, '%Y-%m-%d')
                existing_sprin.TGL_SPRIN = datetime.strptime(tgl_awal_surat, '%Y-%m-%d')
                existing_sprin.TGL_AKHIR_SPRIN = tgl_akhir_surat
                existing_sprin.PERIHAL_SPRIN = keterangan
                existing_sprin.PENEMPATAN = penempatan
                existing_sprin.UPDATE_BY = 'admin'
                existing_sprin.UPDATE_DATE = datetime.now()
            else:
                guid_sprin = f"DLO_{datetime.now().strftime('%Y-%m')}_{str(uuid.uuid4())}"
        else:
            # Cek existing by no_surat dengan TYPE_SPRIN_ID='OPR'
            existing_sprin = SprinHeader.query.filter(
                SprinHeader.NO_SPRIN == no_surat,
                SprinHeader.TYPE_SPRIN_ID == 'OPR'
            ).first()
            
            if existing_sprin:
                guid_sprin = existing_sprin.GUID_SPRIN
                # Update header
                existing_sprin.TGL_AWAL_SPRIN = datetime.strptime(tgl_awal_surat, '%Y-%m-%d')
                existing_sprin.TGL_SPRIN = datetime.strptime(tgl_awal_surat, '%Y-%m-%d')
                existing_sprin.TGL_AKHIR_SPRIN = tgl_akhir_surat
                existing_sprin.PERIHAL_SPRIN = keterangan
                existing_sprin.PENEMPATAN = penempatan
                existing_sprin.UPDATE_BY = 'admin'
                existing_sprin.UPDATE_DATE = datetime.now()
            else:
                guid_sprin = f"DLO_{datetime.now().strftime('%Y-%m')}_{str(uuid.uuid4())}"
                new_sprin = SprinHeader(
                    GUID_SPRIN=guid_sprin,
                    TYPE_SPRIN_ID='OPR',
                    NO_SPRIN=no_surat,
                    TGL_SPRIN=datetime.strptime(tgl_awal_surat, '%Y-%m-%d'),
                    TGL_AWAL_SPRIN=datetime.strptime(tgl_awal_surat, '%Y-%m-%d'),
                    TGL_AKHIR_SPRIN=tgl_akhir_surat,
                    PERIHAL_SPRIN=keterangan,
                    PENEMPATAN=penempatan,
                    STATUS_UM=int(status_um),
                    UPDATE_BY='admin',
                    UPDATE_DATE=datetime.now()
                )
                db.session.add(new_sprin)
        
        db.session.flush()
        
        # Jika hanya simpan header, commit dan return
        if save_header_only:
            db.session.commit()
            return jsonify({
                'success': True, 
                'message': 'Header berhasil disimpan', 
                'guid_sprin': guid_sprin
            })
        
        # STEP 2: Simpan peserta ke DINAS_LUAR
        if not peserta_list:
            return jsonify({'success': False, 'error': 'Peserta tidak boleh kosong'})
        
        # Delete existing peserta jika update (sebelum insert baru)
        if is_update and guid_sprin_existing:
            old_peserta = DinasLuar.query.filter(
                DinasLuar.GUID_SPRIN == guid_sprin_existing,
                DinasLuar.JENIS == 'OP'
            ).all()
            for old in old_peserta:
                db.session.delete(old)
            db.session.flush()
        
        saved_count = 0
        tipe = '1' if jenis_operasi else '0'
        
        # ✅ LOOP PESERTA - HANYA PAKAI NIP
        for peserta in peserta_list:
            nip = peserta.get('nip', '')  # ✅ NIP saja
            tgl_awal = peserta.get('tgl_awal', '')
            tgl_akhir = peserta.get('tgl_akhir', '')
            status_um_peserta = peserta.get('status_um', status_um)
            
            if not nip or not tgl_awal or not tgl_akhir:
                continue
            
            # Generate TransaksiID (format: DLO_NIP_TglAwal_TglAkhir)
            transaksi_id = f"DLO_{nip}_{tgl_awal}_{tgl_akhir}"
            
            # Cek existing
            existing_dl = DinasLuar.query.filter(
                DinasLuar.DINAS_TRANSAKSI_ID == transaksi_id
            ).first()
            
            tgl_awal_date = datetime.strptime(tgl_awal, '%Y-%m-%d')
            tgl_akhir_date = datetime.strptime(tgl_akhir, '%Y-%m-%d')
            
            if existing_dl:
                # Update
                existing_dl.TGL_AWAL_DINAS_LUAR = tgl_awal_date
                existing_dl.TGL_AKHIR_DINAS_LUAR = tgl_akhir_date
                existing_dl.KETERANGAN_DINAS_LUAR = keterangan
                existing_dl.PENEMPATAN_DINAS_LUAR = penempatan
                existing_dl.STATUS_UM = int(status_um_peserta)
                existing_dl.NAMA_FILE = nama_file
                existing_dl.TIPE = tipe
                existing_dl.TGL_AWAL_SURAT = datetime.strptime(tgl_awal_surat, '%Y-%m-%d')
                existing_dl.TGL_AKHIR_SURAT = datetime.strptime(tgl_akhir_surat, '%Y-%m-%d') if tgl_akhir_surat else None
                existing_dl.UPDATE_BY = 'admin'
                existing_dl.UPDATE_DATE = datetime.now()
            else:
                # ✅ Insert baru - NIP adalah NIP asli
                new_dl = DinasLuar(
                    DINAS_TRANSAKSI_ID=transaksi_id,
                    GUID_SPRIN=guid_sprin,
                    NIP=nip,  # ✅ NIP asli pegawai
                    TGL_AWAL_DINAS_LUAR=tgl_awal_date,
                    TGL_AKHIR_DINAS_LUAR=tgl_akhir_date,
                    KETERANGAN_DINAS_LUAR=keterangan,
                    PENEMPATAN_DINAS_LUAR=penempatan,
                    TRANSAKSI='DinasLuar',
                    PENDUKUNG='Y',
                    NO_SURAT=no_surat,
                    JENIS='OP',
                    NAMA_FILE=nama_file,
                    TGL_AWAL_SURAT=datetime.strptime(tgl_awal_surat, '%Y-%m-%d'),
                    TGL_AKHIR_SURAT=datetime.strptime(tgl_akhir_surat, '%Y-%m-%d') if tgl_akhir_surat else None,
                    TIPE=tipe,
                    STATUS_UM=int(status_um_peserta),
                    UPDATE_BY='admin',
                    UPDATE_DATE=datetime.now()
                )
                db.session.add(new_dl)
            
            saved_count += 1
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'{saved_count} peserta berhasil disimpan',
            'guid_sprin': guid_sprin
        })
        
    except Exception as e:
        db.session.rollback()
        import traceback
        print("❌ ERROR in api_dinas_luar_operasi_save:")
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})

def api_dinas_luar_operasi_save_peserta():
    """
    API: Simpan Peserta Dinas Luar Operasi (setelah header ada)
    Khusus Operasi: JENIS='OP', TIPE='1' atau '0'
    """
    try:
        data = request.get_json()
        print("📥 Data Peserta Operasi:", data)
        
        guid_sprin = data.get('guid_sprin', '')
        peserta_list = data.get('peserta', [])
        jenis_operasi = data.get('jenis_operasi', True)
        nama_file = data.get('nama_file', '-')
        
        if not guid_sprin:
            return jsonify({'success': False, 'error': 'GUID SPRIN tidak boleh kosong'})
        if not peserta_list:
            return jsonify({'success': False, 'error': 'Peserta tidak boleh kosong'})
        
        # Ambil data header
        header = SprinHeader.query.get(guid_sprin)
        if not header:
            return jsonify({'success': False, 'error': 'Header tidak ditemukan'})
        
        tipe = '1' if jenis_operasi else '0'
        
        saved_count = 0
        for peserta in peserta_list:
            nip = peserta.get('nip', '')  # NIP pegawai
            tgl_awal = peserta.get('tgl_awal', '')
            tgl_akhir = peserta.get('tgl_akhir', '')
            status_um = peserta.get('status_um', '0')
            
            if not nip or not tgl_awal or not tgl_akhir:
                continue
            
            # Generate TransaksiID (format: DLO_NIP_TglAwal_TglAkhir)
            transaksi_id = f"DLO_{nip}_{tgl_awal}_{tgl_akhir}"
            
            existing = DinasLuar.query.filter(
                DinasLuar.DINAS_TRANSAKSI_ID == transaksi_id
            ).first()
            
            tgl_awal_date = datetime.strptime(tgl_awal, '%Y-%m-%d')
            tgl_akhir_date = datetime.strptime(tgl_akhir, '%Y-%m-%d')
            
            if existing:
                existing.TGL_AWAL_DINAS_LUAR = tgl_awal_date
                existing.TGL_AKHIR_DINAS_LUAR = tgl_akhir_date
                existing.KETERANGAN_DINAS_LUAR = header.PERIHAL_SPRIN or ''
                existing.PENEMPATAN_DINAS_LUAR = header.PENEMPATAN or ''
                existing.STATUS_UM = int(status_um)
                existing.NAMA_FILE = nama_file
                existing.TIPE = tipe
                existing.TGL_AWAL_SURAT = header.TGL_AWAL_SPRIN
                existing.TGL_AKHIR_SURAT = header.TGL_SPRIN
                existing.UPDATE_BY = 'admin'
                existing.UPDATE_DATE = datetime.now()
            else:
                new_dl = DinasLuar(
                    DINAS_TRANSAKSI_ID=transaksi_id,
                    GUID_SPRIN=guid_sprin,
                    NIP=nip,  # NIP asli pegawai
                    TGL_AWAL_DINAS_LUAR=tgl_awal_date,
                    TGL_AKHIR_DINAS_LUAR=tgl_akhir_date,
                    KETERANGAN_DINAS_LUAR=header.PERIHAL_SPRIN or '',
                    PENEMPATAN_DINAS_LUAR=header.PENEMPATAN or '',
                    TRANSAKSI='DinasLuar',
                    PENDUKUNG='Y',
                    NO_SURAT=header.NO_SPRIN or '',
                    JENIS='OP',  # ✅ Operasi
                    NAMA_FILE=nama_file,
                    TGL_AWAL_SURAT=header.TGL_AWAL_SPRIN,
                    TGL_AKHIR_SURAT=header.TGL_SPRIN,
                    TIPE=tipe,  # ✅ 1=Operasi, 0=Non Operasi
                    STATUS_UM=int(status_um),
                    UPDATE_BY='admin',
                    UPDATE_DATE=datetime.now()
                )
                db.session.add(new_dl)
            
            saved_count += 1
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'{saved_count} peserta berhasil disimpan'
        })
        
    except Exception as e:
        db.session.rollback()
        import traceback
        print("❌ ERROR in api_dinas_luar_operasi_save_peserta:")
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})

def api_dinas_luar_operasi_get():
    """
    API: Get data Dinas Luar Operasi by No Surat
    Join DinasLuar.NIP ke Pegawai.NIP (pakai NIP, bukan FingerID)
    """
    try:
        no_surat = request.args.get('no_surat', '')
        if not no_surat:
            return jsonify({'success': False, 'error': 'No Surat tidak boleh kosong'})
        
        # ✅ Join by NIP
        dinas_list = db.session.query(
            DinasLuar, Pegawai
        ).outerjoin(
            Pegawai, DinasLuar.NIP == Pegawai.NIP
        ).filter(
            DinasLuar.NO_SURAT == no_surat,
            DinasLuar.TRANSAKSI == 'DinasLuar',
            DinasLuar.JENIS == 'OP'
        ).order_by(Pegawai.NAMA).all()
        
        if not dinas_list:
            return jsonify({'success': False, 'error': 'Data tidak ditemukan'})
        
        first = dinas_list[0][0]
        header = {
            'guid_sprin': first.GUID_SPRIN,
            'no_surat': first.NO_SURAT,
            'tgl_awal_surat': first.TGL_AWAL_SURAT.strftime('%Y-%m-%d') if first.TGL_AWAL_SURAT else '',
            'tgl_akhir_surat': first.TGL_AKHIR_SURAT.strftime('%Y-%m-%d') if first.TGL_AKHIR_SURAT else '',
            'keterangan': first.KETERANGAN_DINAS_LUAR or '',
            'penempatan': first.PENEMPATAN_DINAS_LUAR or '',
            'status_um': str(first.STATUS_UM) if first.STATUS_UM is not None else '1',
            'tipe': first.TIPE or '1',
            'nama_file': first.NAMA_FILE or '-'
        }
        
        peserta = []
        for dl, peg in dinas_list:
            status_um_name = 'Terpotong' if str(dl.STATUS_UM) == '1' else (
                'Tdk Terpotong Penempatan' if str(dl.STATUS_UM) == '2' else 'Tdk Terpotong'
            )
            peserta.append({
                'transaksi_id': dl.DINAS_TRANSAKSI_ID,
                'nip': dl.NIP,  # NIP asli
                'nama': peg.NAMA if peg else '-',
                'tgl_awal': dl.TGL_AWAL_DINAS_LUAR.strftime('%Y-%m-%d') if dl.TGL_AWAL_DINAS_LUAR else '',
                'tgl_akhir': dl.TGL_AKHIR_DINAS_LUAR.strftime('%Y-%m-%d') if dl.TGL_AKHIR_DINAS_LUAR else '',
                'status_um': str(dl.STATUS_UM) if dl.STATUS_UM is not None else '1',
                'status_um_name': status_um_name
            })
        
        return jsonify({
            'success': True,
            'data': {
                'header': header,
                'peserta': peserta
            }
        })
        
    except Exception as e:
        import traceback
        print("❌ ERROR in api_dinas_luar_operasi_get:")
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})


def api_dinas_luar_operasi_delete():
    """
    API: Delete Dinas Luar Operasi
    """
    try:
        data = request.get_json()
        guid_sprin = data.get('guid_sprin', '')
        transaksi_id = data.get('transaksi_id', '')
        
        if not guid_sprin and not transaksi_id:
            return jsonify({'success': False, 'error': 'Parameter tidak lengkap'})
        
        # Cari closing date
        closing_date = None
        closing_info = MediaInformasi.query.filter(
            MediaInformasi.TRX == 'closingabsensi'
        ).order_by(MediaInformasi.PUBLISH_DATE_START.desc()).first()
        
        if closing_info:
            closing_date = closing_info.PUBLISH_DATE_START
        
        deleted_count = 0
        
        if transaksi_id:
            # Delete single peserta
            dinas = DinasLuar.query.filter(
                DinasLuar.DINAS_TRANSAKSI_ID == transaksi_id
            ).first()
            
            if dinas:
                tgl_awal = dinas.TGL_AWAL_DINAS_LUAR
                tgl_akhir = dinas.TGL_AKHIR_DINAS_LUAR
                
                if closing_date and tgl_akhir and tgl_akhir > closing_date:
                    # Delete absensi
                    Absensi.query.filter(
                        Absensi.TRANSAKSI_ID_FROM == transaksi_id,
                        Absensi.TGL_KERJA >= tgl_awal,
                        Absensi.TGL_KERJA <= tgl_akhir
                    ).delete()
                
                db.session.delete(dinas)
                deleted_count = 1
        else:
            # Delete semua dengan GUID_SPRIN
            dinas_list = DinasLuar.query.filter(
                DinasLuar.GUID_SPRIN == guid_sprin,
                DinasLuar.JENIS == 'OP'
            ).all()
            
            for dinas in dinas_list:
                tgl_awal = dinas.TGL_AWAL_DINAS_LUAR
                tgl_akhir = dinas.TGL_AKHIR_DINAS_LUAR
                
                if closing_date and tgl_akhir and tgl_akhir > closing_date:
                    Absensi.query.filter(
                        Absensi.TRANSAKSI_ID_FROM == dinas.DINAS_TRANSAKSI_ID,
                        Absensi.TGL_KERJA >= tgl_awal,
                        Absensi.TGL_KERJA <= tgl_akhir
                    ).delete()
                
                db.session.delete(dinas)
                deleted_count += 1
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'{deleted_count} data berhasil dihapus'
        })
        
    except Exception as e:
        db.session.rollback()
        import traceback
        print("❌ ERROR in api_dinas_luar_operasi_delete:")
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})


def kepegawaian_dinas_luar_pelatihan():
    """
    Render halaman Kepegawaian Dinas Luar Pelatihan.
    """
    return render_template('pages/dashboard_1/Kepegawaian Dinas Luar Pelatihan.html')


def kepegawaian_dinas_luar_umum():
    return render_template('pages/dashboard_1/Kepegawaian Dinas Luar Umum.html')


def api_dinas_luar_search_pegawai():
    """API: Pencarian pegawai untuk autocomplete"""
    try:
        keyword = request.args.get('keyword', '').strip()
        if len(keyword) < 2: return jsonify({'data': []})
        pegawai_list = Pegawai.query.filter(Pegawai.NAMA.ilike(f'%{keyword}%')).order_by(Pegawai.NAMA.asc()).limit(15).all()
        return jsonify({'data': [{'nip': p.NIP, 'nama': p.NAMA} for p in pegawai_list]})
    except Exception as e:
        return jsonify({'error': str(e), 'data': []})

def api_sprin_header_save():
    """API: Simpan Header SPRIN saja"""
    try:
        data = request.get_json()
        
        no_surat = data.get('no_surat', '').strip()
        tgl_awal = data.get('tgl_awal_surat', '')
        tgl_akhir = data.get('tgl_akhir_surat', '')
        keterangan = data.get('keterangan', '')
        penempatan = data.get('penempatan', '')
        type_sprin_id = data.get('type_sprin_id', 'DL')  # ✅ Default 'DL', bisa 'OPR'
        
        if not no_surat: 
            return jsonify({'error': 'No. Surat tidak boleh kosong'})
        
        # Cek existing
        existing = SprinHeader.query.filter(
            SprinHeader.NO_SPRIN == no_surat,
            SprinHeader.TYPE_SPRIN_ID == type_sprin_id  # ✅ Filter by type juga
        ).first()
        
        if existing:
            return jsonify({
                'success': True, 
                'guid_sprin': existing.GUID_SPRIN, 
                'message': 'Header sudah ada'
            })
        
        # Generate GUID sesuai type
        prefix = 'DLU_' if type_sprin_id == 'DL' else 'DLO_'
        guid_sprin = f"{prefix}{datetime.now().strftime('%Y-%m')}_{str(uuid.uuid4())}"
        
        new_sprin = SprinHeader(
            GUID_SPRIN=guid_sprin,
            TYPE_SPRIN_ID=type_sprin_id,  # ✅ Bisa 'DL' atau 'OPR'
            NO_SPRIN=no_surat,
            TGL_SPRIN=datetime.strptime(tgl_awal, '%Y-%m-%d') if tgl_awal else None,
            TGL_AWAL_SPRIN=datetime.strptime(tgl_awal, '%Y-%m-%d') if tgl_awal else None,
            TGL_AKHIR_SPRIN=tgl_akhir,
            PERIHAL_SPRIN=keterangan,
            PENEMPATAN=penempatan,
            UPDATE_BY='admin',
            UPDATE_DATE=datetime.now()
        )
        db.session.add(new_sprin)
        db.session.commit()
        
        return jsonify({
            'success': True, 
            'guid_sprin': guid_sprin, 
            'message': 'Header berhasil disimpan'
        })
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)})

def api_dinas_luar_save_peserta():
    """API: Simpan Peserta ke DINAS_LUAR (setelah header ada)"""
    try:
        data = request.get_json()
        guid_sprin = data.get('guid_sprin', '')
        peserta_list = data.get('peserta', [])
        
        if not guid_sprin: return jsonify({'error': 'GUID SPRIN tidak boleh kosong'})
        if not peserta_list: return jsonify({'error': 'Peserta tidak boleh kosong'})
        
        # Ambil data header
        header = SprinHeader.query.get(guid_sprin)
        if not header: return jsonify({'error': 'Header tidak ditemukan'})
        
        saved_count = 0
        for peserta in peserta_list:
            nip = peserta.get('nip', '')
            tgl_awal = peserta.get('tgl_awal', '')
            tgl_akhir = peserta.get('tgl_akhir', '')
            status_um = peserta.get('status_um', '0')
            
            if not nip or not tgl_awal or not tgl_akhir: continue
            
            transaksi_id = f"DLU_{nip}_{tgl_awal}_{tgl_akhir}"
            existing = DinasLuar.query.filter(DinasLuar.DINAS_TRANSAKSI_ID == transaksi_id).first()
            
            if existing:
                existing.TGL_AWAL_DINAS_LUAR = datetime.strptime(tgl_awal, '%Y-%m-%d')
                existing.TGL_AKHIR_DINAS_LUAR = datetime.strptime(tgl_akhir, '%Y-%m-%d')
                existing.STATUS_UM = int(status_um)
                existing.UPDATE_BY = 'admin'
                existing.UPDATE_DATE = datetime.now()
            else:
                new_dl = DinasLuar(
                    DINAS_TRANSAKSI_ID=transaksi_id, GUID_SPRIN=guid_sprin, NIP=nip,
                    TGL_AWAL_DINAS_LUAR=datetime.strptime(tgl_awal, '%Y-%m-%d'),
                    TGL_AKHIR_DINAS_LUAR=datetime.strptime(tgl_akhir, '%Y-%m-%d'),
                    KETERANGAN_DINAS_LUAR=header.PERIHAL_SPRIN or '',
                    PENEMPATAN_DINAS_LUAR=header.PENEMPATAN or '',
                    TRANSAKSI='DinasLuar', PENDUKUNG='Y',
                    NO_SURAT=header.NO_SPRIN or '', JENIS='DL', NAMA_FILE='-',
                    TGL_AWAL_SURAT=header.TGL_AWAL_SPRIN,
                    TGL_AKHIR_SURAT=header.TGL_SPRIN,
                    TIPE=0, STATUS_UM=int(status_um),
                    UPDATE_BY='admin', UPDATE_DATE=datetime.now()
                )
                db.session.add(new_dl)
            saved_count += 1
        
        db.session.commit()
        return jsonify({'success': True, 'message': f'{saved_count} peserta berhasil disimpan'})
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)})

def api_dinas_luar_save():
    """API: Simpan Dinas Luar Umum"""
    try:
        data = request.get_json()
        
        no_surat = data.get('no_surat', '').strip()
        tgl_awal_surat = data.get('tgl_awal_surat', '')
        tgl_akhir_surat = data.get('tgl_akhir_surat', '')
        keterangan = data.get('keterangan', '')
        penempatan = data.get('penempatan', '')
        status_um = data.get('status_um', '0')
        peserta_list = data.get('peserta', [])
        guid_sprin = data.get('guid_sprin', '')
        is_update = data.get('is_update', False)
        save_header_only = data.get('save_header_only', False)  # ✅ Flag baru
        
        if not no_surat: return jsonify({'error': 'No. Surat tidak boleh kosong'})
        if not tgl_awal_surat or not tgl_akhir_surat: return jsonify({'error': 'Tanggal Surat tidak boleh kosong'})
        
        # STEP 1: Simpan/Cari SPRIN_HEADER dulu
        existing_sprin = SprinHeader.query.filter(SprinHeader.NO_SPRIN == no_surat).first()
        
        if existing_sprin:
            guid_sprin = existing_sprin.GUID_SPRIN
        else:
            guid_sprin = f"DLU_{datetime.now().strftime('%Y-%m')}_{str(uuid.uuid4())}"
            new_sprin = SprinHeader(
                GUID_SPRIN=guid_sprin, TYPE_SPRIN_ID='DL', NO_SPRIN=no_surat,
                TGL_SPRIN=datetime.strptime(tgl_awal_surat, '%Y-%m-%d'),
                TGL_AWAL_SPRIN=datetime.strptime(tgl_awal_surat, '%Y-%m-%d'),
                TGL_AKHIR_SPRIN=tgl_akhir_surat, PERIHAL_SPRIN=keterangan,
                PENEMPATAN=penempatan, STATUS_UM=int(status_um),
                UPDATE_BY='admin', UPDATE_DATE=datetime.now()
            )
            db.session.add(new_sprin)
            db.session.flush()
        
        # ✅ Jika hanya simpan header, commit dan return
        if save_header_only:
            db.session.commit()
            return jsonify({'success': True, 'message': 'Header berhasil disimpan', 'guid_sprin': guid_sprin})
        
        # STEP 2: Simpan peserta ke DINAS_LUAR
        if not peserta_list: return jsonify({'error': 'Peserta tidak boleh kosong'})
        
        saved_count = 0
        for peserta in peserta_list:
            nip = peserta.get('nip', '')
            tgl_awal_dl = peserta.get('tgl_awal', '')
            tgl_akhir_dl = peserta.get('tgl_akhir', '')
            status_um_peserta = peserta.get('status_um', status_um)
            
            if not nip or not tgl_awal_dl or not tgl_akhir_dl: continue
            
            transaksi_id = f"DLU_{nip}_{tgl_awal_dl}_{tgl_akhir_dl}"
            existing = DinasLuar.query.filter(DinasLuar.DINAS_TRANSAKSI_ID == transaksi_id).first()
            
            if existing:
                existing.TGL_AWAL_DINAS_LUAR = datetime.strptime(tgl_awal_dl, '%Y-%m-%d')
                existing.TGL_AKHIR_DINAS_LUAR = datetime.strptime(tgl_akhir_dl, '%Y-%m-%d')
                existing.KETERANGAN_DINAS_LUAR = keterangan
                existing.PENEMPATAN_DINAS_LUAR = penempatan
                existing.STATUS_UM = int(status_um_peserta)
                existing.UPDATE_BY = 'admin'
                existing.UPDATE_DATE = datetime.now()
            else:
                new_dl = DinasLuar(
                    DINAS_TRANSAKSI_ID=transaksi_id, GUID_SPRIN=guid_sprin, NIP=nip,
                    TGL_AWAL_DINAS_LUAR=datetime.strptime(tgl_awal_dl, '%Y-%m-%d'),
                    TGL_AKHIR_DINAS_LUAR=datetime.strptime(tgl_akhir_dl, '%Y-%m-%d'),
                    KETERANGAN_DINAS_LUAR=keterangan, PENEMPATAN_DINAS_LUAR=penempatan,
                    TRANSAKSI='DinasLuar', PENDUKUNG='Y', NO_SURAT=no_surat,
                    JENIS='DL', NAMA_FILE='-',
                    TGL_AWAL_SURAT=datetime.strptime(tgl_awal_surat, '%Y-%m-%d'),
                    TGL_AKHIR_SURAT=datetime.strptime(tgl_akhir_surat, '%Y-%m-%d'),
                    TIPE=0, STATUS_UM=int(status_um_peserta),
                    UPDATE_BY='admin', UPDATE_DATE=datetime.now()
                )
                db.session.add(new_dl)
            saved_count += 1
        
        db.session.commit()
        return jsonify({'success': True, 'message': f'{saved_count} peserta berhasil disimpan', 'guid_sprin': guid_sprin})
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def api_dinas_luar_get():
    """API: Get data Dinas Luar by No Surat"""
    try:
        no_surat = request.args.get('no_surat', '')
        if not no_surat: return jsonify({'error': 'No Surat tidak boleh kosong'})
        
        dinas_list = DinasLuar.query.filter(
            DinasLuar.NO_SURAT == no_surat,
            DinasLuar.TRANSAKSI == 'DinasLuar',
            DinasLuar.JENIS == 'DL'
        ).all()
        
        if not dinas_list: return jsonify({'error': 'Data tidak ditemukan'})
        
        first = dinas_list[0]
        header = {
            'guid_sprin': first.GUID_SPRIN, 'no_surat': first.NO_SURAT,
            'tgl_awal_surat': first.TGL_AWAL_SURAT.strftime('%Y-%m-%d') if first.TGL_AWAL_SURAT else '',
            'tgl_akhir_surat': first.TGL_AKHIR_SURAT.strftime('%Y-%m-%d') if first.TGL_AKHIR_SURAT else '',
            'keterangan': first.KETERANGAN_DINAS_LUAR or '', 'penempatan': first.PENEMPATAN_DINAS_LUAR or '',
            'status_um': str(first.STATUS_UM) if first.STATUS_UM else '0',
        }
        
        peserta = []
        for dl in dinas_list:
            peg = Pegawai.query.get(dl.NIP)
            peserta.append({
                'transaksi_id': dl.DINAS_TRANSAKSI_ID, 'nip': dl.NIP,
                'nama': peg.NAMA if peg else '-',
                'tgl_awal': dl.TGL_AWAL_DINAS_LUAR.strftime('%Y-%m-%d') if dl.TGL_AWAL_DINAS_LUAR else '',
                'tgl_akhir': dl.TGL_AKHIR_DINAS_LUAR.strftime('%Y-%m-%d') if dl.TGL_AKHIR_DINAS_LUAR else '',
                'status_um': str(dl.STATUS_UM) if dl.STATUS_UM else '0',
            })
        
        return jsonify({'success': True, 'data': {'header': header, 'peserta': peserta}})
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def api_dinas_luar_delete():
    """API: Delete Dinas Luar"""
    try:
        data = request.get_json()
        guid_sprin = data.get('guid_sprin', '')
        transaksi_id = data.get('transaksi_id', '')
        
        if transaksi_id:
            DinasLuar.query.filter(DinasLuar.DINAS_TRANSAKSI_ID == transaksi_id).delete()
        elif guid_sprin:
            DinasLuar.query.filter(DinasLuar.GUID_SPRIN == guid_sprin).delete()
        else:
            return jsonify({'error': 'Parameter tidak lengkap'})
        
        db.session.commit()
        return jsonify({'success': True, 'message': 'Data berhasil dihapus'})
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)})


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