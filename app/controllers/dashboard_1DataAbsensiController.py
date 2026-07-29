# controllers/dashboard_1DataAbsensiController.py
from flask import render_template, request, jsonify
from datetime import datetime, timedelta
from collections import defaultdict
from sqlalchemy import func, text
from app import db
from app.models.absensiModel import Absensi
from app.models.lemburModel import Lembur
from app.models.pegawaiModel import Pegawai
from app.models.unitKerjaModel import MfUnitKerja
from app.models.kalenderModel import MfKalender
from app.models.potModel import MfPot
from app.models.classModel import MfClass
from app.models.dinasLuarModel import DinasLuar
from app.models.jabatanModel import MfJabatan
from app.models.timeRecorderModel import TimeRecorder
from app.models.jamKerjaModel import MfJamKerja
from app.models.dinasLuarModel import DinasLuar
import random


def data_absensi_non_finger():
    """
    Render halaman Data Absensi Non Finger.
    """
    return render_template('pages/dashboard_1/Data Absensi Non Finger.html')

def api_search_pegawai_non_finger():
    """
    API pencarian pegawai KHUSUS untuk form Absensi Non Finger.
    """
    keyword = request.args.get('keyword', '').strip()
    if len(keyword) < 2:
        return jsonify({'data': []})

    pegawai_list = (
        Pegawai.query
        .filter(Pegawai.NAMA.ilike(f'%{keyword}%'))
        .order_by(Pegawai.NAMA.asc())
        .limit(15)
        .all()
    )

    return jsonify({
        'data': [
            {'nip': p.NIP, 'nama': p.NAMA}
            for p in pegawai_list
        ]
    })

def api_absensi_non_finger_search():
    """API: Cari data absensi untuk form Non Finger (single record)"""
    try:
        nip = request.args.get('finger_id', '')  # ✅ Parameter bernama finger_id tapi isinya NIP
        tgl = request.args.get('tgl', '')
        
        if not nip or not tgl:
            return jsonify({'error': 'NIP dan Tanggal harus diisi', 'data': None})
        
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d')
        
        # ✅ Cari via NIP (bukan FINGER_ID)
        absensi = (
            db.session.query(Absensi, Pegawai)
            .join(Pegawai, Absensi.NIP == Pegawai.NIP)
            .filter(Absensi.NIP == nip)  # ✅ Pakai NIP
            .filter(db.func.date(Absensi.TGL_KERJA) == tgl_date.date())
            .first()
        )
        
        if absensi:
            a, p = absensi
            return jsonify({
                'success': True,
                'data': {
                    'finger_id': a.NIP or p.NIP,
                    'nip': a.NIP or p.NIP,
                    'nama': p.NAMA,
                    'tgl_kerja': a.TGL_KERJA.strftime('%Y-%m-%d') if a.TGL_KERJA else '',
                    'jam_in': a.TGL_JAM_IN.strftime('%H:%M') if a.TGL_JAM_IN and a.TGL_JAM_IN.year > 1900 else '',
                    'jam_out': a.TGL_JAM_OUT.strftime('%H:%M') if a.TGL_JAM_OUT and a.TGL_JAM_OUT.year > 1900 else '',
                    'jam_baku_in': a.TGL_JAM_BAKU_IN.strftime('%H:%M') if a.TGL_JAM_BAKU_IN and a.TGL_JAM_BAKU_IN.year > 1900 else '',
                    'jam_baku_out': a.TGL_JAM_BAKU_OUT.strftime('%H:%M') if a.TGL_JAM_BAKU_OUT and a.TGL_JAM_BAKU_OUT.year > 1900 else '',
                    'ket_in': a.KET_IN or '',
                    'ket_out': a.KET_OUT or '',
                    'awal_tlm': a.AWAL_TLM or 0,
                    'total_tlm': a.TOTAL_TLM or 0,
                    'total_psw': a.TOTAL_PSW or 0,
                    'tingkat_tlm': a.TINGKAT_TLM or '',
                    'tingkat_psw': a.TINGKAT_PSW or '',
                    'persen_pot_tlm': a.PERSEN_POT_TLM or 0,
                    'persen_pot_psw': a.PERSEN_POT_PSW or 0,
                    'is_in_valid': (a.IS_INVALID or '').upper() == 'Y',
                    'is_out_valid': (a.IS_OUTVALID or '').upper() == 'Y',
                    'transaksi_in': a.TRANSAKSI_IN or '',
                    'transaksi_out': a.TRANSAKSI_OUT or '',
                    'pendukung_in': a.PENDUKUNG_IN or '',
                    'pendukung_out': a.PENDUKUNG_OUT or '',
                    'update_in_by': a.UPDATE_IN_BY or '',
                    'update_in_date': a.UPDATE_IN_DATE.strftime('%d/%m/%Y %H:%M') if a.UPDATE_IN_DATE else '',
                    'update_out_by': a.UPDATE_OUT_BY or '',
                    'update_out_date': a.UPDATE_OUT_DATE.strftime('%d/%m/%Y %H:%M') if a.UPDATE_OUT_DATE else '',
                }
            })
        
        # Kalau tidak ada di ABSENSI, coba cari di TIME_RECORDER
        tr = (
            TimeRecorder.query
            .filter(TimeRecorder.KET_INJECT == nip)
            .filter(TimeRecorder.MESIN == '999')
            .filter(db.func.date(TimeRecorder.WAKTU) == tgl_date.date())
            .order_by(TimeRecorder.WAKTU.asc())
            .all()
        )
        
        if tr:
            pegawai = Pegawai.query.filter(Pegawai.NIP == nip).first()
            jam_in = ''
            jam_out = ''
            for t in tr:
                if t.STATUS == 'IN':
                    jam_in = t.WAKTU.strftime('%H:%M') if t.WAKTU else ''
                elif t.STATUS == 'OUT':
                    jam_out = t.WAKTU.strftime('%H:%M') if t.WAKTU else ''
            
            return jsonify({
                'success': True,
                'data': {
                    'finger_id': nip,
                    'nip': nip,
                    'nama': pegawai.NAMA if pegawai else '',
                    'tgl_kerja': tgl,
                    'jam_in': jam_in,
                    'jam_out': jam_out,
                    'jam_baku_in': '',
                    'jam_baku_out': '',
                    'ket_in': '',
                    'ket_out': '',
                    'awal_tlm': 0,
                    'total_tlm': 0,
                    'total_psw': 0,
                    'tingkat_tlm': '',
                    'tingkat_psw': '',
                    'persen_pot_tlm': 0,
                    'persen_pot_psw': 0,
                    'is_in_valid': True,
                    'is_out_valid': True,
                    'transaksi_in': 'MANUAL',
                    'transaksi_out': 'MANUAL',
                    'pendukung_in': 'Y',
                    'pendukung_out': 'Y',
                    'update_in_by': '',
                    'update_in_date': '',
                    'update_out_by': '',
                    'update_out_date': '',
                }
            })
        
        return jsonify({'success': True, 'data': None, 'message': 'Data tidak ditemukan'})
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e), 'data': None})


