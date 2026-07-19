# controllers/dashboard_1MasterFileController.py
import requests
from datetime import date, datetime, timedelta
from flask import render_template, request, jsonify, session, current_app
from app import db
from app.models.classModel import MfClass
from app.models.pegawaiModel import Pegawai
from app.models.unitKerjaModel import MfUnitKerja
from app.models.kalenderModel import MfKalender
from app.models.potModel import MfPot
from app.models.jamKerjaModel import MfJamKerja

GOOGLE_ID_HOLIDAY_CALENDAR_ID = 'id.indonesian#holiday@group.v.calendar.google.com'

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

def save_jam_kerja():
    """
    Simpan data Master Jam Kerja baru dari form.
    Body JSON yang diharapkan:
    {
        "shift": "1",                    // dari dropdown Shift (1/2) -> SHIFT_KERJA
        "penggantian_tlm1": true,        // true=Ada Penggantian -> 'Y', false=Tidak Ada -> 'N'
        "tgl_mulai": "2026-01-01",
        "hari_kerja": "1",                // 1=Senin-Kamis, 2=Jum'at -> AGENDA
        "jam_masuk": "07:30",
        "jam_pulang": "16:00"
    }
    """
    payload = request.get_json(silent=True) or {}

    shift_raw = payload.get('shift', '').strip() if payload.get('shift') else ''
    penggantian_tlm1_raw = payload.get('penggantian_tlm1')
    tgl_mulai_raw = payload.get('tgl_mulai', '').strip() if payload.get('tgl_mulai') else ''
    hari_kerja_raw = payload.get('hari_kerja', '').strip() if payload.get('hari_kerja') else ''
    jam_masuk_raw = payload.get('jam_masuk', '').strip() if payload.get('jam_masuk') else ''
    jam_pulang_raw = payload.get('jam_pulang', '').strip() if payload.get('jam_pulang') else ''

    # --- Validasi field wajib ---
    if not shift_raw:
        return jsonify({'status': 'error', 'message': 'Shift wajib dipilih'}), 400
    if penggantian_tlm1_raw is None:
        return jsonify({'status': 'error', 'message': 'Penggantian TLM 1 wajib dipilih'}), 400
    if not tgl_mulai_raw:
        return jsonify({'status': 'error', 'message': 'Tanggal Mulai wajib diisi'}), 400
    if not hari_kerja_raw:
        return jsonify({'status': 'error', 'message': 'Hari Kerja wajib dipilih'}), 400
    if not jam_masuk_raw:
        return jsonify({'status': 'error', 'message': 'Jam Masuk wajib diisi'}), 400
    if not jam_pulang_raw:
        return jsonify({'status': 'error', 'message': 'Jam Pulang wajib diisi'}), 400

    # --- Validasi & konversi Tanggal Mulai ---
    try:
        tgl_mulai = datetime.strptime(tgl_mulai_raw, '%Y-%m-%d')
    except ValueError:
        return jsonify({'status': 'error', 'message': 'Format Tanggal Mulai harus YYYY-MM-DD'}), 400

    # --- Validasi & konversi Jam Masuk / Jam Pulang, digabung dengan Tanggal Mulai ---
    try:
        jam_masuk_time = datetime.strptime(jam_masuk_raw, '%H:%M').time()
        std_jam_in = datetime.combine(tgl_mulai.date(), jam_masuk_time)
    except ValueError:
        return jsonify({'status': 'error', 'message': 'Format Jam Masuk harus HH:MM'}), 400

    try:
        jam_pulang_time = datetime.strptime(jam_pulang_raw, '%H:%M').time()
        std_jam_out = datetime.combine(tgl_mulai.date(), jam_pulang_time)
    except ValueError:
        return jsonify({'status': 'error', 'message': 'Format Jam Pulang harus HH:MM'}), 400

    # --- Konversi Penggantian TLM 1: Ada -> 'Y', Tidak Ada -> 'N' ---
    penggantian_tlm1 = 'Y' if penggantian_tlm1_raw else 'N'

    # --- Konversi Hari Kerja -> label AGENDA ---
    agenda_map = {'1': 'Senin-Kamis', '2': "Jum'at"}
    agenda = agenda_map.get(hari_kerja_raw)
    if agenda is None:
        return jsonify({'status': 'error', 'message': 'Hari Kerja tidak valid'}), 400

    jam_kerja = MfJamKerja(
        STD_JAM_IN=std_jam_in,
        STD_JAM_OUT=std_jam_out,
        TGL_MULAI_BERLAKU=tgl_mulai,
        SHIFT=shift_raw,
        AGENDA=agenda,
        PENGGANTIAN_TLM1=penggantian_tlm1,
        UPDATE_BY=session.get('nip', 'system'),
        UPDATE_DATE=datetime.utcnow(),
        SHIFT_KERJA=shift_raw,
    )

    db.session.add(jam_kerja)
    db.session.commit()

    return jsonify({
        'status': 'success',
        'message': 'Data jam kerja berhasil disimpan',
        'data': jam_kerja.to_dict(),
    })

