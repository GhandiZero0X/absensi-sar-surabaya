# controllers/dashboard_2OtoritasPersetujuanController.py
import io
import xlsxwriter
from reportlab.lib import colors
from reportlab.lib.pagesizes import A4, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from flask import render_template, request, jsonify, send_file
from datetime import datetime
from app import db
from app.models.hakAksesFormModel import HakAksesForm
from app.models.logActivityModel import LogActivity
from app.models.otorisasiModel import Otorisasi
from app.models.pegawaiModel import Pegawai

# ============================================
# EXPORT EXCEL
# ============================================
def export_otorisasi_excel():
    """
    Export data otorisasi ke Excel
    """
    try:
        tipe = request.args.get('tipe', 'kasiops')  # kasiops / kakansar
        status = request.args.get('status', 'belum')  # belum / sudah
        
        # Ambil data sesuai filter
        if tipe == 'kasiops':
            if status == 'belum':
                results = get_otorisasi_kasiops_belum_data()
            else:
                results = get_otorisasi_kasiops_sudah_data()
        else:
            if status == 'belum':
                results = get_otorisasi_kakansar_belum_data()
            else:
                results = get_otorisasi_kakansar_sudah_data()
        
        # Buat Excel di memory
        output = io.BytesIO()
        workbook = xlsxwriter.Workbook(output, {'in_memory': True})
        worksheet = workbook.add_worksheet('Otorisasi')
        
        # Format header
        header_format = workbook.add_format({
            'bold': True,
            'bg_color': '#EB6831',
            'font_color': 'white',
            'border': 1,
            'align': 'center',
            'valign': 'vcenter',
            'text_wrap': True
        })
        
        # Format data
        cell_format = workbook.add_format({
            'border': 1,
            'align': 'left',
            'valign': 'vcenter',
            'text_wrap': True
        })
        
        center_format = workbook.add_format({
            'border': 1,
            'align': 'center',
            'valign': 'vcenter'
        })
        
        # Set lebar kolom
        worksheet.set_column('A:A', 5)   # No
        worksheet.set_column('B:B', 15)  # Perihal
        worksheet.set_column('C:C', 25)  # Personil
        worksheet.set_column('D:D', 20)  # Jabatan
        worksheet.set_column('E:E', 30)  # Keterangan
        worksheet.set_column('F:F', 12)  # Status
        
        # Header
        headers = ['No', 'Perihal', 'Personil', 'Jabatan', 'Keterangan', 'Status']
        for col, header in enumerate(headers):
            worksheet.write(0, col, header, header_format)
        
        # Data
        for row, item in enumerate(results, 1):
            worksheet.write(row, 0, item.get('no', row), center_format)
            worksheet.write(row, 1, item.get('perihal', '-'), cell_format)
            worksheet.write(row, 2, item.get('personil', '-'), cell_format)
            worksheet.write(row, 3, item.get('jabatan', '-'), cell_format)
            worksheet.write(row, 4, item.get('keterangan', '-'), cell_format)
            
            act = item.get('act', -1)
            if act == 3:
                status_text = 'Release'
            elif act == 0:
                status_text = 'Reject'
            else:
                status_text = 'Pending'
            worksheet.write(row, 5, status_text, center_format)
        
        workbook.close()
        output.seek(0)
        
        filename = f'Otorisasi_{tipe}_{status}_{datetime.now().strftime("%Y%m%d_%H%M%S")}.xlsx'
        
        return send_file(
            output,
            mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            as_attachment=True,
            download_name=filename
        )
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})