def api_absensi_non_finger_koreksi():
    """API: Koreksi/Simulasi perhitungan TLM & PSW"""
    try:
        data = request.get_json()
        tgl = data.get('tgl', '')
        jam_in = data.get('jam_in', '')
        jam_out = data.get('jam_out', '')
        shift = data.get('shift', '1')
        
        if not tgl or not jam_in or not jam_out:
            return jsonify({'error': 'Data tidak lengkap'})
        
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d')
        
        # Ambil jam baku
        hari = tgl_date.weekday()
        shift_filter = '2' if hari == 4 else '1'  # Jumat = shift 2
        
        jam_kerja = (
            MfJamKerja.query
            .filter(MfJamKerja.TGL_MULAI_BERLAKU <= tgl_date)
            .filter(MfJamKerja.SHIFT == shift_filter)
            .filter(MfJamKerja.SHIFT_KERJA == shift)
            .order_by(MfJamKerja.TGL_MULAI_BERLAKU.desc())
            .first()
        )
        
        if not jam_kerja:
            return jsonify({'error': 'Jam kerja tidak ditemukan'})
        
        baku_in = jam_kerja.STD_JAM_IN
        baku_out = jam_kerja.STD_JAM_OUT
        
        # Parse jam
        tgl_base = datetime.combine(tgl_date, datetime.min.time())
        
        if hasattr(baku_in, 'time'):
            baku_in_dt = datetime.combine(tgl_date, baku_in.time()) if baku_in.time() else tgl_base
        else:
            baku_in_str = str(baku_in)[:8] if len(str(baku_in)) > 8 else str(baku_in)
            baku_in_dt = datetime.strptime(f"{tgl} {baku_in_str}", '%Y-%m-%d %H:%M:%S') if ':' in baku_in_str else tgl_base
        
        if hasattr(baku_out, 'time'):
            baku_out_dt = datetime.combine(tgl_date, baku_out.time()) if baku_out.time() else tgl_base
        else:
            baku_out_str = str(baku_out)[:8] if len(str(baku_out)) > 8 else str(baku_out)
            baku_out_dt = datetime.strptime(f"{tgl} {baku_out_str}", '%Y-%m-%d %H:%M:%S') if ':' in baku_out_str else tgl_base
        
        tgl_in = datetime.strptime(f"{tgl} {jam_in}", '%Y-%m-%d %H:%M')
        tgl_out = datetime.strptime(f"{tgl} {jam_out}", '%Y-%m-%d %H:%M')
        
        # Hitung TLM
        diff_in = tgl_in - baku_in_dt
        awal_tlm = diff_in.total_seconds() / 60
        if tgl_in < baku_in_dt:
            awal_tlm = awal_tlm * -1
        
        # Hitung PSW
        diff_out = tgl_out - baku_out_dt
        total_psw = diff_out.total_seconds() / 60
        if tgl_out < baku_out_dt:
            total_psw = total_psw * -1
        
        # Hitung Total TLM
        if awal_tlm > 0 and awal_tlm <= 30:
            total_tlm = awal_tlm - total_psw
        else:
            total_tlm = awal_tlm
        
        # Cek libur
        kalender = MfKalender.query.filter(
            db.func.date(MfKalender.TGL_KERJA) == tgl_date.date()
        ).first()
        
        is_libur = False
        if kalender:
            is_libur = kalender.IS_LIBUR == 'Y'
        elif tgl_date.weekday() >= 5:
            is_libur = True
        
        # Tentukan tingkat & potongan
        tingkat_tlm = ''
        persen_pot_tlm = 0
        tingkat_psw = ''
        persen_pot_psw = 0
        
        if not is_libur:
            # Cari di MFPot
            potongan = MfPot.query.filter(
                MfPot.KATEGORI.in_(['TLM', 'PSW']),
                MfPot.TGL_MULAI <= tgl_date
            ).all()
            
            for pot in potongan:
                if pot.KATEGORI == 'TLM' and pot.RANGE_AWAL is not None and pot.RANGE_AKHIR is not None:
                    if pot.RANGE_AWAL <= total_tlm <= pot.RANGE_AKHIR:
                        tingkat_tlm = pot.TINGKAT or ''
                        persen_pot_tlm = pot.PERSEN_POT or 0
                        break
                elif pot.KATEGORI == 'PSW' and pot.RANGE_AWAL is not None and pot.RANGE_AKHIR is not None:
                    if pot.RANGE_AWAL <= total_psw <= pot.RANGE_AKHIR:
                        tingkat_psw = pot.TINGKAT or ''
                        persen_pot_psw = pot.PERSEN_POT or 0
                        break
            
            # Default jika tidak ada di MFPot
            if not tingkat_tlm and total_tlm > 0:
                if total_tlm <= 30:
                    tingkat_tlm = 'TLM-1'
                    persen_pot_tlm = 0.5
                elif total_tlm <= 60:
                    tingkat_tlm = 'TLM-2'
                    persen_pot_tlm = 1
                elif total_tlm <= 90:
                    tingkat_tlm = 'TLM-3'
                    persen_pot_tlm = 1.25
                elif total_tlm > 90:
                    tingkat_tlm = 'TLM-4'
                    persen_pot_tlm = 1.5
            
            if not tingkat_psw and total_psw < 0:
                if total_psw >= -30:
                    tingkat_psw = 'PSW-1'
                    persen_pot_psw = 0.5
                elif total_psw >= -60:
                    tingkat_psw = 'PSW-2'
                    persen_pot_psw = 1
                elif total_psw >= -90:
                    tingkat_psw = 'PSW-3'
                    persen_pot_psw = 1.25
                elif total_psw < -90:
                    tingkat_psw = 'PSW-4'
                    persen_pot_psw = 1.5
        
        return jsonify({
            'success': True,
            'data': {
                'jam_baku_in': baku_in_dt.strftime('%H:%M') if baku_in_dt else '',
                'jam_baku_out': baku_out_dt.strftime('%H:%M') if baku_out_dt else '',
                'awal_tlm': round(awal_tlm, 2),
                'total_tlm': round(total_tlm, 2),
                'total_psw': round(total_psw, 2),
                'tingkat_tlm': tingkat_tlm,
                'tingkat_psw': tingkat_psw,
                'persen_pot_tlm': persen_pot_tlm,
                'persen_pot_psw': persen_pot_psw,
                'is_in_valid': True,
                'is_out_valid': True,
                'is_libur': is_libur,
            }
        })
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def api_absensi_non_finger_save():
    """API: Simpan absensi non finger (single record)"""
    try:
        data = request.get_json()
        nip = data.get('finger_id', '')  # ✅ Parameter bernama finger_id tapi isinya NIP
        tgl = data.get('tgl', '')
        jam_in = data.get('jam_in', '')
        jam_out = data.get('jam_out', '')
        shift = data.get('shift', '1')
        ket_in = data.get('ket_in', '')
        ket_out = data.get('ket_out', '')
        mode = data.get('mode', 0)  # 0=IN+OUT, 1=IN only, 2=OUT only
        
        if not nip or not tgl:
            return jsonify({'error': 'NIP dan Tanggal harus diisi'})
        
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d')
        
        # Hitung shift
        tgl_cek_in = tgl_date
        tgl_cek_out = tgl_date
        if shift == '2':
            tgl_cek_out = tgl_date + timedelta(days=1)
        
        # ✅ Delete existing manual record untuk NIP ini (via KET_INJECT)
        TimeRecorder.query.filter(
            TimeRecorder.KET_INJECT == nip,
            TimeRecorder.MESIN == '999',
            db.func.date(TimeRecorder.WAKTU) == tgl_date.date()
        ).delete()
        
        # Insert IN
        if (mode in [0, 1]) and jam_in:
            tgl_jam_in = datetime.strptime(f"{tgl_cek_in.strftime('%Y-%m-%d')} {jam_in}", '%Y-%m-%d %H:%M')
            tr_in = TimeRecorder(
                FINGER_ID=0,  # Placeholder karena kolom ini NOT NULL
                WAKTU=tgl_jam_in,
                STATUS='IN',
                MESIN='999',
                KET='MANUAL',
                TRANSAKSI='MANUAL',
                KET_INJECT=nip,  # ✅ Simpan NIP di sini
                UPDATE_IN_BY='admin',
                UPDATE_DATE=datetime.now()
            )
            db.session.add(tr_in)
        
        # Insert OUT
        if (mode in [0, 2]) and jam_out:
            tgl_jam_out = datetime.strptime(f"{tgl_cek_out.strftime('%Y-%m-%d')} {jam_out}", '%Y-%m-%d %H:%M')
            tr_out = TimeRecorder(
                FINGER_ID=0,
                WAKTU=tgl_jam_out,
                STATUS='OUT',
                MESIN='999',
                KET='MANUAL',
                TRANSAKSI='MANUAL',
                KET_INJECT=nip,  # ✅ Simpan NIP di sini
                UPDATE_IN_BY='admin',
                UPDATE_DATE=datetime.now()
            )
            db.session.add(tr_out)
        
        db.session.commit()
        
        return jsonify({'success': True, 'message': 'Data berhasil disimpan'})
        
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def api_absensi_non_finger_delete():
    """API: Delete absensi non finger"""
    try:
        data = request.get_json()
        nip = data.get('finger_id', '')  # ✅ NIP
        tgl = data.get('tgl', '')
        
        if not nip or not tgl:
            return jsonify({'error': 'Data tidak lengkap'})
        
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d')
        
        # ✅ Delete by NIP di KET_INJECT
        result = TimeRecorder.query.filter(
            TimeRecorder.KET_INJECT == nip,
            TimeRecorder.MESIN == '999',
            db.func.date(TimeRecorder.WAKTU) == tgl_date.date(),
            TimeRecorder.TRANSAKSI == 'MANUAL'
        ).delete()
        
        db.session.commit()
        
        return jsonify({'success': True, 'message': f'{result} data berhasil dihapus'})
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)})