def master_kalender():
    """Render halaman Master File Master Kalender."""
    return render_template('pages/dashboard_1/Master File Master Kalender.html')

def _get_indonesian_holidays(tahun):
    """
    Ambil daftar hari libur nasional Indonesia untuk 1 tahun tertentu
    dari Google Calendar (public holiday calendar).
    Return: dict { date(YYYY, M, D): "Nama Hari Libur" }
    """
    api_key = current_app.config.get('GOOGLE_CALENDAR_API_KEY')
    if not api_key:
        # Tanpa API key: kalender tetap dibuat, hanya Sabtu/Minggu yang
        # otomatis ditandai libur — tanggal merah nasional di-skip.
        return {}

    url = f'https://www.googleapis.com/calendar/v3/calendars/{GOOGLE_ID_HOLIDAY_CALENDAR_ID}/events'
    params = {
        'key': api_key,
        'timeMin': f'{tahun}-01-01T00:00:00Z',
        'timeMax': f'{tahun}-12-31T23:59:59Z',
        'singleEvents': 'true',
        'orderBy': 'startTime',
    }

    holidays = {}
    try:
        resp = requests.get(url, params=params, timeout=10)
        resp.raise_for_status()
        for event in resp.json().get('items', []):
            tgl_str = event.get('start', {}).get('date')  # all-day event -> 'YYYY-MM-DD'
            if not tgl_str:
                continue
            holidays[date.fromisoformat(tgl_str)] = event.get('summary', 'Hari Libur Nasional')
    except requests.RequestException as e:
        current_app.logger.warning(f'Gagal mengambil data libur nasional dari Google Calendar: {e}')

    return holidays


def create_kalender_tahun():
    """
    Generate seluruh baris KALENDER untuk 1 tahun penuh.
    Body JSON: { "tahun": 2026 }
    Kalau baris tanggal tertentu sudah ada, akan di-update (bukan duplikat).
    """
    payload = request.get_json(silent=True) or {}
    tahun_raw = payload.get('tahun')

    if not tahun_raw or not str(tahun_raw).isdigit():
        return jsonify({'status': 'error', 'message': 'Tahun wajib diisi dan berupa angka'}), 400

    tahun = int(tahun_raw)
    if tahun < 1900 or tahun > 2200:
        return jsonify({'status': 'error', 'message': 'Tahun tidak valid'}), 400

    holidays = _get_indonesian_holidays(tahun)
    hari_nama = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu']

    current_nip = session.get('nip', 'system')
    now = datetime.utcnow()

    inserted, updated = 0, 0
    d = date(tahun, 1, 1)
    akhir_tahun = date(tahun, 12, 31)

    while d <= akhir_tahun:
        holiday_name = holidays.get(d)
        is_weekend = d.weekday() >= 5  # 5=Sabtu, 6=Minggu

        if holiday_name:
            is_libur, ket = 'Y', holiday_name
        elif is_weekend:
            is_libur, ket = 'Y', hari_nama[d.weekday()]
        else:
            is_libur, ket = 'N', None

        tgl_kerja = datetime.combine(d, datetime.min.time())
        row = MfKalender.query.get(tgl_kerja)

        if row is None:
            db.session.add(MfKalender(
                TGL_KERJA=tgl_kerja, IS_LIBUR=is_libur, KET=ket,
                UPDATE_BY=current_nip, UPDATE_DATE=now,
            ))
            inserted += 1
        else:
            row.IS_LIBUR = is_libur
            row.KET = ket
            row.UPDATE_BY = current_nip
            row.UPDATE_DATE = now
            updated += 1

        d += timedelta(days=1)

    db.session.commit()

    return jsonify({
        'status': 'success',
        'tahun': tahun,
        'inserted': inserted,
        'updated': updated,
        'holiday_source_available': bool(current_app.config.get('GOOGLE_CALENDAR_API_KEY')),
    })


def get_kalender_list():
    """
    Ambil data KALENDER untuk 1 tahun tertentu.
    Query param: tahun (wajib) — sengaja wajib supaya tidak menarik
    seluruh histori kalender sekaligus (bisa ribuan baris).
    """
    tahun = request.args.get('tahun', type=int)
    if not tahun:
        return jsonify({'status': 'error', 'message': 'Parameter tahun wajib diisi'}), 400

    start = datetime(tahun, 1, 1)
    end = datetime(tahun, 12, 31, 23, 59, 59)

    rows = (
        MfKalender.query
        .filter(MfKalender.TGL_KERJA >= start, MfKalender.TGL_KERJA <= end)
        .order_by(MfKalender.TGL_KERJA.asc())
        .all()
    )

    data = [
        {
            'no': idx + 1,
            'tanggal': row.TGL_KERJA.strftime('%d-%m-%Y'),
            'is_libur': row.IS_LIBUR,
            'ket': row.KET or '-',
            'updated': row.UPDATE_DATE.strftime('%d-%m-%Y %H:%M') if row.UPDATE_DATE else '-',
        }
        for idx, row in enumerate(rows)
    ]

    return jsonify({'status': 'success', 'data': data})

