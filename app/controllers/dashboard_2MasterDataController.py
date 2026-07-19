# controllers/dashboard_2MasterDataController.py
from flask import render_template, request

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
    return render_template('pages/dashboard_2/Master_Data_Tim_Siaga.html')

def master_data_user_account():
    """Render halaman Master Data User Account."""
    return render_template('pages/dashboard_2/Master_Data_User_Account.html')