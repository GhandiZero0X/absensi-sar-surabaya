# controllers/dashboard_1MasterFileController.py
import requests
from datetime import date, datetime, timedelta
from flask import render_template, request, jsonify, session, current_app
from app import db
from app.models.pegawaiModel import Pegawai
from app.models.unitKerjaModel import MfUnitKerja
from app.models.kalenderModel import MfKalender

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