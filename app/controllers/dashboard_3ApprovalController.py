# controllers/dashboard_3ApprovalController.py
from flask import render_template, request


def approval_approved():
    """
    Render halaman Approval - Has Been Approved.
    Asumsi: file Approval_Approved.html = daftar yang SUDAH disetujui.
    Mohon konfirmasi jika pemetaan ini terbalik dengan approved_request().
    """
    return render_template('pages/dashboard_3/Approval_Approved.html')


def approved_request():
    """
    Render halaman Approval - Need Approval.
    Asumsi: file Approved_Request.html = daftar yang MASIH PERLU disetujui.
    Mohon konfirmasi jika pemetaan ini terbalik dengan approval_approved().
    """
    return render_template('pages/dashboard_3/Approved_Request.html')