# controllers/dashboard_1MediaInformasiController.py
import os
import uuid
from flask import render_template, request, jsonify, session, current_app, url_for
from datetime import date, datetime
from werkzeug.utils import secure_filename
from app import db
from app.models.mediaInformasiModel import MediaInformasi

ALLOWED_EXTENSIONS = {'jpg', 'jpeg', 'png', 'webp'}
SLIDE_UPLOAD_SUBFOLDER = 'static_home/img/slides'
TOTAL_HERO_SLOTS = 5


def media_informasi():
    """Render halaman Media Informasi (Runing Text)."""
    return render_template('pages/dashboard_1/Media Informasi.html')

def media_informasi_detail():
    """Render halaman Detail Media Informasi (Slide JPG)."""
    return render_template('pages/dashboard_1/Media Informasi Slide JPG.html')


def _get_next_media_informasi_id():
    """
    Hitung MED_INFOR_ID berikutnya secara manual (MAX + 1).
    Tabel ini hasil migrasi dari Sybase yang DDL aslinya tidak mendefinisikan
    AUTO_INCREMENT pada MED_INFOR_ID, sehingga ID dihitung eksplisit di sini.
    """
    max_id = db.session.query(db.func.max(MediaInformasi.MED_INFOR_ID)).scalar()
    return (max_id or 0) + 1


def _allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


def save_media_informasi():
    """
    Simpan pengumuman/running text baru ke tabel MEDIA_INFORMASI.
    Dipanggil dari tombol "Send" di halaman Media Informasi (Runing Text).
    """
    data = request.get_json() or {}

    deskripsi = (data.get('deskripsi') or '').strip()
    tgl_mulai = data.get('tgl_mulai')
    tgl_akhir = data.get('tgl_akhir')
    is_aktif = (data.get('is_aktif') or '').strip().upper()

    if not deskripsi:
        return jsonify({'success': False, 'message': 'Deskripsi wajib diisi.'}), 400

    if is_aktif not in ('Y', 'N'):
        return jsonify({'success': False, 'message': 'Isi Aktif harus Y atau N.'}), 400

    try:
        publish_start = datetime.strptime(tgl_mulai, '%Y-%m-%d').date() if tgl_mulai else None
        publish_end = datetime.strptime(tgl_akhir, '%Y-%m-%d').date() if tgl_akhir else None
    except ValueError:
        return jsonify({'success': False, 'message': 'Format tanggal tidak valid.'}), 400

    media = MediaInformasi(
        MED_INFOR_ID=_get_next_media_informasi_id(),
        TRX='MI_Pengumuman',
        DESKRIPSI=deskripsi,
        PUBLISH_DATE_START=publish_start,
        PUBLISH_DATE_END=publish_end,
        IS_AKTIF=is_aktif,
        PIC=session.get('nama'),
        UPDATE_BY=session.get('nip'),
        UPDATE_DATE=datetime.now()
    )

    try:
        db.session.add(media)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'message': f'Gagal menyimpan data: {str(e)}'}), 500

    return jsonify({
        'success': True,
        'message': 'Pengumuman berhasil disimpan.',
        'data': media.to_dict()
    })