def data_absensi_normalisasi_finger():
    """
    Render halaman Data Absensi Normalisasi Absensi Finger.
    """
    return render_template('pages/dashboard_1/Data Absensi Normalisasi Absensi Finger.html')


def data_absensi_pegawai_manual():
    """
    Render halaman Data Absensi Pegawai Absensi Manual.
    """
    unit_kerja_list = MfUnitKerja.query.order_by(
        MfUnitKerja.URUT_REPORT.asc(),
        MfUnitKerja.NAMA_UNIT_KERJA.asc()
    ).all()
    return render_template(
        'pages/dashboard_1/Data Absensi Pegawai Absensi Manual.html',
        unit_kerja_list=unit_kerja_list
    )

# Tambahkan API functions:
def api_inject_absensi_get_pegawai():
    """API: Ambil daftar pegawai by unit kerja"""
    unit_kerja_id = request.args.get('unit_kerja_id', '')
    tgl = request.args.get('tgl', '')
    
    if not unit_kerja_id or not tgl:
        return jsonify({'error': 'Unit Kerja dan Tanggal harus diisi', 'data': []})
    
    try:
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d').date()
        
        # Subquery pegawai yang sedang dinas luar/sakit/cuti
        subquery = (
            db.session.query(DinasLuar.NIP)
            .filter(
                DinasLuar.TRANSAKSI.in_(['sakit', 'cuti']),
                DinasLuar.TGL_AWAL_DINAS_LUAR <= tgl_date,
                DinasLuar.TGL_AKHIR_DINAS_LUAR >= tgl_date
            )
        )
        
        pegawai_list = (
            Pegawai.query
            .filter(Pegawai.UNIT_KERJA_ID == int(unit_kerja_id))
            .filter(Pegawai.IS_KELUAR == 'N')
            .filter(~Pegawai.NIP.in_(subquery))
            .order_by(Pegawai.NAMA)
            .all()
        )
        
        return jsonify({
            'success': True,
            'data': [
                {
                    'nip': p.NIP,
                    'nama': p.NAMA,
                    'gol': p.GOL_ID or ''
                }
                for p in pegawai_list
            ]
        })
    except Exception as e:
        return jsonify({'error': str(e), 'data': []})