def export_otorisasi_pdf():
    """
    Export data otorisasi ke PDF
    """
    try:
        tipe = request.args.get('tipe', 'kasiops')
        status = request.args.get('status', 'belum')
        
        if tipe == 'kasiops':
            if status == 'belum':
                results = get_otorisasi_kasiops_belum_data()
                title = 'Daftar Pengajuan Belum Persetujuan (Kasi Ops)'
            else:
                results = get_otorisasi_kasiops_sudah_data()
                title = 'Daftar Pengajuan Sudah Persetujuan (Kasi Ops)'
        else:
            if status == 'belum':
                results = get_otorisasi_kakansar_belum_data()
                title = 'Daftar Pengajuan Belum Persetujuan (Kepala Kantor)'
            else:
                results = get_otorisasi_kakansar_sudah_data()
                title = 'Daftar Pengajuan Sudah Persetujuan (Kepala Kantor)'
        
        # Buat PDF di memory
        buffer = io.BytesIO()
        doc = SimpleDocTemplate(
            buffer,
            pagesize=landscape(A4),
            rightMargin=30,
            leftMargin=30,
            topMargin=30,
            bottomMargin=30
        )
        
        elements = []
        styles = getSampleStyleSheet()
        title_style = ParagraphStyle(
            'CustomTitle',
            parent=styles['Heading1'],
            fontSize=14,
            spaceAfter=20,
            alignment=1  # Center
        )
        
        elements.append(Paragraph(title, title_style))
        elements.append(Spacer(1, 10))
        
        # Data tabel
        table_data = [['No', 'Perihal', 'Personil', 'Jabatan', 'Keterangan', 'Status']]
        
        for item in results:
            act = item.get('act', -1)
            if act == 3:
                status_text = 'Release'
            elif act == 0:
                status_text = 'Reject'
            else:
                status_text = 'Pending'
            
            table_data.append([
                str(item.get('no', '')),
                item.get('perihal', '-'),
                item.get('personil', '-'),
                item.get('jabatan', '-'),
                item.get('keterangan', '-'),
                status_text
            ])
        
        # Buat tabel
        col_widths = [30, 180, 150, 120, 200, 80]
        table = Table(table_data, colWidths=col_widths, repeatRows=1)
        
        # Style tabel
        style = TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#EB6831')),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
            ('ALIGN', (0, 0), (-1, 0), 'CENTER'),
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
            ('FONTSIZE', (0, 0), (-1, 0), 9),
            ('BOTTOMPADDING', (0, 0), (-1, 0), 8),
            ('BACKGROUND', (0, 1), (-1, -1), colors.white),
            ('TEXTCOLOR', (0, 1), (-1, -1), colors.black),
            ('FONTNAME', (0, 1), (-1, -1), 'Helvetica'),
            ('FONTSIZE', (0, 1), (-1, -1), 8),
            ('ALIGN', (0, 0), (0, -1), 'CENTER'),
            ('GRID', (0, 0), (-1, -1), 0.5, colors.grey),
            ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ])
        
        # Warna alternatif baris
        for i in range(1, len(table_data)):
            if i % 2 == 0:
                style.add('BACKGROUND', (0, i), (-1, i), colors.HexColor('#F5F5F5'))
        
        table.setStyle(style)
        elements.append(table)
        
        doc.build(elements)
        buffer.seek(0)
        
        filename = f'Otorisasi_{tipe}_{status}_{datetime.now().strftime("%Y%m%d_%H%M%S")}.pdf'
        
        return send_file(
            buffer,
            mimetype='application/pdf',
            as_attachment=True,
            download_name=filename
        )
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})


# Helper functions untuk ambil data
def get_otorisasi_kasiops_belum_data():
    results = db.session.query(Otorisasi, Pegawai).outerjoin(
        Pegawai, Otorisasi.NIP == Pegawai.NIP
    ).filter(
        Otorisasi.LEVEL_OTO == 1,
        Otorisasi.ACT == -1,
        Otorisasi.TRX == 'Jadwal Piket Siaga'
    ).order_by(Otorisasi.TGL_PENGAJUAN.desc()).all()
    
    data = []
    for i, (oto, peg) in enumerate(results, 1):
        data.append({
            'no': i,
            'perihal': oto.PERIHAL or '-',
            'personil': peg.NAMA if peg else '-',
            'jabatan': oto.JABATAN or '-',
            'keterangan': oto.KETERANGAN or '-',
            'act': oto.ACT,
        })
    return data


