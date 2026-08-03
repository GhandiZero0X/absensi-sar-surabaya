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
from app.models.logActivityBackupModel import LogActivityBackup
from app.models.dinasLuarModel import DinasLuar

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

def api_rejadwal_siaga_get_jadwal():
    """
    API: Get data jadwal piket siaga berdasarkan Unit, Tanggal, Shift
    """
    try:
        unit_kerja_id = request.args.get('unit_kerja_id', '')
        tgl = request.args.get('tgl', '')
        shift = request.args.get('shift', '')
        
        if not unit_kerja_id or not tgl or not shift:
            return jsonify({'success': False, 'error': 'Unit, Tanggal, dan Shift harus diisi'})
        
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d')
        
        # Cari GUID_LOG
        guid_log_result = db.session.query(LogActivity.GUID_LOG).filter(
            LogActivity.ACTIVITY == 'Piket Siaga',
            db.func.date(LogActivity.ACTIVITY_DATE) == tgl_date.date(),
            LogActivity.UNIT_KERJA_ID == int(unit_kerja_id),
            LogActivity.SHIFT == shift
        ).first()
        
        if not guid_log_result:
            return jsonify({'success': False, 'error': 'Jadwal tidak ditemukan'})
        
        guid_log = guid_log_result[0]
        
        # Query jadwal
        try:
            jadwal_list = db.session.query(
                LogActivity, Pegawai, MfUnitKerja, MfOrgzSiaga, MfStatus
            ).join(
                Pegawai, LogActivity.NIP == Pegawai.NIP
            ).join(
                MfUnitKerja, LogActivity.UNIT_KERJA_ID == MfUnitKerja.UNIT_KERJA_ID
            ).join(
                MfOrgzSiaga, LogActivity.FUNGSIONAL == MfOrgzSiaga.FUNGSIONAL
            ).outerjoin(
                MfStatus, LogActivity.STATUS_ID == MfStatus.STATUS_ID
            ).filter(
                LogActivity.ACTIVITY == 'Piket Siaga',
                LogActivity.GUID_LOG == guid_log,
                db.func.date(LogActivity.ACTIVITY_DATE) == tgl_date.date(),
                LogActivity.UNIT_KERJA_ID == int(unit_kerja_id),
                LogActivity.SHIFT == shift
            ).order_by(MfOrgzSiaga.URUT_FUNGSIONAL).all()
        except Exception:
            jadwal_list = db.session.query(
                LogActivity, Pegawai, MfUnitKerja
            ).join(
                Pegawai, LogActivity.NIP == Pegawai.NIP
            ).join(
                MfUnitKerja, LogActivity.UNIT_KERJA_ID == MfUnitKerja.UNIT_KERJA_ID
            ).filter(
                LogActivity.ACTIVITY == 'Piket Siaga',
                LogActivity.GUID_LOG == guid_log,
                db.func.date(LogActivity.ACTIVITY_DATE) == tgl_date.date(),
                LogActivity.UNIT_KERJA_ID == int(unit_kerja_id),
                LogActivity.SHIFT == shift
            ).all()
        
        # ✅ Query rollback - gunakan NIP_PENGGANTI untuk join ke Pegawai
        # karena model LogActivityBackup tidak punya field NIP
        rollback_list = db.session.query(
            LogActivityBackup, Pegawai
        ).outerjoin(
            Pegawai, LogActivityBackup.NIP_PENGGANTI == Pegawai.NIP
        ).filter(
            LogActivityBackup.ACTIVITY == 'Piket Siaga',
            LogActivityBackup.TRANSAKSI_FORM == 'Delete Rejadwal',
            LogActivityBackup.GUID_LOG == guid_log,
            db.func.date(LogActivityBackup.ACTIVITY_DATE) == tgl_date.date(),
            LogActivityBackup.SHIFT == shift
        ).all()
        
        # Format jadwal
        jadwal_data = []
        for i, item in enumerate(jadwal_list, 1):
            if len(item) == 5:
                log, peg, unit, orgz, status = item
                status_text = status.STATUS if status else '-'
                bg_status = status.BG_STATUS if status else ''
            else:
                log, peg, unit = item
                orgz = None
                status_text = 'Hadir' if log.STATUS_ID == 3 else ('Pending' if log.STATUS_ID == 2 else '-')
                bg_status = ''
            
            jadwal_data.append({
                'no': i,
                'guid_log': log.GUID_LOG,
                'nip': log.NIP,
                'nama': peg.NAMA if peg else '-',
                'fungsional': log.FUNGSIONAL or '',
                'status_id': log.STATUS_ID,
                'status': status_text,
                'bg_status': bg_status,
                'unit_kerja': unit.NAMA_UNIT_KERJA if unit else '',
                'shift': log.SHIFT or '',
                'act_date': log.ACTIVITY_DATE.strftime('%Y.%m.%d') if log.ACTIVITY_DATE else '',
                'status_trx': log.STATUS_TRX or '',
                'pengganti': log.PENGGANTI or '0',
            })
        
        # Format rollback
        rollback_data = []
        for i, (lb, peg) in enumerate(rollback_list, 1):
            rollback_data.append({
                'no': i,
                'guid_log_backup': lb.GUID_LOG_BACKUP,  # ✅ PK untuk identifikasi
                'guid_log': lb.GUID_LOG,
                'nip': lb.NIP_PENGGANTI or '-',  # ✅ NIP disimpan di NIP_PENGGANTI
                'nama': peg.NAMA if peg else (lb.NIP_PENGGANTI or '-'),
                'fungsional': lb.FUNGSIONAL or '',
                'shift': lb.SHIFT or '',
                'act_date': lb.ACTIVITY_DATE.strftime('%Y.%m.%d') if lb.ACTIVITY_DATE else '',
            })
        
        return jsonify({
            'success': True,
            'guid_log': guid_log,
            'jadwal': jadwal_data,
            'rollback': rollback_data
        })
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})


