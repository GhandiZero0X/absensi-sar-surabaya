# testing/test_connection.py
from app import create_app, db
from sqlalchemy import text

app = create_app()

with app.app_context():
    try:
        db.session.execute(text('SELECT 1'))
        print("✅ Koneksi ke database berhasil!")
    except Exception as e:
        print("❌ Koneksi gagal:", e)