def api_inject_absensi_acak_jam():
    """API: Acak jam IN/OUT"""
    try:
        data = request.get_json()
        tgl = data.get('tgl', '')
        shift = data.get('shift', '1')
        pegawai_list = data.get('pegawai', [])
        acak_in = data.get('acak_in', True)
        acak_out = data.get('acak_out', True)
        
        if not tgl or not pegawai_list:
            return jsonify({'error': 'Data tidak lengkap'})
        
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d')
        
        # Ambil jam baku - PERBAIKAN: ambil semua jam kerja dulu
        jam_kerja_list = (
            MfJamKerja.query
            .filter(MfJamKerja.TGL_MULAI_BERLAKU <= tgl_date)
            .order_by(MfJamKerja.TGL_MULAI_BERLAKU.desc())
            .all()
        )
        
        if not jam_kerja_list:
            return jsonify({'error': 'Jam kerja tidak ditemukan di database'})
        
        # Gunakan jam kerja pertama sebagai default
        jam_kerja = jam_kerja_list[0]
        
        # ✅ PERBAIKAN: Ambil jam dari DateTime dengan cara yang aman
        baku_in_str = '05:00'  # Default
        baku_out_str = '17:00'  # Default
        
        if jam_kerja.STD_JAM_IN:
            if isinstance(jam_kerja.STD_JAM_IN, datetime):
                baku_in_str = jam_kerja.STD_JAM_IN.strftime('%H:%M')
            else:
                baku_in_str = str(jam_kerja.STD_JAM_IN)[:5]
        
        if jam_kerja.STD_JAM_OUT:
            if isinstance(jam_kerja.STD_JAM_OUT, datetime):
                baku_out_str = jam_kerja.STD_JAM_OUT.strftime('%H:%M')
            else:
                baku_out_str = str(jam_kerja.STD_JAM_OUT)[:5]
        
        print(f"DEBUG: Baku IN={baku_in_str}, Baku OUT={baku_out_str}")
        
        # Parse jam baku
        baku_in_parts = baku_in_str.split(':')
        baku_out_parts = baku_out_str.split(':')
        
        jam_in_hour = int(baku_in_parts[0])
        jam_in_min = int(baku_in_parts[1]) if len(baku_in_parts) > 1 else 0
        jam_out_hour = int(baku_out_parts[0])
        jam_out_min = int(baku_out_parts[1]) if len(baku_out_parts) > 1 else 0
        
        result = []
        for i, peg in enumerate(pegawai_list):
            nama = peg.get('nama', '')
            no = i + 1
            
            # Algoritma random seperti VB.NET
            konstanta = 9
            batas_max = 61
            # Hitung tambahan menit berdasarkan urutan dan nama
            tambahan = (no + konstanta + ((len(nama) + no) * no)) % batas_max
            
            if tambahan > batas_max:
                tambahan = (tambahan % konstanta) + len(nama) + (no % 19)
            
            if tambahan < 7:
                jam_pulang_tambah = tambahan + len(nama)
            else:
                jam_pulang_tambah = tambahan - (no % 7)
            
            # Hitung jam IN (mundur dari baku)
            total_menit_in = jam_in_hour * 60 + jam_in_min - tambahan
            if total_menit_in < 0:
                total_menit_in = 0
            jam_in_h = total_menit_in // 60
            jam_in_m = total_menit_in % 60
            
            # Hitung jam OUT (maju dari baku)
            total_menit_out = jam_out_hour * 60 + jam_out_min + jam_pulang_tambah
            jam_out_h = total_menit_out // 60
            jam_out_m = total_menit_out % 60
            
            result.append({
                'nip': peg.get('nip', ''),
                'nama': nama,
                'jam_in': f"{jam_in_h:02d}:{jam_in_m:02d}" if acak_in else '',
                'jam_out': f"{jam_out_h:02d}:{jam_out_m:02d}" if acak_out else '',
                'jam_baku_in': baku_in_str[:5],
                'jam_baku_out': baku_out_str[:5],
            })
        
        return jsonify({'success': True, 'data': result})
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def api_inject_absensi_save():
    """API: Simpan absensi manual"""
    try:
        data = request.get_json()
        tgl = data.get('tgl', '')
        no_surat = data.get('no_surat', '')
        keterangan = data.get('keterangan', '')
        shift = data.get('shift', '1')
        pegawai_list = data.get('pegawai', [])
        
        if not tgl or not pegawai_list:
            return jsonify({'error': 'Tanggal dan pegawai harus diisi'})
        
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d')
        saved_count = 0
        
        for peg in pegawai_list:
            nip = peg.get('nip', '')
            jam_in = peg.get('jam_in', '')
            jam_out = peg.get('jam_out', '')
            ket_in = peg.get('ket_in', keterangan)
            ket_out = peg.get('ket_out', keterangan)
            
            if not jam_in and not jam_out:
                continue
            
            # ✅ CARI FINGER_ID DARI PEGAWAI (jika ada)
            pegawai = Pegawai.query.filter(Pegawai.NIP == nip).first()
            
            # ✅ Gunakan NIP sebagai string untuk FINGER_ID (ubah tipe kolom jika perlu)
            # Atau simpan NIP di REF_INJECT untuk referensi
            finger_id_str = nip  # Simpan NIP sebagai string
            
            # Delete existing manual record for this date (by NIP in REF_INJECT)
            TimeRecorder.query.filter(
                TimeRecorder.REF_INJECT == no_surat if no_surat else True,
                TimeRecorder.MESIN == '999',
                db.func.date(TimeRecorder.WAKTU) == tgl_date.date(),
                TimeRecorder.KET_INJECT == nip  # ✅ Cari by NIP di KET_INJECT
            ).delete()
            
            # Insert IN
            if jam_in:
                tgl_jam_in = datetime.strptime(f"{tgl} {jam_in}", '%Y-%m-%d %H:%M')
                tr_in = TimeRecorder(
                    FINGER_ID=pegawai.ABSENSI_ID if pegawai else 0,  # Gunakan ABSENSI_ID atau 0
                    WAKTU=tgl_jam_in,
                    STATUS='IN',
                    MESIN='999',
                    KET='MANUAL',
                    TRANSAKSI='MANUAL',
                    KET_INJECT=nip,  # ✅ Simpan NIP di sini untuk referensi
                    REF_INJECT=no_surat or '',
                    UPDATE_IN_BY='admin',
                    UPDATE_DATE=datetime.now()
                )
                db.session.add(tr_in)
            
            # Insert OUT
            if jam_out:
                tgl_jam_out = datetime.strptime(f"{tgl} {jam_out}", '%Y-%m-%d %H:%M')
                tr_out = TimeRecorder(
                    FINGER_ID=pegawai.ABSENSI_ID if pegawai else 0,
                    WAKTU=tgl_jam_out,
                    STATUS='OUT',
                    MESIN='999',
                    KET='MANUAL',
                    TRANSAKSI='MANUAL',
                    KET_INJECT=nip,  # ✅ Simpan NIP di sini
                    REF_INJECT=no_surat or '',
                    UPDATE_IN_BY='admin',
                    UPDATE_DATE=datetime.now()
                )
                db.session.add(tr_out)
            
            saved_count += 1
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'{saved_count} data berhasil disimpan',
            'saved': saved_count
        })
        
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def data_absensi_pegawai_lembur_manual():
    """Render halaman Lembur Manual"""
    unit_kerja_list = MfUnitKerja.query.order_by(
        MfUnitKerja.URUT_REPORT.asc(),
        MfUnitKerja.NAMA_UNIT_KERJA.asc()
    ).all()
    return render_template(
        'pages/dashboard_1/Data Absensi Pegawai Lembur Manual.html',
        unit_kerja_list=unit_kerja_list
    )

def api_inject_lembur_get_pegawai():
    """API: Ambil daftar pegawai by unit kerja (untuk lembur)"""
    unit_kerja_id = request.args.get('unit_kerja_id', '')
    tgl = request.args.get('tgl', '')
    
    if not unit_kerja_id or not tgl:
        return jsonify({'error': 'Unit Kerja dan Tanggal harus diisi', 'data': []})
    
    try:
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d').date()
        
        subquery = (
            db.session.query(DinasLuar.NIP)
            .filter(
                DinasLuar.TRANSAKSI.in_(['sakit', 'cuti']),
                DinasLuar.TGL_AWAL_DINAS_LUAR <= tgl_date,
                DinasLuar.TGL_AKHIR_DINAS_LUAR >= tgl_date
            )
        )
        
        pegawai_list = (
            Pegawai.query
            .filter(Pegawai.UNIT_KERJA_ID == int(unit_kerja_id))
            .filter(Pegawai.IS_KELUAR == 'N')
            .filter(~Pegawai.NIP.in_(subquery))
            .order_by(Pegawai.NAMA)
            .all()
        )
        
        return jsonify({
            'success': True,
            'data': [{'nip': p.NIP, 'nama': p.NAMA, 'gol': p.GOL_ID or ''} for p in pegawai_list]
        })
    except Exception as e:
        return jsonify({'error': str(e), 'data': []})


