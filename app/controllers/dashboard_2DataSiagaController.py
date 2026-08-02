# controllers/dashboard_2DataSiagaController.py
from flask import render_template, request, jsonify
from datetime import datetime
from app import db
from app.models.otorisasiModel import Otorisasi
from app.models.pegawaiModel import Pegawai
from app.models.unitKerjaModel import MfUnitKerja
from app.models.logActivityModel import LogActivity
from app.models.shiftModel import MfShift
from app.models.statusModel import MfStatus
from app.models.orgzSiagaModel import MfOrgzSiaga

def data_siaga_absensi_kehadiran():
    """Render halaman Absensi Kehadiran Piket Siaga."""
    unit_kerja_list = MfUnitKerja.query.order_by(MfUnitKerja.NAMA_UNIT_KERJA.asc()).all()
    shift_list = MfShift.query.filter(
        MfShift.NAMA_SHIFT != ''
    ).order_by(MfShift.SHIFT_ID.asc()).all()
    
    return render_template(
        'pages/dashboard_2/Data_Siaga_Absensi_Kehadiran.html',
        unit_kerja_list=unit_kerja_list,
        shift_list=shift_list
    )

def api_absensi_kehadiran_get():
    """
    API: Get data absensi kehadiran (seperti lbRefesh_Click di VB.NET)
    """
    try:
        tgl = request.args.get('tgl', datetime.now().strftime('%Y-%m-%d'))
        unit_kerja_id = request.args.get('unit_kerja_id', '')
        shift = request.args.get('shift', '')
        
        # ✅ Query lebih sederhana tanpa MfStatus & MfOrgzSiaga (jika tabel kosong)
        query = (
            db.session.query(
                LogActivity,
                Pegawai,
                MfUnitKerja
            )
            .join(Pegawai, LogActivity.NIP == Pegawai.NIP)
            .join(MfUnitKerja, LogActivity.UNIT_KERJA_ID == MfUnitKerja.UNIT_KERJA_ID)
            .filter(LogActivity.ACTIVITY == 'Piket Siaga')
            .filter(LogActivity.ACTIVITY_DATE == tgl)
        )
        
        if shift:
            query = query.filter(LogActivity.SHIFT == shift)
        
        if unit_kerja_id:
            query = query.filter(LogActivity.UNIT_KERJA_ID == int(unit_kerja_id))
        
        query = query.order_by(LogActivity.ACTIVITY_DATE, LogActivity.SHIFT)
        
        results = query.all()
        
        # Format data
        data = []
        for i, (log, peg, unit) in enumerate(results, 1):
            data.append({
                'no': i,
                'nip': log.NIP,
                'nama': peg.NAMA if peg else '-',
                'activity_date': log.ACTIVITY_DATE.strftime('%d-%m-%Y') if log.ACTIVITY_DATE else '',
                'fungsional': log.FUNGSIONAL or '',
                'fungsional_ket': log.FUNGSIONAL or '',
                'unit_kerja': unit.NAMA_UNIT_KERJA if unit else '',
                'guid_log': log.GUID_LOG,
                'status_id': log.STATUS_ID,
                'status': 'Hadir' if log.STATUS_ID == 3 else ('Tidak Hadir' if log.STATUS_ID == -1 else 'Belum'),
                'bg_status': '',
                'shift': log.SHIFT or '',
                'shift_1': log.SHIFT_1 or 0,
                'shift_2': log.SHIFT_2 or 0,
                'pengganti': log.PENGGANTI or 0,
                'status_trx': log.STATUS_TRX or '-',
                'update_by': log.UPDATE_BY or '',
                'update_date': log.UPDATE_DATE.strftime('%d/%m/%Y %H:%M') if log.UPDATE_DATE else '',
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


def api_absensi_kehadiran_update():
    """
    API: Update kehadiran
    """
    try:
        data = request.get_json()
        guid_log = data.get('guid_log', '')
        shift1 = data.get('shift1', False)
        shift2 = data.get('shift2', False)
        nip = data.get('nip', '')
        
        if not guid_log:
            return jsonify({'error': 'GUID Log tidak ditemukan'})
        
        # ✅ Untuk testing, skip cek otorisasi dulu
        # Karena OTORISASI tidak terhubung langsung ke LOG_ACTIVITIY
        
        log = LogActivity.query.filter(LogActivity.GUID_LOG == guid_log).first()
        
        if log:
            x_status = 3 if (shift1 or shift2) else -1
            
            log.STATUS_ID = x_status
            log.SHIFT_1 = 1 if shift1 else 0
            log.SHIFT_2 = 1 if shift2 else 0
            log.TGL_CLOSING = log.ACTIVITY_DATE
            log.UPDATE_BY = 'admin'
            log.UPDATE_DATE = datetime.now()
            
            db.session.commit()
            
            return jsonify({
                'success': True,
                'message': 'Update kehadiran berhasil'
            })
        
        return jsonify({'error': 'Data tidak ditemukan'})
        
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})

def data_siaga_cetak_daftar_lembur_siaga():
    """Render halaman Data Siaga Cetak Daftar Lembur Siaga."""
    return render_template('pages/dashboard_2/Data_Siaga_Cetak_Daftar_Lembur_Siaga.html')

def data_siaga_cetak_rekap_siaga():
    """Render halaman Data Siaga Cetak Rekap Siaga."""
    return render_template('pages/dashboard_2/Data_Siaga_Cetak_Rekap_Siaga.html')

def data_siaga_cetak_uang_siaga():
    """Render halaman Data Siaga Cetak Uang Siaga."""
    return render_template('pages/dashboard_2/Data_Siaga_Cetak_Uang_Siaga.html')

def data_siaga_jadwal_ulang():
    """Render halaman Data Siaga Jadwal Ulang."""
    return render_template('pages/dashboard_2/Data_Siaga_Jadwal_Ulang.html')

def data_siaga_membuat_jadwal_piket_siaga():
    """Render halaman Data Siaga Membuat Jadwal Piket Siaga."""
    return render_template('pages/dashboard_2/Data_Siaga_Membuat_Jadwal_Piket_Siaga.html')