def get_otorisasi_kasiops_sudah_data():
    results = db.session.query(Otorisasi, Pegawai).outerjoin(
        Pegawai, Otorisasi.NIP == Pegawai.NIP
    ).filter(
        Otorisasi.LEVEL_OTO == 1,
        Otorisasi.ACT >= 0,
        Otorisasi.TRX == 'Jadwal Piket Siaga'
    ).order_by(Otorisasi.UPDATE_DATE.desc()).all()
    
    data = []
    for i, (oto, peg) in enumerate(results, 1):
        data.append({
            'no': i,
            'perihal': oto.PERIHAL or '-',
            'personil': peg.NAMA if peg else '-',
            'jabatan': oto.JABATAN or '-',
            'keterangan': oto.KETERANGAN or '-',
            'act': oto.ACT,
        })
    return data


def get_otorisasi_kakansar_belum_data():
    results = db.session.query(Otorisasi, Pegawai).outerjoin(
        Pegawai, Otorisasi.NIP == Pegawai.NIP
    ).filter(
        Otorisasi.LEVEL_OTO == 2,
        Otorisasi.ACT == -1,
        Otorisasi.TRX == 'Jadwal Piket Siaga'
    ).order_by(Otorisasi.TGL_PENGAJUAN.desc()).all()
    
    data = []
    for i, (oto, peg) in enumerate(results, 1):
        data.append({
            'no': i,
            'perihal': oto.PERIHAL or '-',
            'personil': peg.NAMA if peg else '-',
            'jabatan': oto.JABATAN or '-',
            'keterangan': oto.KETERANGAN or '-',
            'act': oto.ACT,
        })
    return data


def get_otorisasi_kakansar_sudah_data():
    results = db.session.query(Otorisasi, Pegawai).outerjoin(
        Pegawai, Otorisasi.NIP == Pegawai.NIP
    ).filter(
        Otorisasi.LEVEL_OTO == 2,
        Otorisasi.ACT >= 0,
        Otorisasi.TRX == 'Jadwal Piket Siaga'
    ).order_by(Otorisasi.UPDATE_DATE.desc()).all()
    
    data = []
    for i, (oto, peg) in enumerate(results, 1):
        data.append({
            'no': i,
            'perihal': oto.PERIHAL or '-',
            'personil': peg.NAMA if peg else '-',
            'jabatan': oto.JABATAN or '-',
            'keterangan': oto.KETERANGAN or '-',
            'act': oto.ACT,
        })
    return data

def otorisasi_persetujuan_kepala_kantor():
    """Render halaman Otorisasi Persetujuan Kepala Kantor."""
    return render_template('pages/dashboard_2/Otorisasi_Persetujuan_Kepala_Kantor.html')

def api_otorisasi_kakansar_belum():
    """
    List pengajuan Jadwal Piket Siaga level 2 (Kakansar) yang masih pending (ACT = -1).
    Ini record yang otomatis "dibuka" setelah Kasi Ops approve di level 1.
    """
    try:
        query = db.session.query(Otorisasi, Pegawai).outerjoin(
            Pegawai, Otorisasi.NIP == Pegawai.NIP
        ).filter(
            Otorisasi.LEVEL_OTO == 2,
            Otorisasi.ACT == -1,
            Otorisasi.TRX == 'Jadwal Piket Siaga'
        ).order_by(Otorisasi.TGL_PENGAJUAN.desc())
 
        results = query.all()
        data = []
        for i, (oto, peg) in enumerate(results, 1):
            data.append({
                'no': i,
                'guid_oto': oto.GUID_OTO,
                'perihal': oto.PERIHAL or '-',
                'keterangan': oto.KETERANGAN or '-',
                'jabatan': oto.JABATAN or '-',
                'personil': peg.NAMA if peg else '-',
                'bulan': oto.BULAN,
                'tahun': oto.TAHUN,
            })
        return jsonify({'success': True, 'data': data})
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e), 'data': []})

