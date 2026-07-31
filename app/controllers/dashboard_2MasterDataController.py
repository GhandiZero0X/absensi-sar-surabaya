# controllers/dashboard_2MasterDataController.py
from flask import render_template, request, jsonify
from datetime import datetime
import uuid
from app import db
from app.models.pegawaiModel import Pegawai
from app.models.unitKerjaModel import MfUnitKerja
from app.models.timSiagaModel import MfTimSiaga
from app.models.timSiagaAnggotaModel import MfTimSiagaAnggota

def master_data_email_broadcast():
    """Render halaman Master Data Email Broadcast."""
    return render_template('pages/dashboard_2/Master_Data_Email_Broadcast.html')

def master_data_kgr():
    """Render halaman Master Data KGR."""
    return render_template('pages/dashboard_2/Master_Data_KGR.html')

def master_data_nominal_ut_piket():
    """Render halaman Master Data Nominal UT Piket."""
    return render_template('pages/dashboard_2/Master_Data_Nominal_UT_Piket.html')

def master_data_tim_siaga():
    """Render halaman Master Data Tim Siaga."""
    unit_kerja_list = MfUnitKerja.query.order_by(MfUnitKerja.NAMA_UNIT_KERJA.asc()).all()
    return render_template(
        'pages/dashboard_2/Master_Data_Tim_Siaga.html',
        unit_kerja_list=unit_kerja_list
    )

def api_tim_siaga_save():
    """API: Simpan/Update Tim Siaga"""
    try:
        data = request.get_json()
        guid_tim = data.get('guid_tim', '')
        nama_tim = data.get('nama_tim', '')
        no_urut = data.get('no_urut', '0')
        unit_kerja_id = data.get('unit_kerja_id', '')
        fungsional = data.get('fungsional', '')
        shift = data.get('shift', '1')
        periode = data.get('periode', '')
        anggota_list = data.get('anggota', [])
        is_new = data.get('is_new', True)
        
        if not nama_tim or not unit_kerja_id or not fungsional or not periode:
            return jsonify({'error': 'Data tidak lengkap'})
        
        if not anggota_list:
            return jsonify({'error': 'Anggota Tim kosong'})
        
        tahun = periode[:4]
        bulan = periode[5:7]
        
        if is_new:
            guid_tim = str(uuid.uuid4())
            
            tim = MfTimSiaga(
                GUID_TIM=guid_tim,
                NO_URUT_TIM=int(no_urut) if no_urut else 0,
                NAMA_TIM=nama_tim,
                ID_UNIT_KERJA=str(unit_kerja_id),
                IS_AKTIF='Y',
                BULAN_PERIODE=bulan,
                TAHUN_PERIODE=tahun,
                FUNGSIONAL_TIM=fungsional,
                SHIFT=shift,
                UPDATE_BY='admin',
                UPDATE_DATE=datetime.now()
            )
            db.session.add(tim)
            
            for i, anggota in enumerate(anggota_list, 1):
                ag = MfTimSiagaAnggota(
                    GUID_TIM=guid_tim,
                    NIP=anggota.get('nip', ''),
                    FUNGSIONAL=fungsional,
                    IS_AKTIF='Y',
                    ID_UNIT_KERJA=str(unit_kerja_id),
                    NO_URUT=i,
                    BULAN_PERIODE=bulan,
                    TAHUN_PERIODE=tahun,
                    SHIFT=shift,
                    UPDATE_BY='admin',
                    UPDATE_DATE=datetime.now()
                )
                db.session.add(ag)
        else:
            tim = MfTimSiaga.query.get(guid_tim)
            if not tim:
                return jsonify({'error': 'Data tidak ditemukan'})
            
            tim.NAMA_TIM = nama_tim
            tim.NO_URUT_TIM = int(no_urut) if no_urut else 0
            tim.ID_UNIT_KERJA = str(unit_kerja_id)
            tim.FUNGSIONAL_TIM = fungsional
            tim.SHIFT = shift
            tim.BULAN_PERIODE = bulan
            tim.TAHUN_PERIODE = tahun
            tim.UPDATE_BY = 'admin'
            tim.UPDATE_DATE = datetime.now()
            
            MfTimSiagaAnggota.query.filter(MfTimSiagaAnggota.GUID_TIM == guid_tim).delete()
            
            for i, anggota in enumerate(anggota_list, 1):
                ag = MfTimSiagaAnggota(
                    GUID_TIM=guid_tim,
                    NIP=anggota.get('nip', ''),
                    FUNGSIONAL=fungsional,
                    IS_AKTIF='Y',
                    ID_UNIT_KERJA=str(unit_kerja_id),
                    NO_URUT=i,
                    BULAN_PERIODE=bulan,
                    TAHUN_PERIODE=tahun,
                    SHIFT=shift,
                    UPDATE_BY='admin',
                    UPDATE_DATE=datetime.now()
                )
                db.session.add(ag)
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Data berhasil disimpan',
            'guid_tim': guid_tim
        })
        
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})


def api_tim_siaga_delete():
    """API: Delete Tim Siaga"""
    try:
        data = request.get_json()
        guid_tim = data.get('guid_tim', '')
        
        if not guid_tim:
            return jsonify({'error': 'GUID Tim tidak ditemukan'})
        
        MfTimSiagaAnggota.query.filter(MfTimSiagaAnggota.GUID_TIM == guid_tim).delete()
        MfTimSiaga.query.filter(MfTimSiaga.GUID_TIM == guid_tim).delete()
        
        db.session.commit()
        
        return jsonify({'success': True, 'message': 'Data berhasil dihapus'})
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)})


