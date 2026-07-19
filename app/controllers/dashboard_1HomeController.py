# controllers/dashboard_1HomeController.py
from flask import render_template, request
from datetime import date, datetime
from app import db
from app.models.pegawaiModel import Pegawai
from app.models.golonganModel import MfGolongan
from app.models.absensiModel import Absensi
from app.models.potModel import MfPot
from sqlalchemy import or_


def dashboard_pelanggaran():
    """
    Render halaman Dashboard Pelanggaran.
    Menampilkan tabel hukuman disiplin pegawai berdasarkan jumlah
    ketidakhadiran hari kerja.
    """
    data_pelanggaran = _get_data_pelanggaran()
    return render_template(
        'pages/dashboard_1/Dashboard Pelanggaran.html',
        data_pelanggaran=data_pelanggaran
    )


def _get_data_pelanggaran():
    """
    Chain query: PEGAWAI -> ABSENSI (via ABSENSI_ID) -> MF_POT (via POTONGAN_ID)
    Logic sama persis dengan get_pelanggaran_disiplin() di homeController.py
    (dipakai untuk modal Pelanggaran Disiplin di homepage), di sini di-reuse
    untuk render langsung ke tabel dashboard, bukan JSON.

    Catatan kolom:
      - TOTAL_TLM  : total keterlambatan (satuan tergantung sistem — menit atau hari)
      - TOTAL_PSW  : total pulang sebelum waktu
      - TINGKAT_TLM: tingkat pelanggaran per record absensi ('RINGAN'/'SEDANG'/'BERAT')
      - MF_POT.TINGKAT   : tingkat dari aturan master potongan
      - MF_POT.TINDAKAN  : jenis hukuman disiplin
      - MF_POT.PERSEN_POT: persentase potongan tunjangan
      - MF_POT.DURASI_POT + SATUAN_DURASI: lama potongan
    """
    try:
        results = db.session.query(
            Pegawai.NAMA,
            Absensi.TOTAL_TLM,
            Absensi.TOTAL_PSW,
            Absensi.TINGKAT_TLM,
            MfPot.TINGKAT,
            MfPot.TINDAKAN,
            MfPot.NAMA_POT,
            MfPot.PERSEN_POT,
            MfPot.DURASI_POT,
            MfPot.SATUAN_DURASI
        ).select_from(Pegawai)\
         .join(Absensi, Pegawai.ABSENSI_ID == Absensi.ABSENSI_ID)\
         .join(MfPot, Absensi.POTONGAN_ID == MfPot.POTONGAN_ID)\
         .filter(
             MfPot.TINGKAT.isnot(None),
             or_(
                 Absensi.TOTAL_TLM > 0,
                 Absensi.TOTAL_PSW > 0
             )
         )\
         .order_by(Absensi.TOTAL_TLM.desc())\
         .all()

        if not results:
            return []

        data = []
        for i, row in enumerate(results, 1):

            # ── Kategori hukuman ─────────────────────────────────────────────
            tingkat_raw = (row.TINGKAT or row.TINGKAT_TLM or '').strip().upper()
            if 'BERAT' in tingkat_raw:
                kategori = 'Hukuman Disiplin Berat'
            elif 'SEDANG' in tingkat_raw:
                kategori = 'Hukuman Disiplin Sedang'
            else:
                kategori = 'Hukuman Disiplin Ringan'

            # ── Jumlah hari pelanggaran ───────────────────────────────────────
            # Sesuaikan DIVISOR setelah mengecek satuan aktual TOTAL_TLM/TOTAL_PSW
            # di database (1 jika sudah hari, 8 jika jam, 480 jika menit).
            DIVISOR = 1
            total_tlm = row.TOTAL_TLM or 0
            total_psw = row.TOTAL_PSW or 0
            hari = int((total_tlm + total_psw) / DIVISOR)

            # ── Lama potongan ─────────────────────────────────────────────────
            if row.DURASI_POT and row.DURASI_POT > 0:
                lama_pot = f"{int(row.DURASI_POT)} {(row.SATUAN_DURASI or 'Bulan').strip()}"
            else:
                lama_pot = "0 Bulan"

            data.append({
                'no': i,
                'nama': row.NAMA or '-',
                'hari': hari,
                'kategori': kategori,
                'jenis': row.TINDAKAN or row.NAMA_POT or '-',
                'potongan': int(row.PERSEN_POT or 0),
                'lama_pot': lama_pot
            })

        return data

    except Exception as e:
        import traceback
        traceback.print_exc()
        return []