def api_otorisasi_kakansar_approve():
    """
    Approve / Reject satu record Otorisasi level 2 (Kakansar).
    act: '0' = reject, '3' = release/approve.

    Kalau APPROVE dan belum ada record LEVEL_OTO=3 untuk GUID ini:
      1. Cari email semua pegawai yang punya HakAksesForm.FormID='injadwalsiaga.aspx'
      2. Kirim notifikasi email (TODO — belum diimplementasikan)
      3. Insert record baru LEVEL_OTO=3 (NIP='999', ACT=-1) sebagai PENANDA
         "email sudah dikirim" — bukan approval sungguhan, sesuai logic VB asli.

    Kalau REJECT: update LogActivity.STATUS_ID juga (GUID_LOG == guid_oto),
    sesuai logic VB (`Update LogActivity set StatusID=...where guidLog=...`).
    """
    try:
        data = request.get_json()
        guid_oto = data.get('guid_oto', '')
        act = str(data.get('act', ''))
        keterangan = data.get('keterangan', '')
        # TODO: ganti 'admin' dengan NIP dari session user yang sedang login
        updated_by = data.get('updated_by', 'admin')

        if not guid_oto:
            return jsonify({'success': False, 'error': 'GUID Otorisasi tidak boleh kosong'})
        if act not in ('0', '3'):
            return jsonify({'success': False, 'error': 'Nilai aksi tidak valid'})

        oto = Otorisasi.query.filter(
            Otorisasi.GUID_OTO == guid_oto,
            Otorisasi.LEVEL_OTO == 2
        ).first()
        if not oto:
            return jsonify({'success': False, 'error': 'Data tidak ditemukan'})

        oto.ACT = int(act)
        oto.KETERANGAN = keterangan
        oto.UPDATE_BY = updated_by
        oto.UPDATE_DATE = datetime.now()

        if act == '0':
            # Reject -> update LogActivity.STATUS_ID juga (sesuai VB)
            log = LogActivity.query.filter(LogActivity.GUID_LOG == guid_oto).first()
            if log:
                log.STATUS_ID = 0
                log.UPDATE_BY = updated_by
                log.UPDATE_DATE = datetime.now()

        elif act == '3':
            # Cek apakah record level 3 (penanda "email terkirim") sudah ada
            oto_level3 = Otorisasi.query.filter(
                Otorisasi.GUID_OTO == guid_oto,
                Otorisasi.LEVEL_OTO == 3
            ).first()

            if not oto_level3:
                # Cari email pegawai yang punya akses form 'injadwalsiaga.aspx'
                penerima = db.session.query(Pegawai).join(
                    HakAksesForm, HakAksesForm.NIP == Pegawai.NIP
                ).filter(
                    HakAksesForm.FORM_ID == 'injadwalsiaga.aspx',
                    Pegawai.MAIL.isnot(None)
                ).all()
 
                # TODO: kirim email notifikasi ke semua `penerima` (butuh Flask-Mail/smtplib)
                # Contoh alamat: [p.MAIL for p in penerima]
                # Belum diimplementasikan — di VB.NET aslinya pakai
                # ClassPDFJadwalPiket.SendEmailNotifJadwalPiket(...)
 
                # Insert record penanda level 3
                new_level3 = Otorisasi(
                    GUID_OTO=guid_oto,
                    TRX=oto.TRX,
                    LEVEL_OTO=3,
                    JABATAN='Admin',
                    NIP='999',
                    ACT=-1,
                    PERIHAL=oto.PERIHAL,
                    KETERANGAN='-',
                    BULAN=oto.BULAN,
                    TAHUN=oto.TAHUN,
                )
                db.session.add(new_level3)
 
        db.session.commit()
        return jsonify({'success': True, 'message': 'Data berhasil diproses'})
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})