def api_tim_siaga_get():
    """API: Get data Tim Siaga by GUID"""
    guid_tim = request.args.get('guid_tim', '')
    
    if not guid_tim:
        return jsonify({'error': 'GUID Tim tidak ditemukan'})
    
    tim = MfTimSiaga.query.get(guid_tim)
    if not tim:
        return jsonify({'error': 'Data tidak ditemukan'})
    
    anggota = (
        MfTimSiagaAnggota.query
        .filter(MfTimSiagaAnggota.GUID_TIM == guid_tim)
        .order_by(MfTimSiagaAnggota.NO_URUT)
        .all()
    )
    
    anggota_data = []
    for ag in anggota:
        peg = Pegawai.query.filter(Pegawai.NIP == ag.NIP).first()
        anggota_data.append({
            'nip': ag.NIP,
            'nama': peg.NAMA if peg else '-',
            'fungsional': ag.FUNGSIONAL,
        })
    
    return jsonify({
        'success': True,
        'data': {
            'guid_tim': tim.GUID_TIM,
            'nama_tim': tim.NAMA_TIM,
            'no_urut': tim.NO_URUT_TIM,
            'unit_kerja_id': tim.ID_UNIT_KERJA,
            'fungsional': tim.FUNGSIONAL_TIM,
            'shift': tim.SHIFT,
            'periode': f"{tim.TAHUN_PERIODE}-{tim.BULAN_PERIODE}",
            'anggota': anggota_data,
        }
    })


def api_tim_siaga_save_as():
    """API: Save As (copy tim ke periode lain)"""
    try:
        data = request.get_json()
        periode_sumber = data.get('periode_sumber', '')
        periode_tujuan = data.get('periode_tujuan', '')
        unit_kerja_id = data.get('unit_kerja_id', '')
        shift = data.get('shift', '1')
        
        if not periode_sumber or not periode_tujuan:
            return jsonify({'error': 'Periode sumber dan tujuan harus diisi'})
        
        tahun_sumber = periode_sumber[:4]
        bulan_sumber = periode_sumber[5:7]
        tahun_tujuan = periode_tujuan[:4]
        bulan_tujuan = periode_tujuan[5:7]
        
        # Get tim sumber
        tim_list = MfTimSiaga.query.filter(
            MfTimSiaga.BULAN_PERIODE == bulan_sumber,
            MfTimSiaga.TAHUN_PERIODE == tahun_sumber,
            MfTimSiaga.SHIFT == shift,
            MfTimSiaga.ID_UNIT_KERJA == str(unit_kerja_id)
        ).all()
        
        if not tim_list:
            return jsonify({'error': 'Data sumber tidak ditemukan'})
        
        # Delete existing di periode tujuan
        MfTimSiagaAnggota.query.filter(
            MfTimSiagaAnggota.BULAN_PERIODE == bulan_tujuan,
            MfTimSiagaAnggota.TAHUN_PERIODE == tahun_tujuan,
            MfTimSiagaAnggota.ID_UNIT_KERJA == str(unit_kerja_id),
            MfTimSiagaAnggota.SHIFT == shift
        ).delete()
        
        MfTimSiaga.query.filter(
            MfTimSiaga.BULAN_PERIODE == bulan_tujuan,
            MfTimSiaga.TAHUN_PERIODE == tahun_tujuan,
            MfTimSiaga.ID_UNIT_KERJA == str(unit_kerja_id),
            MfTimSiaga.SHIFT == shift
        ).delete()
        
        saved = 0
        for tim in tim_list:
            new_guid = str(uuid.uuid4())
            
            new_tim = MfTimSiaga(
                GUID_TIM=new_guid,
                NO_URUT_TIM=tim.NO_URUT_TIM,
                NAMA_TIM=tim.NAMA_TIM,
                ID_UNIT_KERJA=tim.ID_UNIT_KERJA,
                IS_AKTIF='Y',
                BULAN_PERIODE=bulan_tujuan,
                TAHUN_PERIODE=tahun_tujuan,
                FUNGSIONAL_TIM=tim.FUNGSIONAL_TIM,
                SHIFT=tim.SHIFT,
                UPDATE_BY='admin',
                UPDATE_DATE=datetime.now()
            )
            db.session.add(new_tim)
            
            # Copy anggota
            anggota_lama = MfTimSiagaAnggota.query.filter(
                MfTimSiagaAnggota.GUID_TIM == tim.GUID_TIM
            ).all()
            
            for ag in anggota_lama:
                new_ag = MfTimSiagaAnggota(
                    GUID_TIM=new_guid,
                    NIP=ag.NIP,
                    FUNGSIONAL=ag.FUNGSIONAL,
                    IS_AKTIF='Y',
                    ID_UNIT_KERJA=ag.ID_UNIT_KERJA,
                    NO_URUT=ag.NO_URUT,
                    BULAN_PERIODE=bulan_tujuan,
                    TAHUN_PERIODE=tahun_tujuan,
                    SHIFT=ag.SHIFT,
                    UPDATE_BY='admin',
                    UPDATE_DATE=datetime.now()
                )
                db.session.add(new_ag)
            
            saved += 1
        
        db.session.commit()
        
        return jsonify({'success': True, 'message': f'{saved} tim berhasil disalin'})
        
    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)})

def master_data_user_account():
    """Render halaman Master Data User Account."""
    return render_template('pages/dashboard_2/Master_Data_User_Account.html')