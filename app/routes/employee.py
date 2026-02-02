from flask import Blueprint, render_template, request, redirect, url_for, flash, jsonify
from flask_login import login_required, current_user
from datetime import datetime, date
from app import db
from app.models.attendance import Attendance

bp = Blueprint('employee', __name__, url_prefix='/employee')

@bp.route('/dashboard')
@login_required
def dashboard():
    """Employee dashboard"""
    today = date.today()
    
    # Get today's attendance
    today_attendance = Attendance.query.filter_by(
        user_id=current_user.id,
        date=today
    ).first()
    
    # Get recent attendance records
    recent_attendances = Attendance.query.filter_by(
        user_id=current_user.id
    ).order_by(Attendance.date.desc()).limit(10).all()
    
    return render_template('employee/dashboard.html',
                         today_attendance=today_attendance,
                         recent_attendances=recent_attendances)

@bp.route('/check-in', methods=['POST'])
@login_required
def check_in():
    """Check-in for today"""
    today = date.today()
    
    # Check if already checked in today
    existing = Attendance.query.filter_by(
        user_id=current_user.id,
        date=today
    ).first()
    
    if existing and existing.check_in_time:
        flash('Anda sudah check-in hari ini.', 'warning')
        return redirect(url_for('employee.dashboard'))
    
    # Create or update attendance record
    if existing:
        existing.check_in_time = datetime.utcnow()
        existing.status = 'present'
    else:
        attendance = Attendance(
            user_id=current_user.id,
            date=today,
            check_in_time=datetime.utcnow(),
            status='present'
        )
        db.session.add(attendance)
    
    db.session.commit()
    flash('Check-in berhasil!', 'success')
    return redirect(url_for('employee.dashboard'))

@bp.route('/check-out', methods=['POST'])
@login_required
def check_out():
    """Check-out for today"""
    today = date.today()
    
    attendance = Attendance.query.filter_by(
        user_id=current_user.id,
        date=today
    ).first()
    
    if not attendance or not attendance.check_in_time:
        flash('Anda belum check-in hari ini.', 'error')
        return redirect(url_for('employee.dashboard'))
    
    if attendance.check_out_time:
        flash('Anda sudah check-out hari ini.', 'warning')
        return redirect(url_for('employee.dashboard'))
    
    attendance.check_out_time = datetime.utcnow()
    db.session.commit()
    
    flash('Check-out berhasil!', 'success')
    return redirect(url_for('employee.dashboard'))

@bp.route('/history')
@login_required
def history():
    """View attendance history"""
    page = request.args.get('page', 1, type=int)
    per_page = 20
    
    attendances = Attendance.query.filter_by(
        user_id=current_user.id
    ).order_by(Attendance.date.desc()).paginate(
        page=page, per_page=per_page, error_out=False
    )
    
    return render_template('employee/history.html', attendances=attendances)
