# app/routes/routes.py

from flask import Blueprint, jsonify
from app.controllers.homeController import get_pelanggaran_disiplin, get_piket_siaga, home, search_buku_telp
from app.controllers.loginController import login, logout

from app.models.pegawaiModel import Pegawai

main = Blueprint('main', __name__)

@main.route('/')
def index():
    return home()

@main.route('/api/search_pegawai')
def api_search_pegawai():
    return search_buku_telp()

@main.route('/api/piket_siaga')
def api_piket_siaga():
    return get_piket_siaga()

@main.route('/api/pelanggaran_disiplin')
def api_pelanggaran_disiplin():
    return get_pelanggaran_disiplin()

@main.route('/api/login', methods=['POST'])
def api_login():
    return login()

@main.route('/api/logout', methods=['POST'])
def api_logout():
    return logout()

@main.route('/api/pegawai/preview', methods=['GET'])
def preview_pegawai():
    data = Pegawai.query.order_by(Pegawai.NIP.asc()).limit(20).all()
    return jsonify({
        'count': len(data),
        'data': [pegawai.to_dict() for pegawai in data]
    })