def save_media_informasi_slide():
    """
    Upload gambar JPG untuk slide hero carousel di homepage, lalu simpan
    metadata-nya ke MEDIA_INFORMASI dengan TRX='MI_SlideJPG'.

    Slide otomatis mengisi slot hero berikutnya yang kosong (1-5), berurutan
    berdasarkan urutan upload. Jika kelima slot sudah terisi upload aktif,
    upload baru menggantikan slot dengan MED_INFOR_ID terkecil (paling lama)
    di antara slide yang aktif.

    Setelah PUBLISH_DATE_END terlewati, slide otomatis tidak lagi dianggap
    aktif -> slot yang ia tempati kembali menampilkan gambar default
    (hero_1.jpg s.d. hero_5.jpg), tanpa perlu aksi manual apapun, karena
    perhitungan slot dilakukan ulang setiap request berdasarkan status aktif
    saat itu.

    Form-data yang diharapkan:
      - file        : file JPG (request.files)
      - tgl_mulai   : YYYY-MM-DD (opsional)
      - tgl_akhir   : YYYY-MM-DD (opsional)
      - is_aktif    : 'Y' atau 'N'
    """
    if 'file' not in request.files:
        return jsonify({'success': False, 'message': 'File wajib diupload.'}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({'success': False, 'message': 'File belum dipilih.'}), 400

    if not _allowed_file(file.filename):
        return jsonify({'success': False, 'message': 'File harus berformat .jpg atau .jpeg.'}), 400

    tgl_mulai = request.form.get('tgl_mulai')
    tgl_akhir = request.form.get('tgl_akhir')
    is_aktif = (request.form.get('is_aktif') or '').strip().upper()

    if is_aktif not in ('Y', 'N'):
        return jsonify({'success': False, 'message': 'Isi Aktif harus Y atau N.'}), 400

    try:
        publish_start = datetime.strptime(tgl_mulai, '%Y-%m-%d').date() if tgl_mulai else None
        publish_end = datetime.strptime(tgl_akhir, '%Y-%m-%d').date() if tgl_akhir else None
    except ValueError:
        return jsonify({'success': False, 'message': 'Format tanggal tidak valid.'}), 400

    # Simpan file ke disk dengan nama unik supaya tidak bentrok
    original_filename = secure_filename(file.filename)
    ext = original_filename.rsplit('.', 1)[1].lower()
    unique_filename = f"{uuid.uuid4().hex}.{ext}"

    upload_dir = os.path.join(current_app.static_folder, SLIDE_UPLOAD_SUBFOLDER)
    os.makedirs(upload_dir, exist_ok=True)

    file_path = os.path.join(upload_dir, unique_filename)
    try:
        file.save(file_path)
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'message': f'Gagal menyimpan file: {str(e)}'}), 500

    relative_path = f"{SLIDE_UPLOAD_SUBFOLDER}/{unique_filename}"

    media = MediaInformasi(
        MED_INFOR_ID=_get_next_media_informasi_id(),
        TRX='MI_SlideJPG',
        NAMA_FILE=unique_filename,
        DESKRIPSI=original_filename,
        PUBLISH_DATE_START=publish_start,
        PUBLISH_DATE_END=publish_end,
        IS_AKTIF=is_aktif,
        PIC=session.get('nama'),
        UPDATE_BY=session.get('nip'),
        UPDATE_DATE=datetime.now(),
        ALAMAT=relative_path
    )

    try:
        db.session.add(media)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        # Hapus file yang sudah terlanjur disimpan jika insert DB gagal
        if os.path.exists(file_path):
            os.remove(file_path)
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'message': f'Gagal menyimpan data: {str(e)}'}), 500

    return jsonify({
        'success': True,
        'message': 'Slide berhasil diupload.',
        'data': media.to_dict()
    })


def get_latest_running_text():
    """
    Ambil deskripsi Media Informasi dengan MED_INFOR_ID TERBESAR (terbaru)
    yang statusnya aktif (IS_AKTIF='Y') dan sedang dalam periode publikasi.
    """
    today = date.today()

    media = MediaInformasi.query.filter(
        MediaInformasi.TRX == 'MI_Pengumuman',
        MediaInformasi.IS_AKTIF == 'Y'
    ).filter(
        (MediaInformasi.PUBLISH_DATE_START.is_(None)) | (MediaInformasi.PUBLISH_DATE_START <= today)
    ).filter(
        (MediaInformasi.PUBLISH_DATE_END.is_(None)) | (MediaInformasi.PUBLISH_DATE_END >= today)
    ).order_by(
        MediaInformasi.MED_INFOR_ID.desc()
    ).first()

    return media.DESKRIPSI if media else None

def get_media_informasi_list():
    """
    Ambil semua data pengumuman (TRX='MI_Pengumuman') untuk ditampilkan
    di tabel "Cari Transaksi", diurutkan dari yang terbaru (MED_INFOR_ID desc).
    Dipanggil saat tombol Refresh diklik.
    """
    results = MediaInformasi.query.filter(
        MediaInformasi.TRX == 'MI_Pengumuman'
    ).order_by(
        MediaInformasi.MED_INFOR_ID.desc()
    ).all()

    data = []
    for i, row in enumerate(results, 1):
        data.append({
            'no': i,
            'med_infor_id': row.MED_INFOR_ID,
            'deskripsi': row.DESKRIPSI or '-',
            'tgl_mulai': row.PUBLISH_DATE_START.strftime('%Y-%m-%d') if row.PUBLISH_DATE_START else '',
            'tgl_akhir': row.PUBLISH_DATE_END.strftime('%Y-%m-%d') if row.PUBLISH_DATE_END else '',
            'upload': row.UPDATE_DATE.strftime('%Y-%m-%d %H:%M') if row.UPDATE_DATE else '-',
            'is_aktif': row.IS_AKTIF or 'N'
        })

    return jsonify({'success': True, 'data': data})


def get_media_informasi_by_id(med_infor_id):
    """
    Ambil satu record berdasarkan MED_INFOR_ID, dipakai saat tombol Edit
    diklik untuk mengisi field form di bagian atas halaman.
    """
    media = MediaInformasi.query.filter_by(
        MED_INFOR_ID=med_infor_id, TRX='MI_Pengumuman'
    ).first()

    if not media:
        return jsonify({'success': False, 'message': 'Data tidak ditemukan.'}), 404

    return jsonify({
        'success': True,
        'data': {
            'med_infor_id': media.MED_INFOR_ID,
            'deskripsi': media.DESKRIPSI or '',
            'tgl_mulai': media.PUBLISH_DATE_START.strftime('%Y-%m-%d') if media.PUBLISH_DATE_START else '',
            'tgl_akhir': media.PUBLISH_DATE_END.strftime('%Y-%m-%d') if media.PUBLISH_DATE_END else '',
            'is_aktif': media.IS_AKTIF or ''
        }
    })


