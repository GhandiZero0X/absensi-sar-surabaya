from flask import render_template, request, jsonify
from app.models.pegawaiModel import Pegawai
from app.models.timSiagaModel import MfTimSiaga
from app.models.timSiagaAnggotaModel import MfTimSiagaAnggota
from sqlalchemy import func

def home():
    return render_template('index.html')

def search_buku_telp():
    q = request.args.get('q', '').strip()
    if not q:
        return jsonify([])

    keyword = f'%{q.lower()}%'
    results = Pegawai.query.filter(
        func.lower(Pegawai.NAMA).like(keyword) |
        func.lower(Pegawai.NO_TELP).like(keyword) |
        func.lower(Pegawai.ALAMAT).like(keyword)
    ).all()

    data = [{
        'nama': p.NAMA or '',
        'instansi': 'Basarnas Surabaya',
        'no_telp': p.NO_TELP or '',
        'alamat': p.ALAMAT or ''
    } for p in results]

    return jsonify(data)

def get_piket_siaga():
    tanggal = request.args.get('tanggal')
    shift = request.args.get('shift')

    if not tanggal or not shift:
        return jsonify({'success': False, 'message': 'Tanggal dan shift wajib diisi.'}), 400

    try:
        year, month, _ = tanggal.split('-')
        month = str(int(month))   # normalisasi: '04' -> '4', '11' -> '11'
    except ValueError:
        return jsonify({'success': False, 'message': 'Format tanggal tidak valid.'}), 400

    anggota_list = MfTimSiagaAnggota.query.filter_by(
        BULAN_PERIODE=month,
        TAHUN_PERIODE=year,
        SHIFT=shift,
        IS_AKTIF='Y'
    ).all()

    if not anggota_list:
        return jsonify({'success': False, 'message': 'Tidak ada data piket siaga.'}), 404

    wilayah_map = {}
    for ag in anggota_list:
        pegawai = Pegawai.query.filter_by(NIP=ag.NIP).first()
        if not pegawai:
            continue

        wilayah = ag.ID_UNIT_KERJA or 'Tidak Diketahui'
        if wilayah not in wilayah_map:
            wilayah_map[wilayah] = []

        wilayah_map[wilayah].append({
            'nama': pegawai.NAMA,
            'no_telp': pegawai.NO_TELP,
            'fungsional': ag.FUNGSIONAL or ''
        })

    data = [{'wilayah': w, 'anggota': a} for w, a in wilayah_map.items()]

    return jsonify({
        'success': True,
        'periode': tanggal,
        'shift': shift,
        'data': data
    })


def get_pelanggaran_disiplin():
    # Data contoh sementara – nanti ganti dengan query dari database
    data = [
        {"no": 1, "nama": "IRWAN FERI WINATA", "hari": 28, "kategori": "Hukuman Disiplin Sedang", "jenis": "Penurunan Pangkat Setingkat Lebih Rendah Selama 1 Tahun", "potongan": 50, "lama_pot": "6 Bulan"},
        {"no": 2, "nama": "HANIF HAZMI, S. I. Kom.", "hari": 26, "kategori": "Hukuman Disiplin Berat", "jenis": "Pembebasan dari jabatannya menjadi jabatan pelaksana", "potongan": 0, "lama_pot": "12 Bulan"},
        {"no": 3, "nama": "BISMA FIRMANSYAH A.Md.T.", "hari": 25, "kategori": "Hukuman Disiplin Sedang", "jenis": "Penundaan Kenaikan Pangkat Berkala Selama 1 Tahun", "potongan": 50, "lama_pot": "4 Bulan"},
        {"no": 4, "nama": "YUDI LISTIYONO", "hari": 25, "kategori": "Hukuman Disiplin Sedang", "jenis": "Penundaan Kenaikan Pangkat Berkala Selama 1 Tahun", "potongan": 50, "lama_pot": "4 Bulan"},
        {"no": 5, "nama": "NUVA WIDIYANTO", "hari": 24, "kategori": "Hukuman Disiplin Berat", "jenis": "Penurunan jabatan setingkat lebih rendah", "potongan": 0, "lama_pot": "12 Bulan"},
        {"no": 6, "nama": "TEGUH PRIYAMBODO", "hari": 24, "kategori": "Hukuman Disiplin Berat", "jenis": "Penurunan jabatan setingkat lebih rendah", "potongan": 0, "lama_pot": "12 Bulan"},
        {"no": 7, "nama": "YUDHI SETIAWAN", "hari": 24, "kategori": "Hukuman Disiplin Berat", "jenis": "Penurunan jabatan setingkat lebih rendah", "potongan": 0, "lama_pot": "12 Bulan"},
        {"no": 8, "nama": "CUCUPS PUTRA IMPRIAN ROSTYA", "hari": 17, "kategori": "Hukuman Disiplin Sedang", "jenis": "Penundaan Kenaikan Gaji Berkala Selama 1 Tahun", "potongan": 50, "lama_pot": "2 Bulan"},
        {"no": 9, "nama": "EDI SURYONO", "hari": 11, "kategori": "Hukuman Disiplin Sedang", "jenis": "Pemotongan tunjangan kinerja", "potongan": 25, "lama_pot": "6 Bulan"},
        {"no": 10, "nama": "RIFQI IRAWAN", "hari": 11, "kategori": "Hukuman Disiplin Sedang", "jenis": "Pemotongan tunjangan kinerja", "potongan": 25, "lama_pot": "6 Bulan"},
        {"no": 11, "nama": "RISKY PUTRA BUANA", "hari": 9, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 20, "lama_pot": "6 Bulan"},
        {"no": 12, "nama": "KURNIADI ARIF CAHYONO", "hari": 8, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 20, "lama_pot": "6 Bulan"},
        {"no": 13, "nama": "ADISTYA SAHDHA, S.AP., M.Sc", "hari": 7, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 20, "lama_pot": "6 Bulan"},
        {"no": 14, "nama": "EBTARIO DWI PRAKOSO", "hari": 7, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 20, "lama_pot": "6 Bulan"},
        {"no": 15, "nama": "DEKKY HAEROEL ROMADHON SAH", "hari": 6, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 0, "lama_pot": "0"},
        {"no": 16, "nama": "I PT EKA AGUS SETIAWAN", "hari": 6, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 0, "lama_pot": "0"},
        {"no": 17, "nama": "DINI NURFITRIYAH, A.Md", "hari": 5, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 0, "lama_pot": "0"},
        {"no": 18, "nama": "I DEWA NYOMAN ARYA ASTAMAN", "hari": 5, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 0, "lama_pot": "0"},
        {"no": 19, "nama": "KETUT DWI ARYO BISMOKO", "hari": 5, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 0, "lama_pot": "0"},
        {"no": 20, "nama": "TAUFIQURRAHMAN", "hari": 5, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 0, "lama_pot": "0"},
        {"no": 21, "nama": "WAHYU SETIA BUDI", "hari": 5, "kategori": "Hukuman Disiplin Ringan", "jenis": "Teguran Tertulis", "potongan": 0, "lama_pot": "0"},
    ]
    return jsonify({"success": True, "data": data})