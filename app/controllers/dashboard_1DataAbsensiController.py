# controllers/dashboard_1DataAbsensiController.py
from flask import render_template, request, jsonify
from datetime import datetime, timedelta
from app import db
from app.models.absensiModel import Absensi
from app.models.pegawaiModel import Pegawai
from app.models.unitKerjaModel import MfUnitKerja


def data_absensi_non_finger():
    """
    Render halaman Data Absensi Non Finger.
    """
    return render_template('pages/dashboard_1/Data Absensi Non Finger.html')


def data_absensi_normalisasi_finger():
    """
    Render halaman Data Absensi Normalisasi Absensi Finger.
    """
    return render_template('pages/dashboard_1/Data Absensi Normalisasi Absensi Finger.html')


def data_absensi_pegawai_manual():
    """
    Render halaman Data Absensi Pegawai Absensi Manual.
    """
    return render_template('pages/dashboard_1/Data Absensi Pegawai Absensi Manual.html')


def data_absensi_pegawai_lembur_manual():
    """
    Render halaman Data Absensi Pegawai Lembur Manual.
    """
    return render_template('pages/dashboard_1/Data Absensi Pegawai Lembur Manual.html')


def data_absensi_trace_tunjangan():
    """
    Render halaman Data Absensi Trace Tunjangan.
    """
    return render_template('pages/dashboard_1/Data Absensi Trace Tunjangan.html')


def data_absensi_trace():
    """
    Render halaman Data Absensi Trace.
    """
    return render_template('pages/dashboard_1/Data Absensi Trace.html')