def update_media_informasi(med_infor_id):
    """
    Update data pengumuman yang sudah ada berdasarkan MED_INFOR_ID.
    Dipanggil saat tombol Send diklik dalam mode edit (bukan create baru).
    """
    media = MediaInformasi.query.filter_by(
        MED_INFOR_ID=med_infor_id, TRX='MI_Pengumuman'
    ).first()

    if not media:
        return jsonify({'success': False, 'message': 'Data tidak ditemukan.'}), 404

    data = request.get_json() or {}

    deskripsi = (data.get('deskripsi') or '').strip()
    tgl_mulai = data.get('tgl_mulai')
    tgl_akhir = data.get('tgl_akhir')
    is_aktif = (data.get('is_aktif') or '').strip().upper()

    if not deskripsi:
        return jsonify({'success': False, 'message': 'Deskripsi wajib diisi.'}), 400

    if is_aktif not in ('Y', 'N'):
        return jsonify({'success': False, 'message': 'Isi Aktif harus Y atau N.'}), 400

    try:
        publish_start = datetime.strptime(tgl_mulai, '%Y-%m-%d').date() if tgl_mulai else None
        publish_end = datetime.strptime(tgl_akhir, '%Y-%m-%d').date() if tgl_akhir else None
    except ValueError:
        return jsonify({'success': False, 'message': 'Format tanggal tidak valid.'}), 400

    media.DESKRIPSI = deskripsi
    media.PUBLISH_DATE_START = publish_start
    media.PUBLISH_DATE_END = publish_end
    media.IS_AKTIF = is_aktif
    media.UPDATE_BY = session.get('nip')
    media.UPDATE_DATE = datetime.now()

    try:
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'message': f'Gagal memperbarui data: {str(e)}'}), 500

    return jsonify({
        'success': True,
        'message': 'Pengumuman berhasil diperbarui.',
        'data': media.to_dict()
    })


def nonaktifkan_media_informasi(med_infor_id):
    """
    Set IS_AKTIF menjadi 'N' untuk record tertentu. Dipanggil saat tombol
    "Non Aktif" pada tabel Cari Transaksi diklik. Begitu IS_AKTIF='N',
    record ini tidak lagi lolos filter get_latest_running_text(), sehingga
    otomatis tidak tampil sebagai running text di homepage.
    """
    media = MediaInformasi.query.filter_by(
        MED_INFOR_ID=med_infor_id, TRX='MI_Pengumuman'
    ).first()

    if not media:
        return jsonify({'success': False, 'message': 'Data tidak ditemukan.'}), 404

    media.IS_AKTIF = 'N'
    media.UPDATE_BY = session.get('nip')
    media.UPDATE_DATE = datetime.now()

    try:
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'message': f'Gagal menonaktifkan data: {str(e)}'}), 500

    return jsonify({'success': True, 'message': 'Data berhasil dinonaktifkan.'})

def get_hero_images():
    """
    Tentukan gambar untuk kelima slot hero carousel di homepage.

    Ambil slide upload (TRX='MI_SlideJPG') yang statusnya aktif dan sedang
    dalam periode publikasi, urutkan berdasarkan MED_INFOR_ID (ascending =
    urutan upload paling lama ke paling baru), lalu map ke slot 1..5.
    Slot yang tidak terisi upload aktif otomatis pakai gambar default
    (hero_1.jpg s.d. hero_5.jpg).

    Return: list of dict [{'slot': 1, 'src': '...', 'is_default': bool}, ...]
    panjang selalu TOTAL_HERO_SLOTS (5).
    """
    today = date.today()

    active_slides = MediaInformasi.query.filter(
        MediaInformasi.TRX == 'MI_SlideJPG',
        MediaInformasi.IS_AKTIF == 'Y'
    ).filter(
        (MediaInformasi.PUBLISH_DATE_START.is_(None)) | (MediaInformasi.PUBLISH_DATE_START <= today)
    ).filter(
        (MediaInformasi.PUBLISH_DATE_END.is_(None)) | (MediaInformasi.PUBLISH_DATE_END >= today)
    ).order_by(
        MediaInformasi.MED_INFOR_ID.asc()
    ).limit(TOTAL_HERO_SLOTS).all()

    hero_images = []
    for i in range(TOTAL_HERO_SLOTS):
        slot_number = i + 1
        if i < len(active_slides):
            slide = active_slides[i]
            hero_images.append({
                'slot': slot_number,
                'src': url_for('static', filename=slide.ALAMAT),
                'is_default': False
            })
        else:
            hero_images.append({
                'slot': slot_number,
                'src': url_for('static', filename=f'static_home/img/hero_{slot_number}.jpg'),
                'is_default': True
            })

    return hero_images