def api_inject_lembur_acak_jam():
    """API: Acak jam lembur IN/OUT"""
    try:
        data = request.get_json()
        tgl = data.get('tgl', '')
        shift = data.get('shift', '1')
        pegawai_list = data.get('pegawai', [])
        acak_in = data.get('acak_in', True)
        acak_out = data.get('acak_out', True)
        
        if not tgl or not pegawai_list:
            return jsonify({'error': 'Data tidak lengkap'})
        
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d')
        
        # Ambil jam baku
        jam_kerja_list = (
            MfJamKerja.query
            .filter(MfJamKerja.TGL_MULAI_BERLAKU <= tgl_date)
            .order_by(MfJamKerja.TGL_MULAI_BERLAKU.desc())
            .all()
        )
        
        if not jam_kerja_list:
            return jsonify({'error': 'Jam kerja tidak ditemukan'})
        
        jam_kerja = jam_kerja_list[0]
        
        # Default jam lembur (pagi buta)
        baku_in_str = '05:00'
        baku_out_str = '10:30'
        
        if jam_kerja.STD_JAM_IN:
            if isinstance(jam_kerja.STD_JAM_IN, datetime):
                baku_in_str = jam_kerja.STD_JAM_IN.strftime('%H:%M')
            else:
                baku_in_str = str(jam_kerja.STD_JAM_IN)[:5]
        
        if jam_kerja.STD_JAM_OUT:
            if isinstance(jam_kerja.STD_JAM_OUT, datetime):
                baku_out_str = jam_kerja.STD_JAM_OUT.strftime('%H:%M')
            else:
                baku_out_str = str(jam_kerja.STD_JAM_OUT)[:5]
        
        baku_in_parts = baku_in_str.split(':')
        jam_in_hour = int(baku_in_parts[0])
        jam_in_min = int(baku_in_parts[1]) if len(baku_in_parts) > 1 else 0
        
        baku_out_parts = baku_out_str.split(':')
        jam_out_hour = int(baku_out_parts[0])
        jam_out_min = int(baku_out_parts[1]) if len(baku_out_parts) > 1 else 0
        
        result = []
        for i, peg in enumerate(pegawai_list):
            nama = peg.get('nama', '')
            no = i + 1
            
            # Random menit
            konstanta = 9
            batas_max = 61
            tambahan = (no + konstanta + ((len(nama) + no) * no)) % batas_max
            if tambahan > batas_max:
                tambahan = (tambahan % konstanta) + len(nama) + (no % 19)
            if tambahan < 7:
                jam_pulang_tambah = tambahan + len(nama)
            else:
                jam_pulang_tambah = tambahan - (no % 7)
            
            total_menit_in = jam_in_hour * 60 + jam_in_min - tambahan
            if total_menit_in < 0:
                total_menit_in = 0
            jam_in_h = total_menit_in // 60
            jam_in_m = total_menit_in % 60
            
            total_menit_out = jam_out_hour * 60 + jam_out_min + jam_pulang_tambah
            jam_out_h = total_menit_out // 60
            jam_out_m = total_menit_out % 60
            
            result.append({
                'nip': peg.get('nip', ''),
                'nama': nama,
                'jam_in': f"{jam_in_h:02d}:{jam_in_m:02d}" if acak_in else '',
                'jam_out': f"{jam_out_h:02d}:{jam_out_m:02d}" if acak_out else '',
                'jam_baku_in': baku_in_str[:5],
                'jam_baku_out': baku_out_str[:5],
            })
        
        return jsonify({'success': True, 'data': result})
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def api_inject_lembur_save():
    """API: Simpan lembur manual ke tabel LEMBUR"""
    try:
        data = request.get_json()
        tgl = data.get('tgl', '')
        no_surat = data.get('no_surat', '')
        keterangan = data.get('keterangan', '')
        shift = data.get('shift', '1')
        pegawai_list = data.get('pegawai', [])
        
        if not tgl or not pegawai_list:
            return jsonify({'error': 'Tanggal dan pegawai harus diisi'})
        
        tgl_date = datetime.strptime(tgl, '%Y-%m-%d')
        saved_count = 0
        
        for peg in pegawai_list:
            nip = peg.get('nip', '')
            jam_in = peg.get('jam_in', '')
            jam_out = peg.get('jam_out', '')
            jam_baku_in = peg.get('jam_baku_in', '')
            jam_baku_out = peg.get('jam_baku_out', '')
            ket = peg.get('ket_out', keterangan)
            
            if not jam_in and not jam_out:
                continue
            
            # Cek existing di tabel LEMBUR
            existing = Lembur.query.filter(
                Lembur.NIP == nip,
                db.func.date(Lembur.TGL_KERJA) == tgl_date.date()
            ).first()
            
            tgl_jam_in = datetime.strptime(f"{tgl} {jam_in}", '%Y-%m-%d %H:%M') if jam_in else None
            tgl_jam_out = datetime.strptime(f"{tgl} {jam_out}", '%Y-%m-%d %H:%M') if jam_out else None
            tgl_jam_baku_in = datetime.strptime(f"{tgl} {jam_baku_in}", '%Y-%m-%d %H:%M') if jam_baku_in else None
            tgl_jam_baku_out = datetime.strptime(f"{tgl} {jam_baku_out}", '%Y-%m-%d %H:%M') if jam_baku_out else None
            
            if existing:
                # Update
                if jam_in:
                    existing.JAM_IN = tgl_jam_in
                    existing.JAM_BAKU_IN = tgl_jam_baku_in
                if jam_out:
                    existing.JAM_OUT = tgl_jam_out
                    existing.JAM_BAKU_OUT = tgl_jam_baku_out
                existing.KETERANGAN = ket
                existing.NO_SURAT = no_surat
                existing.UPDATE_BY = 'admin'
                existing.UPDATE_DATE = datetime.now()
            else:
                # Insert
                lembur = Lembur(
                    NIP=nip,
                    TGL_KERJA=tgl_date,
                    JAM_IN=tgl_jam_in,
                    JAM_OUT=tgl_jam_out,
                    JAM_BAKU_IN=tgl_jam_baku_in,
                    JAM_BAKU_OUT=tgl_jam_baku_out,
                    KETERANGAN=ket,
                    NO_SURAT=no_surat,
                    UPDATE_BY='admin',
                    UPDATE_DATE=datetime.now()
                )
                db.session.add(lembur)
            
            saved_count += 1
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'{saved_count} data lembur berhasil disimpan',
            'saved': saved_count
        })
        
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def data_absensi_trace_tunjangan():
    """
    Render halaman Data Absensi Trace Tunjangan.
    """
    from app.models.unitKerjaModel import MfUnitKerja
    unit_kerja_list = MfUnitKerja.query.order_by(
        MfUnitKerja.URUT_REPORT.asc(),
        MfUnitKerja.NAMA_UNIT_KERJA.asc()
    ).all()
    return render_template(
        'pages/dashboard_1/Data Absensi Trace Tunjangan.html',
        unit_kerja_list=unit_kerja_list
    )