def api_trace_absensi():
    """
    API untuk mengambil data Trace Absensi.
    """
    try:
        tgl_awal_str = request.args.get('tgl_awal', '')
        tgl_akhir_str = request.args.get('tgl_akhir', '')
        filter_field1 = request.args.get('filter_field1', '')
        filter_value1 = request.args.get('filter_value1', '')
        filter_field2 = request.args.get('filter_field2', '')
        filter_value2 = request.args.get('filter_value2', '')
        
        if not tgl_awal_str or not tgl_akhir_str:
            return jsonify({'error': 'Tanggal periode kosong', 'data': []})
        
        tgl_awal = datetime.strptime(tgl_awal_str, '%Y-%m-%d')
        tgl_akhir = datetime.strptime(tgl_akhir_str, '%Y-%m-%d') + timedelta(days=1)
        
        # ✅ Query utama - JOIN via NIP (bukan FINGER_ID)
        query = (
            db.session.query(
                Absensi,
                Pegawai,
                MfUnitKerja
            )
            .join(Pegawai, Absensi.NIP == Pegawai.NIP)  # ✅ PAKAI NIP
            .join(MfUnitKerja, Pegawai.UNIT_KERJA_ID == MfUnitKerja.UNIT_KERJA_ID)
            .filter(
                Absensi.TGL_KERJA >= tgl_awal,
                Absensi.TGL_KERJA < tgl_akhir
            )
        )
        
        # Field mapping untuk filter
        field_mapping = {
            'FingerID': Absensi.FINGER_ID,
            'NIP': Pegawai.NIP,
            'Nama': Pegawai.NAMA,
            'UnitKerjaName': MfUnitKerja.NAMA_UNIT_KERJA,
            'TransaksiIn': Absensi.TRANSAKSI_IN,
            'TransaksiOut': Absensi.TRANSAKSI_OUT,
            'TingkatTLM': Absensi.TINGKAT_TLM,
            'TingkatPSW': Absensi.TINGKAT_PSW,
        }
        
        if filter_field1 and filter_value1:
            field = field_mapping.get(filter_field1)
            if field:
                query = query.filter(field.ilike(f'%{filter_value1}%'))
        
        if filter_field2 and filter_value2:
            field = field_mapping.get(filter_field2)
            if field:
                query = query.filter(field.ilike(f'%{filter_value2}%'))
        
        # Order by NIP, TglKerja
        query = query.order_by(Pegawai.NIP, Absensi.TGL_KERJA)
        
        results = query.all()
        
        # Format data
        data = []
        for i, (absensi, pegawai, unit_kerja) in enumerate(results, 1):
            # Logika VB.NET: Manual -> LogFP
            transaksi_in = (absensi.TRANSAKSI_IN or '').strip()
            if transaksi_in.upper() == 'MANUAL':
                transaksi_in = 'LogFP'
            
            is_logfp = transaksi_in.upper() == 'LOGFP'
            status_um = absensi.STATUS_UM or 0
            
            # Jika LogFP atau StatusUM = 0/2, tampilkan jam
            if is_logfp or status_um in [0, 2]:
                jam_baku_in = absensi.TGL_JAM_BAKU_IN.strftime('%H:%M') if absensi.TGL_JAM_BAKU_IN else ''
                jam_baku_out = absensi.TGL_JAM_BAKU_OUT.strftime('%H:%M') if absensi.TGL_JAM_BAKU_OUT else ''
                jam_in = absensi.TGL_JAM_IN.strftime('%H:%M') if absensi.TGL_JAM_IN else ''
                jam_out = absensi.TGL_JAM_OUT.strftime('%H:%M') if absensi.TGL_JAM_OUT else ''
                awal_tlm = absensi.AWAL_TLM or 0
                total_tlm = absensi.TOTAL_TLM or 0
                persen_pot_tlm = absensi.PERSEN_POT_TLM or 0
                persen_pot_psw = absensi.PERSEN_POT_PSW or 0
                tingkat_tlm = absensi.TINGKAT_TLM or ''
                tingkat_psw = absensi.TINGKAT_PSW or ''
                total_psw = absensi.TOTAL_PSW or 0
            else:
                jam_baku_in = ''
                jam_baku_out = ''
                jam_in = ''
                jam_out = ''
                awal_tlm = ''
                total_tlm = ''
                persen_pot_tlm = ''
                persen_pot_psw = ''
                tingkat_tlm = ''
                tingkat_psw = ''
                total_psw = ''
            
            # Validasi
            is_valid_in = (absensi.IS_INVALID or '').upper() == 'Y'
            is_valid_out = (absensi.IS_OUTVALID or '').upper() == 'Y'
            is_valid_tgl = is_valid_in and is_valid_out
            
            # Nama update
            nama_update_in = ''
            if absensi.UPDATE_IN_BY:
                nama_update_in = absensi.UPDATE_IN_BY
                if absensi.UPDATE_IN_DATE:
                    nama_update_in += f" {absensi.UPDATE_IN_DATE.strftime('%d/%m/%Y %H:%M')}"
            
            nama_update_out = ''
            if absensi.UPDATE_OUT_BY:
                nama_update_out = absensi.UPDATE_OUT_BY
                if absensi.UPDATE_OUT_DATE:
                    nama_update_out += f" {absensi.UPDATE_OUT_DATE.strftime('%d/%m/%Y %H:%M')}"
            
            data.append({
                'no': i,
                'nip': pegawai.NIP or '',
                'nama': pegawai.NAMA or '',
                'finger_id': absensi.FINGER_ID or '',
                'tgl_kerja': absensi.TGL_KERJA.strftime('%d %b %Y') if absensi.TGL_KERJA else '',
                'hari': absensi.TGL_KERJA.strftime('%A') if absensi.TGL_KERJA else '',
                'jam_baku_in': jam_baku_in,
                'jam_baku_out': jam_baku_out,
                'jam_in': jam_in,
                'jam_out': jam_out,
                'awal_tlm': awal_tlm,
                'total_tlm': total_tlm,
                'persen_pot_tlm': persen_pot_tlm,
                'persen_pot_psw': persen_pot_psw,
                'tingkat_tlm': tingkat_tlm,
                'total_psw': total_psw,
                'tingkat_psw': tingkat_psw,
                'transaksi_in': transaksi_in,
                'transaksi_out': absensi.TRANSAKSI_OUT or '',
                'is_valid_in': is_valid_in,
                'is_valid_out': is_valid_out,
                'is_valid_tgl': is_valid_tgl,
                'nama_update_in': nama_update_in,
                'nama_update_out': nama_update_out,
                'unit_kerja': unit_kerja.NAMA_UNIT_KERJA if unit_kerja else '',
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


# ---- Cari Absensi (pencarian) ----

def cari_absensi_non_finger():
    """Render halaman Cari Absensi Non Finger."""
    return render_template('pages/dashboard_1/Cari Absensi Non Finger.html')


def cari_absensi_normalisasi_finger():
    """Render halaman Cari Absensi Normalisasi Absensi Finger."""
    return render_template('pages/dashboard_1/Cari Absensi Normalisasi Absensi Finger.html')


def cari_absensi_pegawai_manual():
    """Render halaman Cari Absensi Pegawai Absen Manual."""
    return render_template('pages/dashboard_1/Cari Absensi Pegawai Absen Manual.html')


def cari_absensi_pegawai_lembur_manual():
    """Render halaman Cari Absensi Pegawai Lembur Manual."""
    return render_template('pages/dashboard_1/Cari Absensi Pegawai Lembur Manual.html')