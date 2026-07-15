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