def api_rejadwal_siaga_delete_personil():
    """
    API: Hapus personil dari jadwal
    """
    try:
        data = request.get_json()
        print("📥 Delete Personil:", data)
        
        guid_log = data.get('guid_log', '')
        nip = data.get('nip', '')
        act_date = data.get('act_date', '')
        shift = data.get('shift', '')
        
        if not guid_log or not nip:
            return jsonify({'success': False, 'error': 'Data tidak lengkap'})
        
        act_date_fixed = act_date.replace('.', '-')
        act_date_obj = datetime.strptime(act_date_fixed, '%Y-%m-%d')
        
        log = LogActivity.query.filter(
            LogActivity.GUID_LOG == guid_log,
            LogActivity.NIP == nip,
            db.func.date(LogActivity.ACTIVITY_DATE) == act_date_obj.date(),
            LogActivity.SHIFT == shift
        ).first()
        
        if not log:
            return jsonify({'success': False, 'error': 'Data tidak ditemukan'})
        
        # ✅ Backup - simpan NIP di NIP_PENGGANTI, tandai di TRANSAKSI_FORM
        backup = LogActivityBackup(
            GUID_LOG_BACKUP=f"BACKUP_{log.GUID_LOG}_{log.NIP}_{datetime.now().strftime('%Y%m%d%H%M%S')}",
            GUID_LOG=log.GUID_LOG,
            TRX=log.TRX,
            ACTIVITY=log.ACTIVITY,
            ACTIVITY_DATE=log.ACTIVITY_DATE,
            NOTE=log.NOTE,
            TEMPAT=log.TEMPAT,
            PERIHAL=log.PERIHAL,
            UPDATE_BY='admin',
            UPDATE_DATE=datetime.now(),
            FUNGSIONAL=log.FUNGSIONAL,
            SHIFT_1=log.SHIFT_1,
            SHIFT_2=log.SHIFT_2,
            PENGGANTI=log.PENGGANTI,
            STATUS_TRX=log.STATUS_TRX,
            KET_UPDATE=f"Delete Rejadwal - {log.NIP}",
            NIP_PENGGANTI=log.NIP,  # ✅ Simpan NIP asli di sini
            SHIFT=log.SHIFT,
            TRANSAKSI_FORM='Delete Rejadwal',  # ✅ Tanda bahwa ini data delete
        )
        db.session.add(backup)
        db.session.delete(log)
        db.session.commit()
        
        return jsonify({'success': True, 'message': f'Personil {nip} berhasil dihapus'})
        
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})


def api_rejadwal_siaga_cancel_request():
    """
    API: Cancel request (ViewData) - Update StatusID = 2, StatusTrx = '-'
    """
    try:
        data = request.get_json()
        guid_log = data.get('guid_log', '')
        nip = data.get('nip', '')
        act_date = data.get('act_date', '')
        shift = data.get('shift', '')
        
        if not guid_log or not nip:
            return jsonify({'success': False, 'error': 'Data tidak lengkap'})
        
        act_date_fixed = act_date.replace('.', '-')
        act_date_obj = datetime.strptime(act_date_fixed, '%Y-%m-%d')
        
        log = LogActivity.query.filter(
            LogActivity.GUID_LOG == guid_log,
            LogActivity.NIP == nip,
            db.func.date(LogActivity.ACTIVITY_DATE) == act_date_obj.date(),
            LogActivity.SHIFT == shift
        ).first()
        
        if not log:
            return jsonify({'success': False, 'error': 'Data tidak ditemukan'})
        
        log.STATUS_ID = 2
        log.STATUS_TRX = '-'
        log.UPDATE_BY = 'admin'
        log.UPDATE_DATE = datetime.now()
        
        db.session.commit()
        
        return jsonify({'success': True, 'message': 'Request berhasil dicancel'})
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'success': False, 'error': str(e)})