def master_pegawai_vip():
    """
    Render halaman Master File Master Pegawai VIP.
    Unit Kerja dropdown diisi dari tabel MF_UNIT_KERJA (server-side render),
    bukan hardcode di HTML — supaya kalau ada unit kerja baru, cukup tambah
    row di DB tanpa perlu edit template.
    """
    unit_kerja_list = MfUnitKerja.query.order_by(
        MfUnitKerja.URUT_REPORT.asc(),
        MfUnitKerja.NAMA_UNIT_KERJA.asc()
    ).all()

    return render_template(
        'pages/dashboard_1/Master File Master Pegawai VIP.html',
        unit_kerja_list=unit_kerja_list
    )

def get_pegawai_vip_list():
    """
    Ambil seluruh data pegawai untuk tabel VIP List.

    Filter opsional (semua bisa kosong -> berlaku seperti klik Refresh biasa):
      - unit_kerja_id : dari dropdown "Unit Kerja" (UNIT_KERJA_ID)
      - field1/keyword1 dan field2/keyword2 : dari dua dropdown "Filter",
        digabung dengan AND (sesuai label "Dan" di UI)
    """
    unit_kerja_id = request.args.get('unit_kerja_id', type=int)
    field1 = request.args.get('field1')
    keyword1 = request.args.get('keyword1', '').strip()
    field2 = request.args.get('field2')
    keyword2 = request.args.get('keyword2', '').strip()

    # Map label dropdown -> kolom SQLAlchemy.
    # 'Gol' dan 'No Finger' sengaja belum dimasukkan — butuh model master
    # tambahan (MF_GOLONGAN, master no-finger) yang belum tersedia.
    field_map = {
        'Nama Peg': Pegawai.NAMA,
        'NIP': Pegawai.NIP,
        'Jabatan': Pegawai.JABATAN,
        'Jenis Kelamin': Pegawai.JENIS_KEL,
        'Unit Kerja': MfUnitKerja.NAMA_UNIT_KERJA,
    }

    query = Pegawai.query

    # Join ke MF_UNIT_KERJA hanya kalau memang dibutuhkan (salah satu filter
    # field-nya "Unit Kerja") — supaya query tetap ringan untuk kasus umum.
    needs_unit_kerja_join = 'Unit Kerja' in (field1, field2)
    if needs_unit_kerja_join:
        query = query.join(MfUnitKerja, Pegawai.UNIT_KERJA_ID == MfUnitKerja.UNIT_KERJA_ID)

    if unit_kerja_id:
        query = query.filter(Pegawai.UNIT_KERJA_ID == unit_kerja_id)

    for field, keyword in [(field1, keyword1), (field2, keyword2)]:
        if not field or not keyword:
            continue  # filter ini tidak dipakai -> skip, tidak wajib diisi
        column = field_map.get(field)
        if column is not None:
            query = query.filter(column.ilike(f'%{keyword}%'))

    pegawai_list = query.order_by(Pegawai.NAMA.asc()).all()

    data = [
        {
            'no': idx + 1,
            'nip': p.NIP,
            'nama': p.NAMA,
            'jabatan': p.JABATAN,
            'is_vip': bool(p.IS_VIP),
        }
        for idx, p in enumerate(pegawai_list)
    ]

    return jsonify({'status': 'success', 'data': data})


def toggle_pegawai_vip():
    """
    Ubah status VIP satu pegawai.
    Body JSON yang diharapkan: { "nip": "...", "is_vip": true|false }
    """
    payload = request.get_json(silent=True) or {}
    nip = payload.get('nip')
    is_vip = payload.get('is_vip')

    # Validasi input dasar — jangan percaya data dari client mentah-mentah
    if not nip or is_vip is None:
        return jsonify({'status': 'error', 'message': 'nip dan is_vip wajib diisi'}), 400

    pegawai = Pegawai.query.get(nip)
    if pegawai is None:
        return jsonify({'status': 'error', 'message': 'Pegawai tidak ditemukan'}), 404

    pegawai.IS_VIP = 1 if is_vip else 0
    pegawai.UPDATE_IN_BY = session.get('nip', 'system')
    db.session.commit()

    return jsonify({
        'status': 'success',
        'nip': pegawai.NIP,
        'is_vip': bool(pegawai.IS_VIP)
    })

def master_potongan():
    """Render halaman Master File Master Potongan."""
    return render_template('pages/dashboard_1/Master File Master Potongan.html')

