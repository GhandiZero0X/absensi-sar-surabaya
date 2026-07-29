# controllers/dashboard_1DataAbsensiController.py
from flask import render_template, request, jsonify
from datetime import datetime, timedelta
from collections import defaultdict
from sqlalchemy import func, text
from app import db
from app.models.absensiModel import Absensi
from app.models.pegawaiModel import Pegawai
from app.models.unitKerjaModel import MfUnitKerja
from app.models.kalenderModel import MfKalender
from app.models.potModel import MfPot
from app.models.classModel import MfClass
from app.models.dinasLuarModel import DinasLuar
from app.models.jabatanModel import MfJabatan


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


def cari_absensi_normalisasi_finger():
    """Render halaman Cari Absensi Normalisasi Absensi Finger."""
    return render_template('pages/dashboard_1/Cari Absensi Normalisasi Absensi Finger.html')


def cari_absensi_pegawai_manual():
    """Render halaman Cari Absensi Pegawai Absen Manual."""
    return render_template('pages/dashboard_1/Cari Absensi Pegawai Absen Manual.html')


def cari_absensi_pegawai_lembur_manual():
    """Render halaman Cari Absensi Pegawai Lembur Manual."""
    return render_template('pages/dashboard_1/Cari Absensi Pegawai Lembur Manual.html')