# ============================================
# TAB "SUDAH PERSETUJUAN" — Kakansar (LEVEL_OTO = 2)
# ============================================
def api_otorisasi_kakansar_sudah():
    """
    List pengajuan level 2 yang sudah diputuskan (ACT >= 0), dengan filter dinamis.
    """
    try:
        field1 = request.args.get('field1', '')
        value1 = request.args.get('value1', '').strip()
        field2 = request.args.get('field2', '')
        value2 = request.args.get('value2', '').strip()

        ALLOWED_FIELDS = {
            'Perihal': Otorisasi.PERIHAL,
            'Keterangan': Otorisasi.KETERANGAN,
            'Jabatan': Otorisasi.JABATAN,
        }

        query = db.session.query(Otorisasi, Pegawai).outerjoin(
            Pegawai, Otorisasi.NIP == Pegawai.NIP
        ).filter(
            Otorisasi.LEVEL_OTO == 2,
            Otorisasi.ACT >= 0,
            Otorisasi.TRX == 'Jadwal Piket Siaga'
        )

        if field1 in ALLOWED_FIELDS and value1:
            query = query.filter(ALLOWED_FIELDS[field1].ilike(f'%{value1}%'))
        if field2 in ALLOWED_FIELDS and value2:
            query = query.filter(ALLOWED_FIELDS[field2].ilike(f'%{value2}%'))

        query = query.order_by(
            Otorisasi.TAHUN.desc(), Otorisasi.BULAN.desc(), Otorisasi.PERIHAL.asc()
        )
        results = query.limit(500).all()

        data = []
        for i, (oto, peg) in enumerate(results, 1):
            # ⚠️ BEDA dari Kasi Ops: di sini "terkunci" artinya level 3
            # SUDAH ACT='3' secara spesifik (bukan sekadar ada record / ACT>-1).
            # Sesuai query VB: "levelOto='3' and act='3'"
            oto_level3 = Otorisasi.query.filter(
                Otorisasi.GUID_OTO == oto.GUID_OTO,
                Otorisasi.LEVEL_OTO == 3,
                Otorisasi.ACT == 3
            ).first()
            is_locked = bool(oto_level3)

            data.append({
                'no': i,
                'guid_oto': oto.GUID_OTO,
                'perihal': oto.PERIHAL or '-',
                'keterangan': oto.KETERANGAN or '-',
                'jabatan': oto.JABATAN or '-',
                'personil': peg.NAMA if peg else '-',
                'act': oto.ACT,
                'act_text': 'Release' if oto.ACT == 3 else ('Reject' if oto.ACT == 0 else '-'),
                'is_locked': is_locked,
            })
        return jsonify({'success': True, 'data': data})
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e), 'data': []})

def api_otorisasi_kakansar_undo():
    """
    Batalkan keputusan level 2 (kembalikan ACT ke -1).
    Hanya boleh kalau level 3 BELUM ACT='3' (lihat catatan is_locked di atas).
    """
    try:
        data = request.get_json()
        guid_oto = data.get('guid_oto', '')
        if not guid_oto:
            return jsonify({'success': False, 'error': 'GUID Otorisasi tidak boleh kosong'})

        oto_level3 = Otorisasi.query.filter(
            Otorisasi.GUID_OTO == guid_oto,
            Otorisasi.LEVEL_OTO == 3,
            Otorisasi.ACT == 3
        ).first()
        if oto_level3:
            return jsonify({'success': False, 'error': 'Tidak bisa dibatalkan, proses level berikutnya sudah selesai'})

        oto = Otorisasi.query.filter(
            Otorisasi.GUID_OTO == guid_oto,
            Otorisasi.LEVEL_OTO == 2
        ).first()
        if not oto:
            return jsonify({'success': False, 'error': 'Data tidak ditemukan'})

        oto.ACT = -1
        db.session.commit()
        return jsonify({'success': True, 'message': 'Keputusan berhasil dibatalkan'})
    except Exception as e:
        db.session.rollback()
        return jsonify({'success': False, 'error': str(e)})

def api_otorisasi_kakansar_filter_fields():
    """Daftar field untuk dropdown filter di tab Sudah Persetujuan (Kakansar)."""
    fields = [
        {'field_id': 'Perihal', 'field_name': 'Perihal'},
        {'field_id': 'Keterangan', 'field_name': 'Keterangan'},
        {'field_id': 'Jabatan', 'field_name': 'Jabatan'},
    ]
    return jsonify({'success': True, 'data': fields})