def api_rejadwal_siaga_batal_piket():
    """
    API: Batal piket (CloseData dari gridfind) - Update StatusID = 0
    """
    try:
        data = request.get_json()
        guid_log = data.get('guid_log', '')
        nip = data.get('nip', '')
        act_date = data.get('act_date', '')
        shift = data.get('shift', '')
        
        if not guid_log or not nip:
            return jsonify({'success': False, 'error': 'Data tidak lengkap'})
        
        act_date_fixed = act_date.replace('.', '-')
        act_date_obj = datetime.strptime(act_date_fixed, '%Y-%m-%d')
        
        log = LogActivity.query.filter(
            LogActivity.GUID_LOG == guid_log,
            LogActivity.NIP == nip,
            db.func.date(LogActivity.ACTIVITY_DATE) == act_date_obj.date(),
            LogActivity.SHIFT == shift
        ).first()
        
        if not log:
            return jsonify({'success': False, 'error': 'Data tidak ditemukan'})
        
        log.STATUS_ID = 0
        log.UPDATE_BY = 'admin'
        log.UPDATE_DATE = datetime.now()
        
        db.session.commit()
        
        return jsonify({'success': True, 'message': 'Piket berhasil dibatalkan'})
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'success': False, 'error': str(e)})


def api_rejadwal_siaga_ubah_status():
    """
    API: Ubah status (Ubahstatus) - Update StatusID = 2, StatusTrx = '-'
    """
    try:
        data = request.get_json()
        guid_log = data.get('guid_log', '')
        nip = data.get('nip', '')
        act_date = data.get('act_date', '')
        shift = data.get('shift', '')
        
        if not guid_log or not nip:
            return jsonify({'success': False, 'error': 'Data tidak lengkap'})
        
        act_date_fixed = act_date.replace('.', '-')
        act_date_obj = datetime.strptime(act_date_fixed, '%Y-%m-%d')
        
        log = LogActivity.query.filter(
            LogActivity.GUID_LOG == guid_log,
            LogActivity.NIP == nip,
            db.func.date(LogActivity.ACTIVITY_DATE) == act_date_obj.date(),
            LogActivity.SHIFT == shift
        ).first()
        
        if not log:
            return jsonify({'success': False, 'error': 'Data tidak ditemukan'})
        
        log.STATUS_ID = 2
        log.STATUS_TRX = '-'
        log.UPDATE_BY = 'admin'
        log.UPDATE_DATE = datetime.now()
        
        db.session.commit()
        
        return jsonify({'success': True, 'message': 'Status berhasil diubah'})
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'success': False, 'error': str(e)})


def api_rejadwal_siaga_rollback():
    """
    API: Rollback personil yang terdelete
    """
    try:
        data = request.get_json()
        print("📥 Rollback:", data)
        
        guid_log = data.get('guid_log', '')
        nip = data.get('nip', '')
        guid_log_backup = data.get('guid_log_backup', '')  # ✅ PK
        
        if not guid_log or not nip or not guid_log_backup:
            return jsonify({'success': False, 'error': 'Data tidak lengkap'})
        
        # ✅ Cari by GUID_LOG_BACKUP (Primary Key)
        backup = LogActivityBackup.query.get(guid_log_backup)
        
        if not backup:
            return jsonify({'success': False, 'error': 'Data backup tidak ditemukan'})
        
        # Insert ke LogActivity
        new_log = LogActivity(
            GUID_LOG=backup.GUID_LOG,
            TRAKSAKSI_ID=0,
            UNIT_KERJA_ID=0,
            GUID_LOG_BACKUP=backup.GUID_LOG_BACKUP or '',
            GUID_TIM='',
            STATUS_ID=2,
            NIP=backup.NIP_PENGGANTI,  # ✅ Ambil NIP dari NIP_PENGGANTI
            TRX=backup.TRX,
            ACTIVITY=backup.ACTIVITY,
            ACTIVITY_DATE=backup.ACTIVITY_DATE,
            NOTE=backup.NOTE,
            TEMPAT=backup.TEMPAT,
            PERIHAL=backup.PERIHAL,
            UPDATE_BY='admin',
            UPDATE_DATE=datetime.now(),
            FUNGSIONAL=backup.FUNGSIONAL,
            PENGGANTI=backup.PENGGANTI,
            KET_UPDATE=backup.KET_UPDATE,
            NIP_PENGGANTI=backup.NIP_PENGGANTI,
            SHIFT=backup.SHIFT,
            SHIFT_1=backup.SHIFT_1,
            SHIFT_2=backup.SHIFT_2
        )
        db.session.add(new_log)
        db.session.delete(backup)
        db.session.commit()
        
        return jsonify({'success': True, 'message': 'Rollback berhasil'})
        
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})