def _parse_tanggal(value):
    """
    Konversi nilai TGL_LAHIR / TMT_PANGKAT menjadi objek `date` Python,
    apapun tipe aslinya dari database (datetime, date, atau string).
    Mengembalikan None jika tidak bisa di-parse (data kosong/rusak),
    supaya baris tsb bisa di-skip alih-alih membuat request error 500.
    """
    if value is None:
        return None

    if isinstance(value, datetime):
        return value.date()
    if isinstance(value, date):
        return value

    if isinstance(value, str):
        value = value.strip()
        if not value:
            return None

        formats = (
            '%Y-%m-%d %H:%M:%S',
            '%Y-%m-%d',
            '%Y/%m/%d',
            '%d-%m-%Y',
            '%d/%m/%Y',
            '%Y.%m.%d',
        )
        for fmt in formats:
            try:
                return datetime.strptime(value, fmt).date()
            except ValueError:
                continue

        try:
            return datetime.fromisoformat(value).date()
        except ValueError:
            return None

    return None


def dashboard_pensiun():
    """
    Render halaman Dashboard Pensiun.
    Menampilkan daftar pegawai aktif yang mendekati usia pensiun,
    beserta tanggal lahir dan umur saat ini.
    """
    data_pensiun = _get_data_pensiun()
    return render_template(
        'pages/dashboard_1/Dashboard Pensiun.html',
        data_pensiun=data_pensiun
    )


def _get_data_pensiun(batas_usia_minimal=55):
    """
    Ambil pegawai aktif yang punya TGL_LAHIR dan usianya sudah
    >= batas_usia_minimal (default 55 tahun), diurutkan dari yang
    paling tua (paling dekat masa pensiun) ke yang termuda.

    Baris dengan TGL_LAHIR yang tidak bisa di-parse akan di-skip
    (tidak menyebabkan seluruh halaman error).

    Catatan: usia pensiun PNS umumnya 58-60 tahun tergantung jabatan;
    sesuaikan batas_usia_minimal sesuai kebijakan instansi.
    """
    results = Pegawai.query.filter(
        Pegawai.TGL_LAHIR.isnot(None),
        (Pegawai.IS_KELUAR.is_(None)) | (Pegawai.IS_KELUAR == 0)
    ).all()

    today = date.today()
    data = []

    for pegawai in results:
        tgl_lahir = _parse_tanggal(pegawai.TGL_LAHIR)

        if tgl_lahir is None:
            continue

        umur = _hitung_umur(tgl_lahir, today)

        if umur >= batas_usia_minimal:
            data.append({
                'nip': pegawai.NIP,
                'tgl_lahir': tgl_lahir,
                'tgl_lahir_str': tgl_lahir.strftime('%Y.%m.%d'),
                'umur': umur
            })

    data.sort(key=lambda x: x['umur'], reverse=True)

    for i, row in enumerate(data, 1):
        row['no'] = i

    return data


def _hitung_umur(tgl_lahir, sampai_tanggal):
    """Hitung umur (tahun penuh) dari tgl_lahir sampai sampai_tanggal."""
    if not tgl_lahir:
        return 0

    umur = sampai_tanggal.year - tgl_lahir.year
    if (sampai_tanggal.month, sampai_tanggal.day) < (tgl_lahir.month, tgl_lahir.day):
        umur -= 1

    return umur


def dashboard_pangkat():
    """
    Render halaman Dashboard Pangkat.
    Menampilkan daftar pegawai beserta TMT Pangkat, Golongan, dan
    Rentang waktu (lama menduduki golongan saat ini sejak TMT_PANGKAT).
    """
    data_pangkat = _get_data_pangkat()
    return render_template(
        'pages/dashboard_1/Dashboard Pangkat.html',
        data_pangkat=data_pangkat
    )


def _get_data_pangkat():
    """
    Join PEGAWAI -> MF_GOL (via GOL_ID) untuk mendapatkan nama golongan,
    lalu hitung rentang waktu sejak TMT_PANGKAT sampai hari ini.
    Hanya pegawai aktif (IS_KELUAR != 1) yang punya TMT_PANGKAT yang ditampilkan,
    diurutkan dari yang paling lama menduduki golongan saat ini.
    """
    results = Pegawai.query.join(
        MfGolongan, Pegawai.GOL_ID == MfGolongan.GOL_ID
    ).filter(
        Pegawai.TMT_PANGKAT.isnot(None),
        (Pegawai.IS_KELUAR.is_(None)) | (Pegawai.IS_KELUAR == 0)
    ).order_by(Pegawai.TMT_PANGKAT.asc()).all()

    data = []
    today = date.today()

    for i, pegawai in enumerate(results, 1):
        golongan = MfGolongan.query.get(pegawai.GOL_ID)

        tmt = _parse_tanggal(pegawai.TMT_PANGKAT)
        rentang = _hitung_rentang(tmt, today) if tmt else '-'

        data.append({
            'no': i,
            'nip': pegawai.NIP,
            'nama': pegawai.NAMA,
            'tmt_pangkat': tmt.strftime('%Y.%m.%d') if tmt else '-',
            'gol': golongan.NAMA_GOL if golongan else '-',
            'rentang': rentang
        })

    return data