def save_potongan():
    """
    Simpan data Master Potongan baru dari form.
    Body JSON yang diharapkan:
    {
        "kategori": "Cuti",
        "tingkat": "Ringan",
        "diskripsi": "Terlambat 1-15 menit",
        "persen_pot": 1.5,
        "is_pendukung": true,      // true=Ada -> 'Y', false=Tidak Ada -> 'N'
        "tgl_mulai": "2026-01-01",
        "range_awal": 1,
        "range_akhir": 15
    }
    """
    payload = request.get_json(silent=True) or {}

    kategori = payload.get('kategori', '').strip()
    tingkat = payload.get('tingkat', '').strip()
    diskripsi = payload.get('diskripsi', '').strip()
    persen_pot_raw = payload.get('persen_pot')
    is_pendukung_raw = payload.get('is_pendukung')
    tgl_mulai_raw = payload.get('tgl_mulai', '').strip()
    range_awal_raw = payload.get('range_awal')
    range_akhir_raw = payload.get('range_akhir')

    # --- Validasi field wajib ---
    if not kategori:
        return jsonify({'status': 'error', 'message': 'Kategori wajib diisi'}), 400
    if not diskripsi:
        return jsonify({'status': 'error', 'message': 'Diskripsi wajib diisi'}), 400
    if is_pendukung_raw is None:
        return jsonify({'status': 'error', 'message': 'Bukti Pendukung wajib dipilih'}), 400

    # --- Validasi & konversi tipe data numerik ---
    persen_pot = None
    if persen_pot_raw not in (None, ''):
        try:
            persen_pot = float(persen_pot_raw)
            if not (0 <= persen_pot <= 100):
                return jsonify({'status': 'error', 'message': 'Potongan (%) harus antara 0-100'}), 400
        except (TypeError, ValueError):
            return jsonify({'status': 'error', 'message': 'Potongan (%) harus berupa angka'}), 400

    range_awal = None
    if range_awal_raw not in (None, ''):
        try:
            range_awal = float(range_awal_raw)
        except (TypeError, ValueError):
            return jsonify({'status': 'error', 'message': 'Range awal harus berupa angka'}), 400

    range_akhir = None
    if range_akhir_raw not in (None, ''):
        try:
            range_akhir = float(range_akhir_raw)
        except (TypeError, ValueError):
            return jsonify({'status': 'error', 'message': 'Range akhir harus berupa angka'}), 400

    if range_awal is not None and range_akhir is not None and range_awal > range_akhir:
        return jsonify({'status': 'error', 'message': 'Range awal tidak boleh lebih besar dari range akhir'}), 400

    # --- Validasi & konversi tanggal ---
    tgl_mulai = None
    if tgl_mulai_raw:
        try:
            tgl_mulai = datetime.strptime(tgl_mulai_raw, '%Y-%m-%d')
        except ValueError:
            return jsonify({'status': 'error', 'message': 'Format tanggal harus YYYY-MM-DD'}), 400

    # --- Konversi Bukti Pendukung: Ada -> 'Y', Tidak Ada -> 'N' ---
    is_pendukung = 'Y' if is_pendukung_raw else 'N'

    potongan = MfPot(
        KATEGORI=kategori,
        TINGKAT=tingkat or None,
        NAMA_POT=diskripsi,
        PERSEN_POT=persen_pot,
        IS_PENDUKUNG=is_pendukung,
        TGL_MULAI=tgl_mulai,
        RANGE_AWAL=range_awal,
        RANGE_AKHIR=range_akhir,
        UPDATE_BY=session.get('nip', 'system'),
        UPDATE_DATE=datetime.utcnow(),
    )

    db.session.add(potongan)
    db.session.commit()

    return jsonify({
        'status': 'success',
        'message': 'Data potongan berhasil disimpan',
        'data': potongan.to_dict(),
    })

def get_potongan_list():
    """
    Ambil data Master Potongan untuk tabel Cari Master Potongan.

    Filter opsional (semua bisa kosong -> berlaku seperti klik Refresh biasa):
      - periode        : filter TGL_MULAI pada tanggal tertentu (format YYYY-MM-DD)
      - field1/keyword1 dan field2/keyword2 : dua dropdown "Filter" (Kategori,
        Potongan(%), Tingkat), digabung dengan AND
    """
    periode_raw = request.args.get('periode', '').strip()
    field1 = request.args.get('field1')
    keyword1 = request.args.get('keyword1', '').strip()
    field2 = request.args.get('field2')
    keyword2 = request.args.get('keyword2', '').strip()

    query = MfPot.query

    # --- Filter Periode: cocokkan TGL_MULAI pada tanggal yang dipilih ---
    if periode_raw:
        try:
            periode_date = datetime.strptime(periode_raw, '%Y-%m-%d')
        except ValueError:
            return jsonify({'status': 'error', 'message': 'Format periode harus YYYY-MM-DD'}), 400

        awal_hari = periode_date
        akhir_hari = periode_date + timedelta(days=1)
        query = query.filter(MfPot.TGL_MULAI >= awal_hari, MfPot.TGL_MULAI < akhir_hari)

    # --- Filter field1/field2 (Kategori, Potongan(%), Tingkat) ---
    # Kategori & Tingkat -> kolom teks, pakai partial match (ilike)
    # Potongan(%) -> kolom Float, tidak bisa ilike -> exact match angka
    text_field_map = {
        'Kategori': MfPot.KATEGORI,
        'Tingkat': MfPot.TINGKAT,
    }

    for field, keyword in [(field1, keyword1), (field2, keyword2)]:
        if not field or not keyword:
            continue  # filter tidak dipakai -> skip, tidak wajib diisi

        if field == 'Potongan(%)':
            try:
                nilai = float(keyword)
            except ValueError:
                return jsonify({'status': 'error', 'message': 'Potongan(%) harus berupa angka'}), 400
            query = query.filter(MfPot.PERSEN_POT == nilai)
        else:
            column = text_field_map.get(field)
            if column is not None:
                query = query.filter(column.ilike(f'%{keyword}%'))

    pot_list = query.order_by(MfPot.UPDATE_DATE.desc()).all()

    def format_range(row):
        if row.RANGE_AWAL is None and row.RANGE_AKHIR is None:
            return '-'
        awal = row.RANGE_AWAL if row.RANGE_AWAL is not None else '-'
        akhir = row.RANGE_AKHIR if row.RANGE_AKHIR is not None else '-'
        return f'{awal} s/d {akhir}'

    data = [
        {
            'no': idx + 1,
            'kategori': row.KATEGORI or '-',
            'tingkat': row.TINGKAT or '-',
            'deskripsi': row.NAMA_POT or '-',
            'persen_pot': row.PERSEN_POT if row.PERSEN_POT is not None else '-',
            'range': format_range(row),
            'tgl_mulai': row.TGL_MULAI.strftime('%d-%m-%Y') if row.TGL_MULAI else '-',
            'updated': row.UPDATE_DATE.strftime('%d-%m-%Y %H:%M') if row.UPDATE_DATE else '-',
        }
        for idx, row in enumerate(pot_list)
    ]

    return jsonify({'status': 'success', 'data': data})