def otorisasi_persetujuan_kepala_seksi_operasi():
    """Render halaman Otorisasi Persetujuan Kepala Seksi Operasi."""
    return render_template('pages/dashboard_2/Otorisasi_Persetujuan_Kepala_Seksi_Operasi.html')


# ============================================
# TAB "BELUM PERSETUJUAN"
# ============================================
def api_otorisasi_kasiops_belum():
    """
    List pengajuan Jadwal Piket Siaga level 1 (Kasi Ops) yang masih pending (ACT = -1).
    """
    try:
        query = db.session.query(Otorisasi, Pegawai).outerjoin(
            Pegawai, Otorisasi.NIP == Pegawai.NIP
        ).filter(
            Otorisasi.LEVEL_OTO == 1,
            Otorisasi.ACT == -1,
            Otorisasi.TRX == 'Jadwal Piket Siaga'
        ).order_by(Otorisasi.TGL_PENGAJUAN.desc())

        results = query.all()
        data = []
        for i, (oto, peg) in enumerate(results, 1):
            data.append({
                'no': i,
                'guid_oto': oto.GUID_OTO,
                'perihal': oto.PERIHAL or '-',
                'keterangan': oto.KETERANGAN or '-',
                'jabatan': oto.JABATAN or '-',
                'personil': peg.NAMA if peg else '-',
                'bulan': oto.BULAN,
                'tahun': oto.TAHUN,
            })
        return jsonify({'success': True, 'data': data})
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e), 'data': []})


def api_otorisasi_kasiops_approve():
    """
    Approve / Reject satu record Otorisasi level 1 (Kasi Ops).
    act: '0' = reject, '3' = release/approve.
    Kalau approve, buka record level 2 (ACT dikembalikan ke -1) supaya
    masuk antrian approval Kakansar berikutnya — sesuai logic VB.NET aslinya.
    """
    try:
        data = request.get_json()
        guid_oto = data.get('guid_oto', '')
        act = str(data.get('act', ''))
        keterangan = data.get('keterangan', '')
        # TODO: ganti 'admin' dengan NIP dari session user yang sedang login
        updated_by = data.get('updated_by', 'admin')

        if not guid_oto:
            return jsonify({'success': False, 'error': 'GUID Otorisasi tidak boleh kosong'})
        if act not in ('0', '3'):
            return jsonify({'success': False, 'error': 'Nilai aksi tidak valid'})

        oto = Otorisasi.query.filter(
            Otorisasi.GUID_OTO == guid_oto,
            Otorisasi.LEVEL_OTO == 1
        ).first()
        if not oto:
            return jsonify({'success': False, 'error': 'Data tidak ditemukan'})

        oto.ACT = int(act)
        oto.KETERANGAN = keterangan
        oto.UPDATE_BY = updated_by
        oto.UPDATE_DATE = datetime.now()

        if act == '3':
            # Buka level 2 (Kakansar) supaya bisa diproses selanjutnya
            oto_level2 = Otorisasi.query.filter(
                Otorisasi.GUID_OTO == guid_oto,
                Otorisasi.LEVEL_OTO == 2
            ).first()
            if oto_level2:
                oto_level2.ACT = -1

            # TODO: kirim email notifikasi ke Kakansar (butuh Pegawai.MAIL + Flask-Mail/smtplib)
            # Belum diimplementasikan — di VB.NET aslinya pakai ClassPDFJadwalPiket.SendEmailNotifJadwalPiket

        db.session.commit()
        return jsonify({'success': True, 'message': 'Data berhasil diproses'})
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)})