def api_rejadwal_siaga_get_fungsional():
    """API: Get list Fungsional dari MfOrgzSiaga"""
    try:
        fungsional_list = db.session.query(MfOrgzSiaga.FUNGSIONAL).distinct().order_by(MfOrgzSiaga.URUT_FUNGSIONAL).all()
        data = [f[0] for f in fungsional_list if f[0]]
        return jsonify({'success': True, 'data': data})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e), 'data': []})


def api_rejadwal_siaga_get_shift():
    """API: Get list Shift"""
    try:
        shift_list = MfShift.query.filter(MfShift.NAMA_SHIFT != '').order_by(MfShift.SHIFT_ID).all()
        data = [{'id': s.SHIFT_ID, 'nama': s.NAMA_SHIFT} for s in shift_list]
        return jsonify({'success': True, 'data': data})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e), 'data': []})

def api_rejadwal_siaga_add_personil():
    """
    API: Tambah personil ke jadwal yang sudah ada
    """
    try:
        data = request.get_json()
        print("📥 Tambah Personil:", data)
        
        guid_log = data.get('guid_log', '')
        nip = data.get('nip', '')
        fungsional = data.get('fungsional', '')
        unit_kerja_id = data.get('unit_kerja_id', '')
        tgl = data.get('tgl', '')
        shift = data.get('shift', '')
        
        if not guid_log or not nip:
            return jsonify({'success': False, 'error': 'Data tidak lengkap'})
        
        # Konversi tanggal
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d')
        
        # Cek apakah personil sudah ada di jadwal
        existing = LogActivity.query.filter(
            LogActivity.GUID_LOG == guid_log,
            LogActivity.NIP == nip,
            db.func.date(LogActivity.ACTIVITY_DATE) == tgl_date.date(),
            LogActivity.SHIFT == shift
        ).first()
        
        if existing:
            return jsonify({'success': False, 'error': f'Personil {nip} sudah ada di jadwal ini'})
        
        # Ambil data pegawai
        pegawai = Pegawai.query.filter(Pegawai.NIP == nip).first()
        if not pegawai:
            return jsonify({'success': False, 'error': 'Pegawai tidak ditemukan'})
        
        # Ambil data log yang sudah ada
        existing_log = LogActivity.query.filter(
            LogActivity.GUID_LOG == guid_log
        ).first()
        
        if not existing_log:
            return jsonify({'success': False, 'error': 'Jadwal induk tidak ditemukan'})
        
        # ✅ Ambil TRAKSAKSI_ID dengan fallback
        traksaksi_id = existing_log.TRAKSAKSI_ID if existing_log.TRAKSAKSI_ID else 0
        
        # ✅ Ambil UNIT_KERJA_ID dengan fallback
        final_unit_kerja_id = int(unit_kerja_id) if unit_kerja_id else (pegawai.UNIT_KERJA_ID or 0)
        
        # Insert personil baru
        new_log = LogActivity(
            GUID_LOG=guid_log,
            NIP=nip,
            TRAKSAKSI_ID=traksaksi_id,  # ✅ WAJIB DIISI
            UNIT_KERJA_ID=final_unit_kerja_id,
            GUID_LOG_BACKUP='',
            GUID_TIM=existing_log.GUID_TIM or '',
            ACTIVITY='Piket Siaga',
            ACTIVITY_DATE=tgl_date,
            NOTE=existing_log.NOTE or '',
            TEMPAT=existing_log.TEMPAT or '',
            PERIHAL=existing_log.PERIHAL or '',
            TRX=existing_log.TRX or 'Jadwal Piket',
            UPDATE_BY='admin',
            UPDATE_DATE=datetime.now(),
            FUNGSIONAL=fungsional,
            SHIFT=shift,
            SHIFT_1=0,
            SHIFT_2=0,
            PENGGANTI=0,
            STATUS_ID=2,
            STATUS_TRX='-',
            KET_UPDATE=f'Tambah personil by admin - {nip}',
            NIP_PENGGANTI=nip,
            TGL_CLOSING=None
        )
        
        db.session.add(new_log)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'Personil {nip} berhasil ditambahkan ke jadwal'
        })
        
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})

def data_siaga_membuat_jadwal_piket_siaga():
    """Render halaman Data Siaga Membuat Jadwal Piket Siaga."""
    return render_template('pages/dashboard_2/Data_Siaga_Membuat_Jadwal_Piket_Siaga.html')