def master_trt():
    """Render halaman Master File Master TRT."""
    return render_template('pages/dashboard_1/Master File Master TRT.html')

def master_tunkin_class():
    """Render halaman Master File Master Tunkin Class."""
    return render_template('pages/dashboard_1/Master File Master Tunkin Class.html')

def save_tunkin_class():
    """
    Simpan data Master Tunkin/Class baru dari form.
    Body JSON yang diharapkan:
    {
        "class_id": 3,
        "tunjangan": 1500000,
        "tgl_mulai": "2026-01-01",
        "dokreff": "SE-001/2026"
    }
    """
    payload = request.get_json(silent=True) or {}

    class_id_raw = payload.get('class_id')
    tunjangan_raw = payload.get('tunjangan')
    tgl_mulai_raw = payload.get('tgl_mulai', '').strip() if payload.get('tgl_mulai') else ''
    dokreff = (payload.get('dokreff') or '').strip()

    # --- Validasi field wajib ---
    if class_id_raw in (None, ''):
        return jsonify({'status': 'error', 'message': 'Class wajib dipilih'}), 400
    if tunjangan_raw in (None, ''):
        return jsonify({'status': 'error', 'message': 'Tunjangan wajib diisi'}), 400
    if not dokreff:
        return jsonify({'status': 'error', 'message': 'No Surat wajib diisi'}), 400

    # --- Validasi & konversi Class ID ---
    try:
        class_id = int(class_id_raw)
    except (TypeError, ValueError):
        return jsonify({'status': 'error', 'message': 'Class harus berupa angka'}), 400

    # Cegah duplikat primary key — kalau sudah ada, update alih-alih insert baru
    existing = MfClass.query.get(class_id)

    # --- Validasi & konversi Tunjangan ---
    try:
        tunjangan = float(tunjangan_raw)
        if tunjangan < 0:
            return jsonify({'status': 'error', 'message': 'Tunjangan tidak boleh negatif'}), 400
    except (TypeError, ValueError):
        return jsonify({'status': 'error', 'message': 'Tunjangan harus berupa angka'}), 400

    # --- Validasi & konversi Tanggal ---
    tgl_mulai = None
    if tgl_mulai_raw:
        try:
            tgl_mulai = datetime.strptime(tgl_mulai_raw, '%Y-%m-%d')
        except ValueError:
            return jsonify({'status': 'error', 'message': 'Format tanggal harus YYYY-MM-DD'}), 400

    current_nip = session.get('nip', 'system')
    now = datetime.utcnow()

    if existing is not None:
        # Update baris yang sudah ada
        existing.TUNJANGAN = tunjangan
        existing.TGL_MULAI = tgl_mulai
        existing.DOKREFF = dokreff
        existing.UPDATE_IN_BY = current_nip
        existing.UPDATE_DATE = now
        db.session.commit()
        return jsonify({
            'status': 'success',
            'message': 'Data tunkin/class berhasil diperbarui',
            'data': existing.to_dict(),
        })

    tunkin_class = MfClass(
        CLASS_ID=class_id,
        TUNJANGAN=tunjangan,
        TGL_MULAI=tgl_mulai,
        DOKREFF=dokreff,
        UPDATE_IN_BY=current_nip,
        UPDATE_DATE=now,
    )

    db.session.add(tunkin_class)
    db.session.commit()

    return jsonify({
        'status': 'success',
        'message': 'Data tunkin/class berhasil disimpan',
        'data': tunkin_class.to_dict(),
    })

def master_unit_kerja():
    """Render halaman Master File Master Unit Kerja."""
    return render_template('pages/dashboard_1/Master File Master Unit Kerja.html')

