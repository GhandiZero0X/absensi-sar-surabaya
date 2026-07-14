# app/controllers/homeController.py
from flask import render_template, request, jsonify
from app.models.pegawaiModel import Pegawai
from sqlalchemy import func

# Route untuk halaman utama
def home():
    return render_template('index.html')

# Fitur Search Buku Telp dengan kata kunci nomor telp atau nama pegawai
def search_buku_telp():
    q = request.args.get('q', '').strip()

    if not q:
        # Jangan tampilkan apa pun di awal
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