def api_trace_tunjangan():
    """
    API Trace Tunjangan - sesuai VB.NET TraceTunKin.aspx
    """
    try:
        tgl_awal_str = request.args.get('tgl_awal', '')
        tgl_akhir_str = request.args.get('tgl_akhir', '')
        unit_kerja_ids = request.args.getlist('unit_kerja[]')
        
        if not tgl_awal_str or not tgl_akhir_str:
            return jsonify({'error': 'Tanggal periode kosong', 'data': []})
        
        tgl_awal = datetime.strptime(tgl_awal_str, '%Y-%m-%d')
        tgl_akhir = datetime.strptime(tgl_akhir_str, '%Y-%m-%d')
        tgl_akhir_date = tgl_akhir.date()
        tgl_awal_date = tgl_awal.date()
        
        # Cek tgl server
        tgl_server = datetime.now()
        if tgl_server.date() < tgl_awal_date:
            return jsonify({'error': 'Tgl server lebih kecil dari tgl awal periode', 'data': []})
        if tgl_server.date() < tgl_akhir_date:
            tgl_akhir = tgl_server
            tgl_akhir_date = tgl_akhir.date()
        
        # 1. Ambil kalender
        kalender_rows = (
            MfKalender.query
            .filter(MfKalender.TGL_KERJA.between(tgl_awal, tgl_akhir))
            .all()
        )
        
        # 2. Ambil absensi (JOIN via NIP)
        absensi_query = (
            db.session.query(Absensi, Pegawai)
            .join(Pegawai, Absensi.NIP == Pegawai.NIP)
            .join(MfKalender, Absensi.TGL_KERJA == MfKalender.TGL_KERJA)
            .filter(Absensi.TGL_KERJA.between(tgl_awal, tgl_akhir))
            .filter(MfKalender.IS_LIBUR == 'N')
        )
        if unit_kerja_ids:
            absensi_query = absensi_query.filter(Pegawai.UNIT_KERJA_ID.in_(unit_kerja_ids))
        absensi_rows = absensi_query.all()
        
        # 3. Ambil pegawai dengan tunjangan & jabatan
        pegawai_query = (
            db.session.query(Pegawai, MfUnitKerja, MfJabatan)
            .join(MfUnitKerja, Pegawai.UNIT_KERJA_ID == MfUnitKerja.UNIT_KERJA_ID)
            .outerjoin(MfJabatan, Pegawai.JABATAN_ID == MfJabatan.JABATAN_ID)
            .filter(
                Pegawai.TGL_MASUK <= tgl_akhir,
                db.or_(
                    Pegawai.IS_KELUAR == 'N',
                    db.and_(Pegawai.IS_KELUAR == 'Y', Pegawai.TGL_KELUAR >= tgl_awal)
                )
            )
        )
        if unit_kerja_ids:
            pegawai_query = pegawai_query.filter(Pegawai.UNIT_KERJA_ID.in_(unit_kerja_ids))
        
        pegawai_rows = pegawai_query.order_by(
            MfJabatan.URUT_JABATAN.asc(),
            Pegawai.CLASS_ID.desc(),
            Pegawai.NIP.asc()
        ).all()
        
        if not pegawai_rows:
            return jsonify({'error': 'Data pegawai tidak ditemukan', 'data': []})
        
        # 4. Ambil MFPot
        potongan_list = (
            MfPot.query
            .filter(MfPot.TGL_MULAI <= tgl_akhir_date)
            .all()
        )
        
        # 5. Ambil DinasLuar > 4 bulan
        dinas_luar_rows = (
            db.session.query(DinasLuar, Pegawai)
            .join(Pegawai, DinasLuar.NIP == Pegawai.NIP)
            .filter(DinasLuar.TRANSAKSI == 'DinasLuar')
            .filter(DinasLuar.STATUS_UM == 1)
            .filter(DinasLuar.TGL_AWAL_DINAS_LUAR <= tgl_akhir)
            .filter(DinasLuar.TGL_AKHIR_DINAS_LUAR >= tgl_awal)
        )
        if unit_kerja_ids:
            dinas_luar_rows = dinas_luar_rows.filter(Pegawai.UNIT_KERJA_ID.in_(unit_kerja_ids))
        dinas_luar_rows = dinas_luar_rows.all()
        
        # Build dict absensi per NIP
        absensi_dict = defaultdict(list)
        for a, p in absensi_rows:
            if a.NIP:
                absensi_dict[a.NIP.strip()].append(a)
        
        # Build dict DL per NIP
        dl_dict = defaultdict(list)
        for dl, p in dinas_luar_rows:
            if dl.NIP:
                dl_dict[dl.NIP.strip()].append(dl)
        
        # Ambil tunjangan per class
        class_tunjangan = {}
        for c in MfClass.query.filter(MfClass.TGL_MULAI <= tgl_akhir_date).order_by(MfClass.TGL_MULAI.desc()).all():
            if c.CLASS_ID not in class_tunjangan:
                class_tunjangan[c.CLASS_ID] = c.TUNJANGAN or 0
        
        # Hitung per pegawai
        data = []
        no = 1
        
        for peg, unit, jabatan in pegawai_rows:
            abs_list = absensi_dict.get((peg.NIP or '').strip(), [])
            dl_list = dl_dict.get((peg.NIP or '').strip(), [])
            tunjangan = class_tunjangan.get(peg.CLASS_ID, 0)
            
            # Hitung persen potongan
            persen_pot = 0
            tgl_masuk = peg.TGL_MASUK
            tgl_hitung = tgl_masuk if tgl_masuk and tgl_masuk > tgl_awal else tgl_awal
            
            d = tgl_hitung
            while d.date() <= tgl_akhir_date:
                tgl_str = d.strftime('%Y-%m-%d')
                
                # Cek libur
                is_libur = False
                kl = [k for k in kalender_rows if k.TGL_KERJA and k.TGL_KERJA.strftime('%Y-%m-%d') == tgl_str]
                if kl:
                    is_libur = kl[0].IS_LIBUR == 'Y'
                elif d.weekday() >= 5:
                    is_libur = True
                
                if not is_libur:
                    # Cari absensi untuk tanggal ini
                    a = None
                    for abs_item in abs_list:
                        if abs_item.TGL_KERJA and abs_item.TGL_KERJA.strftime('%Y-%m-%d') == tgl_str:
                            a = abs_item
                            break
                    
                    if a:
                        transaksi = (a.TRANSAKSI_IN or '').strip().lower()
                        if transaksi in ('alpa', 'sakit', 'ijin'):
                            persen_pot += a.PERSEN_POT_TLM or 0
                        elif transaksi == 'dinasluar':
                            pass  # Tidak ada potongan untuk DL
                        else:
                            persen_pot += (a.PERSEN_POT_TLM or 0) + (a.PERSEN_POT_PSW or 0)
                    else:
                        # TA - cari potongan TA di MFPot
                        for pot in potongan_list:
                            if pot.KATEGORI == 'TA':
                                persen_pot += pot.PERSEN_POT or 0
                                break
                    
                    # DL > 4 bulan
                    for dl in dl_list:
                        if dl.TGL_AWAL_DINAS_LUAR:
                            limit_dl = dl.TGL_AWAL_DINAS_LUAR + timedelta(days=120)
                            tgl_akhir_dl = dl.TGL_AKHIR_DINAS_LUAR.date() if dl.TGL_AKHIR_DINAS_LUAR else d.date()
                            if limit_dl.date() <= d.date() <= tgl_akhir_dl:
                                for pot in potongan_list:
                                    if pot.KATEGORI == 'DINASLUAR':
                                        persen_pot += pot.PERSEN_POT or 0
                                        break
                
                d += timedelta(days=1)
            
            # Hitung nilai
            nilai_pot = tunjangan * (persen_pot / 100) if persen_pot > 0 else 0
            jumlah_dibayar = tunjangan - nilai_pot
            
            data.append({
                'no': no,
                'nip': peg.NIP or '',
                'nama': peg.NAMA or '',
                'status_peg': 'PNS' if peg.STATUS_PEG == 1 else 'Non PNS',
                'jabatan': jabatan.NAMA_JABATAN if jabatan else '-',
                'tmt_jabatan': peg.TMT_JABATAN.strftime('%d/%m/%Y') if peg.TMT_JABATAN else '-',
                'class_id': peg.CLASS_ID or '',
                'tunjangan': tunjangan,
                'persen_pot': round(persen_pot, 2),
                'nilai_pot': round(nilai_pot, 2),
                'jumlah_dibayar': round(jumlah_dibayar, 2),
            })
            no += 1
        
        return jsonify({
            'success': True,
            'data': data,
            'total': len(data)
        })
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e), 'data': []})


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