def _hitung_rentang(tmt_pangkat, sampai_tanggal):
    """
    Hitung selisih waktu dari tmt_pangkat sampai sampai_tanggal
    dalam format "Xt, Yb, Zh" (tahun, bulan, hari).
    """
    if not tmt_pangkat:
        return '-'

    tahun = sampai_tanggal.year - tmt_pangkat.year
    bulan = sampai_tanggal.month - tmt_pangkat.month
    hari = sampai_tanggal.day - tmt_pangkat.day

    if hari < 0:
        bulan -= 1
        bulan_sebelumnya = sampai_tanggal.month - 1 or 12
        tahun_bulan_sebelumnya = sampai_tanggal.year if sampai_tanggal.month > 1 else sampai_tanggal.year - 1
        hari_di_bulan_sebelumnya = _hari_dalam_bulan(tahun_bulan_sebelumnya, bulan_sebelumnya)
        hari += hari_di_bulan_sebelumnya

    if bulan < 0:
        tahun -= 1
        bulan += 12

    return f"{tahun}t, {bulan}b, {hari}h"


def _hari_dalam_bulan(tahun, bulan):
    """Jumlah hari dalam bulan tertentu (menangani tahun kabisat)."""
    if bulan == 12:
        next_month = date(tahun + 1, 1, 1)
    else:
        next_month = date(tahun, bulan + 1, 1)
    return (next_month - date(tahun, bulan, 1)).days


def dashboard_kgb():
    """
    Render halaman Dashboard KGB.
    Menampilkan daftar pegawai beserta TMT CPNS, TMT PNS, Golongan Recruitment,
    dan Rentang (sisa waktu menuju tanggal KGB berikutnya, siklus 2 tahun sejak TMT_PNS).
    """
    data_kgb = _get_data_kgb()
    return render_template(
        'pages/dashboard_1/Dashboard KGB.html',
        data_kgb=data_kgb
    )


def _get_data_kgb(siklus_tahun=2):
    """
    Ambil pegawai aktif yang punya TMT_PNS, lalu hitung tanggal KGB
    berikutnya (kelipatan siklus_tahun tahun sejak TMT_PNS yang > hari ini),
    dan tampilkan sisa waktu (Rentang) menuju tanggal tsb.
    """
    results = Pegawai.query.filter(
        Pegawai.TMT_PNS.isnot(None),
        (Pegawai.IS_KELUAR.is_(None)) | (Pegawai.IS_KELUAR == 0)
    ).all()

    today = date.today()
    data = []

    for pegawai in results:
        tmt_cpns = _parse_tanggal(pegawai.TMT_CPNS)
        tmt_pns = _parse_tanggal(pegawai.TMT_PNS)

        if tmt_pns is None:
            continue

        tgl_kgb_berikutnya = _hitung_tanggal_kgb_berikutnya(tmt_pns, today, siklus_tahun)
        rentang = _hitung_rentang(today, tgl_kgb_berikutnya)

        data.append({
            'nip': pegawai.NIP,
            'nama': pegawai.NAMA,
            'tmt_cpns': tmt_cpns.strftime('%Y.%m.%d') if tmt_cpns else '-',
            'tmt_pns': tmt_pns.strftime('%Y.%m.%d') if tmt_pns else '-',
            'gol_recruit': pegawai.GOL_RECRUIT or '-',
            'tgl_kgb_berikutnya': tgl_kgb_berikutnya,
            'rentang': rentang
        })

    data.sort(key=lambda x: x['tgl_kgb_berikutnya'])

    for i, row in enumerate(data, 1):
        row['no'] = i

    return data


def _hitung_tanggal_kgb_berikutnya(tmt_pns, sampai_tanggal, siklus_tahun=2):
    """
    Hitung tanggal KGB berikutnya: kelipatan siklus_tahun tahun sejak
    tmt_pns, yang jatuh setelah (atau sama dengan) sampai_tanggal.
    """
    tahun_berjalan = tmt_pns.year
    tanggal_kgb = tmt_pns

    while tanggal_kgb < sampai_tanggal:
        tahun_berjalan += siklus_tahun
        try:
            tanggal_kgb = tanggal_kgb.replace(year=tahun_berjalan)
        except ValueError:
            tanggal_kgb = tanggal_kgb.replace(year=tahun_berjalan, day=28)

    return tanggal_kgb


def dashboard_trt():
    """Render halaman Dashboard TRT."""
    return render_template('pages/dashboard_1/Dashboard TRT.html')