# ============================================
# TAB "SUDAH PERSETUJUAN"
# ============================================
def api_otorisasi_kasiops_sudah():
    """
    List pengajuan level 1 yang sudah diputuskan (ACT >= 0), dengan filter dinamis.
    """
    try:
        field1 = request.args.get('field1', '')
        value1 = request.args.get('value1', '').strip()
        field2 = request.args.get('field2', '')
        value2 = request.args.get('value2', '').strip()

        ALLOWED_FIELDS = {
            'Perihal': Otorisasi.PERIHAL,
            'Keterangan': Otorisasi.KETERANGAN,
            'Jabatan': Otorisasi.JABATAN,
        }

        query = db.session.query(Otorisasi, Pegawai).outerjoin(
            Pegawai, Otorisasi.NIP == Pegawai.NIP
        ).filter(
            Otorisasi.LEVEL_OTO == 1,
            Otorisasi.ACT >= 0,
            Otorisasi.TRX == 'Jadwal Piket Siaga'
        )

        if field1 in ALLOWED_FIELDS and value1:
            query = query.filter(ALLOWED_FIELDS[field1].ilike(f'%{value1}%'))
        if field2 in ALLOWED_FIELDS and value2:
            query = query.filter(ALLOWED_FIELDS[field2].ilike(f'%{value2}%'))

        query = query.order_by(Otorisasi.UPDATE_DATE.desc())
        results = query.limit(500).all()

        data = []
        for i, (oto, peg) in enumerate(results, 1):
            # Cek apakah level 2 (Kakansar) sudah memutuskan juga.
            # Kalau sudah, record ini dikunci (tidak bisa dibatalkan lagi) — sesuai
            # logic "IsUse" di VB.NET yang menyembunyikan tombol Delete.
            oto_level2 = Otorisasi.query.filter(
                Otorisasi.GUID_OTO == oto.GUID_OTO,
                Otorisasi.LEVEL_OTO == 2
            ).first()
            is_locked = bool(oto_level2 and oto_level2.ACT is not None and oto_level2.ACT > -1)

            data.append({
                'no': i,
                'guid_oto': oto.GUID_OTO,
                'perihal': oto.PERIHAL or '-',
                'keterangan': oto.KETERANGAN or '-',
                'jabatan': oto.JABATAN or '-',
                'personil': peg.NAMA if peg else '-',
                'act': oto.ACT,
                'act_text': 'Release' if oto.ACT == 3 else ('Reject' if oto.ACT == 0 else '-'),
                'is_locked': is_locked,
            })
        return jsonify({'success': True, 'data': data})
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e), 'data': []})


def api_otorisasi_kasiops_undo():
    """
    Batalkan keputusan level 1 (kembalikan ACT ke -1, sehingga masuk lagi ke tab Belum).
    Hanya boleh kalau level 2 (Kakansar) BELUM memutuskan.
    """
    try:
        data = request.get_json()
        guid_oto = data.get('guid_oto', '')
        if not guid_oto:
            return jsonify({'success': False, 'error': 'GUID Otorisasi tidak boleh kosong'})

        oto_level2 = Otorisasi.query.filter(
            Otorisasi.GUID_OTO == guid_oto,
            Otorisasi.LEVEL_OTO == 2
        ).first()
        if oto_level2 and oto_level2.ACT is not None and oto_level2.ACT > -1:
            return jsonify({'success': False, 'error': 'Tidak bisa dibatalkan, Kakansar sudah memutuskan'})

        oto = Otorisasi.query.filter(
            Otorisasi.GUID_OTO == guid_oto,
            Otorisasi.LEVEL_OTO == 1
        ).first()
        if not oto:
            return jsonify({'success': False, 'error': 'Data tidak ditemukan'})

        oto.ACT = -1
        db.session.commit()
        return jsonify({'success': True, 'message': 'Keputusan berhasil dibatalkan'})
    except Exception as e:
        db.session.rollback()
        return jsonify({'success': False, 'error': str(e)})


def api_otorisasi_kasiops_filter_fields():
    """Daftar field untuk dropdown filter di tab Sudah Persetujuan."""
    fields = [
        {'field_id': 'Perihal', 'field_name': 'Perihal'},
        {'field_id': 'Keterangan', 'field_name': 'Keterangan'},
        {'field_id': 'Jabatan', 'field_name': 'Jabatan'},
    ]
    return jsonify({'success': True, 'data': fields})