def save_unit_kerja():
    """
    Simpan data Master Unit Kerja baru dari form.
    Body JSON yang diharapkan:
    {
        "unit_kerja_id": 20,
        "nama_unit_kerja": "Surabaya",
        "urut_report": 1,
        "tipe": "Pusat"   // "Pusat" -> IS_PUSAT=1, "Pos" -> IS_PUSAT=0
    }

    Catatan: field "Isi Aktif" di form saat ini TIDAK punya kolom
    yang sesuai di model MfUnitKerja (hanya ada IS_PUSAT untuk Tipe),
    jadi nilai itu diterima tapi tidak disimpan. Kalau memang perlu
    disimpan, tambahkan kolom IS_AKTIF ke model dulu.
    """
    payload = request.get_json(silent=True) or {}

    unit_kerja_id_raw = payload.get('unit_kerja_id')
    nama_unit_kerja = payload.get('nama_unit_kerja', '').strip()
    urut_report_raw = payload.get('urut_report')
    tipe_raw = payload.get('tipe', '').strip()

    # --- Validasi field wajib ---
    if unit_kerja_id_raw in (None, ''):
        return jsonify({'status': 'error', 'message': 'Unit Kerja ID wajib diisi'}), 400
    if not nama_unit_kerja:
        return jsonify({'status': 'error', 'message': 'Nama Unit Kerja wajib diisi'}), 400
    if not tipe_raw:
        return jsonify({'status': 'error', 'message': 'Tipe wajib dipilih'}), 400

    # --- Validasi & konversi Unit Kerja ID ---
    try:
        unit_kerja_id = int(unit_kerja_id_raw)
    except (TypeError, ValueError):
        return jsonify({'status': 'error', 'message': 'Unit Kerja ID harus berupa angka'}), 400

    # Cegah duplikat primary key — kalau sudah ada, tolak (bukan overwrite diam-diam)
    existing = MfUnitKerja.query.get(unit_kerja_id)
    if existing is not None:
        return jsonify({
            'status': 'error',
            'message': f'Unit Kerja ID {unit_kerja_id} sudah terdaftar ({existing.NAMA_UNIT_KERJA})'
        }), 409

    # --- Validasi & konversi Urut Report ---
    urut_report = 0
    if urut_report_raw not in (None, ''):
        try:
            urut_report = int(urut_report_raw)
        except (TypeError, ValueError):
            return jsonify({'status': 'error', 'message': 'Urut Report harus berupa angka bulat'}), 400
        if urut_report < 0:
            return jsonify({'status': 'error', 'message': 'Urut Report tidak boleh negatif'}), 400

    # --- Konversi Tipe: Pusat -> 1, Pos -> 0 ---
    tipe_map = {'Pusat': 1, 'Pos': 2}
    if tipe_raw not in tipe_map:
        return jsonify({'status': 'error', 'message': 'Tipe harus "Pusat" atau "Pos"'}), 400
    is_pusat = tipe_map[tipe_raw]

    unit_kerja = MfUnitKerja(
        UNIT_KERJA_ID=unit_kerja_id,
        NAMA_UNIT_KERJA=nama_unit_kerja,
        URUT_REPORT=urut_report,
        IS_PUSAT=is_pusat,
        UPDATE_IN_BY=session.get('nip', 'system'),
        UPDATE_DATE=datetime.utcnow(),
    )

    db.session.add(unit_kerja)
    db.session.commit()

    return jsonify({
        'status': 'success',
        'message': 'Data unit kerja berhasil disimpan',
        'data': unit_kerja.to_dict(),
    })

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

