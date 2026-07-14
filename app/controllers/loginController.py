from flask import request, jsonify, session
from app.models.pegawaiModel import Pegawai

def login():
    data = request.get_json()
    nip = data.get('nip', '').strip()
    password = data.get('password', '').strip()

    # Validasi input
    if not nip or not password:
        return jsonify({'success': False, 'message': 'NIP dan Password wajib diisi.'}), 400

    # Cari pegawai berdasarkan NIP
    pegawai = Pegawai.query.filter_by(NIP=nip).first()
    if not pegawai:
        return jsonify({'success': False, 'message': 'NIP tidak ditemukan.'}), 401

    # Cek password (asumsi masih plaintext, nanti bisa di‑hash)
    if pegawai.PASS != password:
        return jsonify({'success': False, 'message': 'Password salah.'}), 401

    # Set session login
    session.permanent = True  # opsional, agar session tidak hilang saat browser ditutup
    session['logged_in'] = True
    session['nip'] = pegawai.NIP
    session['nama'] = pegawai.NAMA

    return jsonify({
        'success': True,
        'message': 'Login berhasil.',
        'data': {
            'nip': pegawai.NIP,
            'nama': pegawai.NAMA,
            'jabatan': pegawai.JABATAN
        }
    })

def logout():
    session.clear()
    return jsonify({'success': True, 'message': 'Logout berhasil.'})