def api_cari_absensi_non_finger():
    """
    API Cari Absensi Non Finger - mencari data TimeRecorder 
    MESIN='999' (data inject manual saja)
    """
    try:
        tgl_awal_str = request.args.get('tgl_awal', '')
        tgl_akhir_str = request.args.get('tgl_akhir', '')
        filter_field1 = request.args.get('filter_field1', '')
        filter_value1 = request.args.get('filter_value1', '')
        filter_field2 = request.args.get('filter_field2', '')
        filter_value2 = request.args.get('filter_value2', '')
        
        # ✅ HANYA data inject manual (MESIN='999')
        query = (
            db.session.query(TimeRecorder, Pegawai, MfUnitKerja)
            .outerjoin(Pegawai, TimeRecorder.KET_INJECT == Pegawai.NIP)
            .outerjoin(MfUnitKerja, Pegawai.UNIT_KERJA_ID == MfUnitKerja.UNIT_KERJA_ID)
            .filter(TimeRecorder.MESIN == '999')  # ✅ Hanya data manual
            .filter(TimeRecorder.STATUS.in_(['IN', 'OUT']))
        )
        
        # Filter periode
        if tgl_awal_str and tgl_akhir_str:
            tgl_awal = datetime.strptime(tgl_awal_str, '%Y-%m-%d')
            tgl_akhir = datetime.strptime(tgl_akhir_str, '%Y-%m-%d') + timedelta(days=1)
            query = query.filter(
                TimeRecorder.WAKTU >= tgl_awal,
                TimeRecorder.WAKTU < tgl_akhir
            )
        
        # Field mapping untuk filter tambahan
        field_mapping = {
            'NIP': Pegawai.NIP,
            'Nama': Pegawai.NAMA,
            'UnitKerjaName': MfUnitKerja.NAMA_UNIT_KERJA,
            'Status': TimeRecorder.STATUS,
        }
        
        if filter_field1 and filter_value1:
            field = field_mapping.get(filter_field1)
            if field is not None:
                query = query.filter(field.ilike(f'%{filter_value1}%'))
        
        if filter_field2 and filter_value2:
            field = field_mapping.get(filter_field2)
            if field is not None:
                query = query.filter(field.ilike(f'%{filter_value2}%'))
        
        # Order
        query = query.order_by(TimeRecorder.WAKTU.desc())
        results = query.all()
        
        # Format data
        data = []
        for i, (tr, peg, unit) in enumerate(results, 1):
            data.append({
                'no': i,
                'nama': peg.NAMA if peg else '-',
                'nip': peg.NIP if peg else (tr.KET_INJECT or str(tr.FINGER_ID)),
                'finger_id': tr.FINGER_ID or '',
                'tanggal': tr.WAKTU.strftime('%d %b %Y') if tr.WAKTU else '',
                'jam': tr.WAKTU.strftime('%H:%M:%S') if tr.WAKTU else '',
                'waktu_raw': tr.WAKTU.strftime('%Y-%m-%d %H:%M:%S') if tr.WAKTU else '',
                'status': tr.STATUS or '',
                'transaksi': tr.TRANSAKSI or tr.KET or '',
                'mesin': tr.MESIN or '',
                'unit_kerja': unit.NAMA_UNIT_KERJA if unit else '-',
                'update_by': tr.UPDATE_IN_BY or '',
                'update_date': tr.UPDATE_DATE.strftime('%d/%m/%Y %H:%M') if tr.UPDATE_DATE else '',
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


def cari_absensi_normalisasi_finger():
    """Render halaman Cari Absensi Normalisasi Absensi Finger."""
    return render_template('pages/dashboard_1/Cari Absensi Normalisasi Absensi Finger.html')


def cari_absensi_pegawai_manual():
    """Render halaman Cari Absensi Pegawai Absen Manual."""
    return render_template('pages/dashboard_1/Cari Absensi Pegawai Absen Manual.html')

def api_cari_absensi_manual():
    """
    API Cari Absensi Manual - mencari data TimeRecorder dengan MESIN='999'
    Join via KET_INJECT (NIP) ke PEGAWAI
    """
    try:
        tgl_awal_str = request.args.get('tgl_awal', '')
        tgl_akhir_str = request.args.get('tgl_akhir', '')
        filter_field1 = request.args.get('filter_field1', '')
        filter_value1 = request.args.get('filter_value1', '')
        filter_field2 = request.args.get('filter_field2', '')
        filter_value2 = request.args.get('filter_value2', '')
        
        # ✅ JOIN via KET_INJECT (tempat NIP disimpan)
        query = (
            db.session.query(TimeRecorder, Pegawai, MfUnitKerja)
            .outerjoin(Pegawai, TimeRecorder.KET_INJECT == Pegawai.NIP)
            .outerjoin(MfUnitKerja, Pegawai.UNIT_KERJA_ID == MfUnitKerja.UNIT_KERJA_ID)
            .filter(TimeRecorder.MESIN == '999')
            .filter(TimeRecorder.STATUS.in_(['IN', 'OUT']))
        )
        
        # Filter periode
        if tgl_awal_str and tgl_akhir_str:
            tgl_awal = datetime.strptime(tgl_awal_str, '%Y-%m-%d')
            tgl_akhir = datetime.strptime(tgl_akhir_str, '%Y-%m-%d') + timedelta(days=1)
            query = query.filter(
                TimeRecorder.WAKTU >= tgl_awal,
                TimeRecorder.WAKTU < tgl_akhir
            )
        
        # Field mapping
        field_mapping = {
            'NIP': Pegawai.NIP,
            'Nama': Pegawai.NAMA,
            'UnitKerjaName': MfUnitKerja.NAMA_UNIT_KERJA,
            'Status': TimeRecorder.STATUS,
            'UpdateBy': TimeRecorder.UPDATE_IN_BY,
        }
        
        if filter_field1 and filter_value1:
            field = field_mapping.get(filter_field1)
            if field is not None:
                query = query.filter(field.ilike(f'%{filter_value1}%'))
        
        if filter_field2 and filter_value2:
            field = field_mapping.get(filter_field2)
            if field is not None:
                query = query.filter(field.ilike(f'%{filter_value2}%'))
        
        query = query.order_by(TimeRecorder.WAKTU.desc())
        results = query.all()
        
        data = []
        for i, (tr, peg, unit) in enumerate(results, 1):
            data.append({
                'no': i,
                'nama': peg.NAMA if peg else '-',
                'nip': peg.NIP if peg else (tr.KET_INJECT or tr.FINGER_ID),
                'finger_id': tr.FINGER_ID or '',
                'tanggal': tr.WAKTU.strftime('%d %b %Y') if tr.WAKTU else '',
                'jam': tr.WAKTU.strftime('%H:%M:%S') if tr.WAKTU else '',
                'waktu_raw': tr.WAKTU.strftime('%Y-%m-%d %H:%M:%S') if tr.WAKTU else '',
                'status': tr.STATUS or '',
                'transaksi': tr.TRANSAKSI or tr.KET or '',
                'update_by': tr.UPDATE_IN_BY or '',
                'update_date': tr.UPDATE_DATE.strftime('%d/%m/%Y %H:%M') if tr.UPDATE_DATE else '',
                'unit_kerja': unit.NAMA_UNIT_KERJA if unit else '-',
                'ket_inject': tr.KET_INJECT or '',
                'ref_inject': tr.REF_INJECT or '',
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


def api_cari_absensi_manual_delete():
    """API: Delete data absensi manual"""
    try:
        data = request.get_json()
        finger_id = data.get('finger_id', '')
        waktu = data.get('waktu', '')
        
        if not finger_id or not waktu:
            return jsonify({'error': 'Data tidak lengkap'})
        
        # Delete dari TimeRecorder
        result = TimeRecorder.query.filter(
            TimeRecorder.FINGER_ID == finger_id,
            TimeRecorder.WAKTU == datetime.strptime(waktu, '%Y-%m-%d %H:%M:%S'),
            TimeRecorder.MESIN == '999',
            TimeRecorder.KET == 'MANUAL'
        ).delete()
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'{result} data berhasil dihapus'
        })
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)})