def get_jam_kerja_list():
    """
    Ambil data Master Jam Kerja untuk tabel Cari Master Jam Kerja.

    Filter opsional (semua bisa kosong -> berlaku seperti klik Refresh biasa,
    menampilkan seluruh data):
      - periode        : filter TGL_MULAI_BERLAKU pada tanggal tertentu (format YYYY-MM-DD)
      - field1/keyword1 dan field2/keyword2 : dua dropdown "Filter"
        ("Hari Kerja Senin-Kamis(1)/Jumat(2)", "Tanggal(yyyy-mm-dd)"), digabung dengan AND
    """
    periode_raw = request.args.get('periode', '').strip()
    field1 = request.args.get('field1')
    keyword1 = request.args.get('keyword1', '').strip()
    field2 = request.args.get('field2')
    keyword2 = request.args.get('keyword2', '').strip()

    query = MfJamKerja.query

    # --- Filter Periode: cocokkan TGL_MULAI_BERLAKU pada tanggal yang dipilih ---
    if periode_raw:
        try:
            periode_date = datetime.strptime(periode_raw, '%Y-%m-%d')
        except ValueError:
            return jsonify({'status': 'error', 'message': 'Format periode harus YYYY-MM-DD'}), 400

        awal_hari = periode_date
        akhir_hari = periode_date + timedelta(days=1)
        query = query.filter(
            MfJamKerja.TGL_MULAI_BERLAKU >= awal_hari,
            MfJamKerja.TGL_MULAI_BERLAKU < akhir_hari
        )

    # --- Konversi label Hari Kerja: 1 -> "Senin-Kamis", 2 -> "Jum'at" ---
    hari_kerja_map = {'1': 'Senin-Kamis', '2': "Jum'at"}

    # --- Filter field1/field2 ---
    # "Hari Kerja Senin-Kamis(1)/Jumat(2)" -> kolom AGENDA, exact match dari mapping 1/2
    # "Tanggal(yyyy-mm-dd)"                -> kolom TGL_MULAI_BERLAKU, exact match tanggal
    for field, keyword in [(field1, keyword1), (field2, keyword2)]:
        if not field or not keyword:
            continue  # filter ini tidak dipakai -> skip, tidak wajib diisi

        if field == 'Hari Kerja Senin-Kamis(1)/Jumat(2)':
            agenda = hari_kerja_map.get(keyword)
            if agenda is None:
                return jsonify({
                    'status': 'error',
                    'message': 'Hari Kerja harus diisi 1 (Senin-Kamis) atau 2 (Jumat)'
                }), 400
            query = query.filter(MfJamKerja.AGENDA == agenda)

        elif field == 'Tanggal(yyyy-mm-dd)':
            try:
                tgl = datetime.strptime(keyword, '%Y-%m-%d')
            except ValueError:
                return jsonify({'status': 'error', 'message': 'Format Tanggal harus YYYY-MM-DD'}), 400
            awal_hari = tgl
            akhir_hari = tgl + timedelta(days=1)
            query = query.filter(
                MfJamKerja.TGL_MULAI_BERLAKU >= awal_hari,
                MfJamKerja.TGL_MULAI_BERLAKU < akhir_hari
            )

    jam_kerja_list = query.order_by(MfJamKerja.TGL_MULAI_BERLAKU.desc()).all()

    # --- Label Ada Pengganti TLM1: 'Y' -> Ada, 'N' -> Tidak Ada ---
    tlm1_label = {'Y': 'Ada', 'N': 'Tidak Ada'}

    data = [
        {
            'no': idx + 1,
            'tgl_mulai': row.TGL_MULAI_BERLAKU.strftime('%d-%m-%Y') if row.TGL_MULAI_BERLAKU else '-',
            'hari_kerja': row.AGENDA or '-',
            'shift': row.SHIFT or '-',
            'jam_masuk': row.STD_JAM_IN.strftime('%H:%M') if row.STD_JAM_IN else '-',
            'jam_pulang': row.STD_JAM_OUT.strftime('%H:%M') if row.STD_JAM_OUT else '-',
            'penggantian_tlm1': tlm1_label.get(row.PENGGANTIAN_TLM1, '-'),
            'updated': row.UPDATE_DATE.strftime('%d-%m-%Y %H:%M') if row.UPDATE_DATE else '-',
        }
        for idx, row in enumerate(jam_kerja_list)
    ]

    return jsonify({'status': 'success', 'data': data})

def cari_master_kalender():
    """Render halaman Cari Master Kalender."""
    return render_template('pages/dashboard_1/Cari Master Kalender.html')

def cari_master_potongan():
    """Render halaman Cari Master Potongan."""
    return render_template('pages/dashboard_1/Cari Master Potongan.html')

def cari_master_tunkin_class():
    """Render halaman Cari Master Tunkin Class."""
    return render_template('pages/dashboard_1/Cari Master Tunkin Class.html')

def get_tunkin_class_list():
    """
    Ambil data Master Tunkin/Class untuk tabel Cari Master Tunkin Class.

    Filter opsional (semua bisa kosong -> berlaku seperti klik Refresh biasa,
    menampilkan seluruh data):
      - periode        : filter TGL_MULAI pada tanggal tertentu (format YYYY-MM-DD)
      - field1/keyword1 dan field2/keyword2 : dua dropdown "Filter"
        (Class, Tunjangan, No Surat), digabung dengan AND
    """
    periode_raw = request.args.get('periode', '').strip()
    field1 = request.args.get('field1')
    keyword1 = request.args.get('keyword1', '').strip()
    field2 = request.args.get('field2')
    keyword2 = request.args.get('keyword2', '').strip()

    query = MfClass.query

    # --- Filter Periode: cocokkan TGL_MULAI pada tanggal yang dipilih ---
    if periode_raw:
        try:
            periode_date = datetime.strptime(periode_raw, '%Y-%m-%d')
        except ValueError:
            return jsonify({'status': 'error', 'message': 'Format periode harus YYYY-MM-DD'}), 400

        awal_hari = periode_date
        akhir_hari = periode_date + timedelta(days=1)
        query = query.filter(MfClass.TGL_MULAI >= awal_hari, MfClass.TGL_MULAI < akhir_hari)

    # --- Filter field1/field2 (Class, Tunjangan, No Surat) ---
    # Class     -> primary key Integer, exact match angka
    # Tunjangan -> kolom Float, exact match angka
    # No Surat  -> kolom teks (DOKREFF), partial match (ilike)
    for field, keyword in [(field1, keyword1), (field2, keyword2)]:
        if not field or not keyword:
            continue  # filter ini tidak dipakai -> skip, tidak wajib diisi

        if field == 'Class':
            try:
                nilai = int(keyword)
            except ValueError:
                return jsonify({'status': 'error', 'message': 'Class harus berupa angka'}), 400
            query = query.filter(MfClass.CLASS_ID == nilai)
        elif field == 'Tunjangan':
            try:
                nilai = float(keyword)
            except ValueError:
                return jsonify({'status': 'error', 'message': 'Tunjangan harus berupa angka'}), 400
            query = query.filter(MfClass.TUNJANGAN == nilai)
        elif field == 'No Surat':
            query = query.filter(MfClass.DOKREFF.ilike(f'%{keyword}%'))

    tunkin_class_list = query.order_by(MfClass.CLASS_ID.asc()).all()

    data = [
        {
            'no': idx + 1,
            'class_id': row.CLASS_ID,
            'tunjangan': row.TUNJANGAN if row.TUNJANGAN is not None else '-',
            'tgl_mulai': row.TGL_MULAI.strftime('%d-%m-%Y') if row.TGL_MULAI else '-',
            'dokreff': row.DOKREFF or '-',
            'updated': row.UPDATE_DATE.strftime('%d-%m-%Y %H:%M') if row.UPDATE_DATE else '-',
        }
        for idx, row in enumerate(tunkin_class_list)
    ]

    return jsonify({'status': 'success', 'data': data})