def api_cari_absensi_manual_update():
    """API: Update data absensi manual (jam saja)"""
    try:
        data = request.get_json()
        finger_id = data.get('finger_id', '')
        waktu_lama = data.get('waktu_lama', '')
        jam_baru = data.get('jam_baru', '')
        status = data.get('status', '')
        
        if not finger_id or not waktu_lama or not jam_baru:
            return jsonify({'error': 'Data tidak lengkap'})
        
        tgl = datetime.strptime(waktu_lama, '%Y-%m-%d %H:%M:%S').strftime('%Y-%m-%d')
        waktu_baru = datetime.strptime(f"{tgl} {jam_baru}", '%Y-%m-%d %H:%M:%S')
        
        # Delete old record
        TimeRecorder.query.filter(
            TimeRecorder.FINGER_ID == finger_id,
            TimeRecorder.WAKTU == datetime.strptime(waktu_lama, '%Y-%m-%d %H:%M:%S'),
            TimeRecorder.MESIN == '999'
        ).delete()
        
        # Insert new record
        tr = TimeRecorder(
            FINGER_ID=finger_id,
            WAKTU=waktu_baru,
            STATUS=status,
            MESIN='999',
            KET='MANUAL',
            TRANSAKSI='MANUAL',
            UPDATE_IN_BY='admin',
            UPDATE_DATE=datetime.now()
        )
        db.session.add(tr)
        db.session.commit()
        
        return jsonify({'success': True, 'message': 'Data berhasil diupdate'})
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)})


def cari_absensi_pegawai_lembur_manual():
    """Render halaman Cari Absensi Pegawai Lembur Manual."""
    return render_template('pages/dashboard_1/Cari Absensi Pegawai Lembur Manual.html')

def api_cari_lembur_manual():
    """
    API Cari Lembur Manual - mencari data dari tabel LEMBUR
    Join via NIP ke PEGAWAI
    """
    try:
        tgl_awal_str = request.args.get('tgl_awal', '')
        tgl_akhir_str = request.args.get('tgl_akhir', '')
        filter_field1 = request.args.get('filter_field1', '')
        filter_value1 = request.args.get('filter_value1', '')
        filter_field2 = request.args.get('filter_field2', '')
        filter_value2 = request.args.get('filter_value2', '')
        
        # Query dari tabel LEMBUR join ke PEGAWAI via NIP
        query = (
            db.session.query(Lembur, Pegawai, MfUnitKerja)
            .join(Pegawai, Lembur.NIP == Pegawai.NIP)
            .join(MfUnitKerja, Pegawai.UNIT_KERJA_ID == MfUnitKerja.UNIT_KERJA_ID)
        )
        
        # Filter periode
        if tgl_awal_str and tgl_akhir_str:
            tgl_awal = datetime.strptime(tgl_awal_str, '%Y-%m-%d')
            tgl_akhir = datetime.strptime(tgl_akhir_str, '%Y-%m-%d') + timedelta(days=1)
            query = query.filter(
                Lembur.TGL_KERJA >= tgl_awal,
                Lembur.TGL_KERJA < tgl_akhir
            )
        
        # Field mapping untuk filter tambahan
        field_mapping = {
            'NIP': Pegawai.NIP,
            'Nama': Pegawai.NAMA,
            'UnitKerjaName': MfUnitKerja.NAMA_UNIT_KERJA,
            'Keterangan': Lembur.KETERANGAN,
            'NoSurat': Lembur.NO_SURAT,
        }
        
        if filter_field1 and filter_value1:
            field = field_mapping.get(filter_field1)
            if field is not None:
                query = query.filter(field.ilike(f'%{filter_value1}%'))
        
        if filter_field2 and filter_value2:
            field = field_mapping.get(filter_field2)
            if field is not None:
                query = query.filter(field.ilike(f'%{filter_value2}%'))
        
        # Order
        query = query.order_by(Lembur.TGL_KERJA.desc(), Pegawai.NAMA)
        results = query.all()
        
        # Format data
        data = []
        for i, (lembur, peg, unit) in enumerate(results, 1):
            data.append({
                'no': i,
                'id': lembur.id,
                'nama': peg.NAMA or '',
                'nip': peg.NIP or '',
                'tgl_kerja': lembur.TGL_KERJA.strftime('%d %b %Y') if lembur.TGL_KERJA else '',
                'jam_in': lembur.JAM_IN.strftime('%H:%M') if lembur.JAM_IN else '-',
                'jam_out': lembur.JAM_OUT.strftime('%H:%M') if lembur.JAM_OUT else '-',
                'jam_baku_in': lembur.JAM_BAKU_IN.strftime('%H:%M') if lembur.JAM_BAKU_IN else '-',
                'jam_baku_out': lembur.JAM_BAKU_OUT.strftime('%H:%M') if lembur.JAM_BAKU_OUT else '-',
                'keterangan': lembur.KETERANGAN or '',
                'no_surat': lembur.NO_SURAT or '',
                'unit_kerja': unit.NAMA_UNIT_KERJA if unit else '-',
                'update_by': lembur.UPDATE_BY or '',
                'update_date': lembur.UPDATE_DATE.strftime('%d/%m/%Y %H:%M') if lembur.UPDATE_DATE else '',
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


def api_cari_lembur_manual_delete():
    """API: Delete data lembur manual"""
    try:
        data = request.get_json()
        lembur_id = data.get('id', '')
        
        if not lembur_id:
            return jsonify({'error': 'ID tidak ditemukan'})
        
        result = Lembur.query.filter(Lembur.id == int(lembur_id)).delete()
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'{result} data berhasil dihapus'
        })
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)})


def api_cari_lembur_manual_update():
    """API: Update data lembur manual"""
    try:
        data = request.get_json()
        lembur_id = data.get('id', '')
        jam_in = data.get('jam_in', '')
        jam_out = data.get('jam_out', '')
        keterangan = data.get('keterangan', '')
        no_surat = data.get('no_surat', '')
        
        if not lembur_id:
            return jsonify({'error': 'ID tidak ditemukan'})
        
        lembur = Lembur.query.get(int(lembur_id))
        if not lembur:
            return jsonify({'error': 'Data tidak ditemukan'})
        
        if jam_in:
            tgl = lembur.TGL_KERJA.strftime('%Y-%m-%d') if lembur.TGL_KERJA else datetime.now().strftime('%Y-%m-%d')
            lembur.JAM_IN = datetime.strptime(f"{tgl} {jam_in}", '%Y-%m-%d %H:%M')
        if jam_out:
            tgl = lembur.TGL_KERJA.strftime('%Y-%m-%d') if lembur.TGL_KERJA else datetime.now().strftime('%Y-%m-%d')
            lembur.JAM_OUT = datetime.strptime(f"{tgl} {jam_out}", '%Y-%m-%d %H:%M')
        if keterangan:
            lembur.KETERANGAN = keterangan
        if no_surat:
            lembur.NO_SURAT = no_surat
        
        lembur.UPDATE_BY = 'admin'
        lembur.UPDATE_DATE = datetime.now()
        db.session.commit()
        
        return jsonify({'success': True, 'message': 'Data berhasil diupdate'})
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)})