def cari_master_uang_makan():
    """Render halaman Cari Master Uang Makan."""
    return render_template('pages/dashboard_1/Cari Master Uang Makan.html')

def cari_master_unit_kerja():
    """Render halaman Cari Master Unit Kerja."""
    return render_template('pages/dashboard_1/Cari Master Unit Kerja.html')

def get_unit_kerja_list():
    """
    Ambil data Master Unit Kerja untuk tabel Cari Master Unit Kerja.

    Filter opsional (semua bisa kosong -> berlaku seperti klik Refresh biasa):
      - periode        : filter UPDATE_DATE pada tanggal tertentu (format YYYY-MM-DD)
      - field1/keyword1 dan field2/keyword2 : dua dropdown "Filter"
        (Nama Unit Kerja, Unit Kerja ID), digabung dengan AND
    """
    periode_raw = request.args.get('periode', '').strip()
    field1 = request.args.get('field1')
    keyword1 = request.args.get('keyword1', '').strip()
    field2 = request.args.get('field2')
    keyword2 = request.args.get('keyword2', '').strip()

    query = MfUnitKerja.query

    # --- Filter Periode: cocokkan UPDATE_DATE pada tanggal yang dipilih ---
    if periode_raw:
        try:
            periode_date = datetime.strptime(periode_raw, '%Y-%m-%d')
        except ValueError:
            return jsonify({'status': 'error', 'message': 'Format periode harus YYYY-MM-DD'}), 400

        awal_hari = periode_date
        akhir_hari = periode_date + timedelta(days=1)
        query = query.filter(MfUnitKerja.UPDATE_DATE >= awal_hari, MfUnitKerja.UPDATE_DATE < akhir_hari)

    # --- Filter field1/field2 ---
    # Nama Unit Kerja -> kolom teks, pakai partial match (ilike)
    # Unit Kerja ID   -> kolom Integer, exact match angka
    for field, keyword in [(field1, keyword1), (field2, keyword2)]:
        if not field or not keyword:
            continue  # filter tidak dipakai -> skip, tidak wajib diisi

        if field == 'Unit Kerja ID':
            try:
                nilai = int(keyword)
            except ValueError:
                return jsonify({'status': 'error', 'message': 'Unit Kerja ID harus berupa angka'}), 400
            query = query.filter(MfUnitKerja.UNIT_KERJA_ID == nilai)
        elif field == 'Nama Unit Kerja':
            query = query.filter(MfUnitKerja.NAMA_UNIT_KERJA.ilike(f'%{keyword}%'))

    unit_kerja_list = query.order_by(MfUnitKerja.URUT_REPORT.asc(), MfUnitKerja.NAMA_UNIT_KERJA.asc()).all()

    tipe_label = {1: 'Pusat', 2: 'Pos'}

    data = [
        {
            'no': idx + 1,
            'unit_kerja_id': row.UNIT_KERJA_ID,
            'nama_unit_kerja': row.NAMA_UNIT_KERJA or '-',
            'tipe': tipe_label.get(row.IS_PUSAT, '-'),
            'urut_report': row.URUT_REPORT if row.URUT_REPORT is not None else '-',
            'updated': row.UPDATE_DATE.strftime('%d-%m-%Y %H:%M') if row.UPDATE_DATE else '-',
        }
        for idx, row in enumerate(unit_kerja_list)
    ]

    return jsonify({'status': 'success', 'data': data})

def cari_user_account():
    """Render halaman Cari User Account."""
    return render_template('pages/dashboard_1/Cari User Account.html')


# ---- Create ----
def create_kalender():
    """Render halaman Create Kalender."""
    return render_template('pages/dashboard_1/Create Kalender.html')