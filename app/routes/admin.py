from flask import Blueprint, render_template, request, redirect, url_for, flash, jsonify
from flask_login import login_required, current_user
from functools import wraps
from datetime import datetime, date
from app import db
from app.models.user import User
from app.models.attendance import Attendance

bp = Blueprint('admin', __name__, url_prefix='/admin')

def admin_required(f):
    """Decorator to require admin role"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not current_user.is_authenticated or not current_user.is_admin():
            flash('Akses ditolak. Anda harus admin.', 'error')
            return redirect(url_for('auth.login'))
        return f(*args, **kwargs)
    return decorated_function

@bp.route('/dashboard')
@login_required
@admin_required
def dashboard():
    """Admin dashboard with statistics"""
    total_employees = User.query.filter_by(role='employee').count()
    today = date.today()
    today_attendance = Attendance.query.filter_by(date=today).count()
    
    # Get recent attendance records
    recent_attendances = Attendance.query.order_by(Attendance.created_at.desc()).limit(10).all()
    
    return render_template('admin/dashboard.html',
                         total_employees=total_employees,
                         today_attendance=today_attendance,
                         recent_attendances=recent_attendances)

@bp.route('/employees')
@login_required
@admin_required
def employees():
    """List all employees"""
    employees = User.query.filter_by(role='employee').all()
    return render_template('admin/employees.html', employees=employees)

@bp.route('/employees/add', methods=['GET', 'POST'])
@login_required
@admin_required
def add_employee():
    """Add new employee"""
    if request.method == 'POST':
        username = request.form.get('username')
        email = request.form.get('email')
        full_name = request.form.get('full_name')
        password = request.form.get('password')
        position = request.form.get('position')
        department = request.form.get('department')
        phone = request.form.get('phone')
        
        # Check if username or email already exists
        if User.query.filter_by(username=username).first():
            flash('Username sudah digunakan.', 'error')
            return redirect(url_for('admin.add_employee'))
        
        if User.query.filter_by(email=email).first():
            flash('Email sudah digunakan.', 'error')
            return redirect(url_for('admin.add_employee'))
        
        # Create new employee
        employee = User(
            username=username,
            email=email,
            full_name=full_name,
            role='employee',
            position=position,
            department=department,
            phone=phone
        )
        employee.set_password(password)
        
        db.session.add(employee)
        db.session.commit()
        
        flash(f'Karyawan {full_name} berhasil ditambahkan.', 'success')
        return redirect(url_for('admin.employees'))
    
    return render_template('admin/add_employee.html')

@bp.route('/employees/<int:id>/edit', methods=['GET', 'POST'])
@login_required
@admin_required
def edit_employee(id):
    """Edit employee details"""
    employee = User.query.get_or_404(id)
    
    if employee.role == 'admin':
        flash('Tidak dapat mengedit akun admin.', 'error')
        return redirect(url_for('admin.employees'))
    
    if request.method == 'POST':
        employee.email = request.form.get('email')
        employee.full_name = request.form.get('full_name')
        employee.position = request.form.get('position')
        employee.department = request.form.get('department')
        employee.phone = request.form.get('phone')
        employee.is_active = request.form.get('is_active') == 'on'
        
        # Update password if provided
        password = request.form.get('password')
        if password:
            employee.set_password(password)
        
        db.session.commit()
        flash(f'Data karyawan {employee.full_name} berhasil diperbarui.', 'success')
        return redirect(url_for('admin.employees'))
    
    return render_template('admin/edit_employee.html', employee=employee)

@bp.route('/employees/<int:id>/delete', methods=['POST'])
@login_required
@admin_required
def delete_employee(id):
    """Delete employee"""
    employee = User.query.get_or_404(id)
    
    if employee.role == 'admin':
        flash('Tidak dapat menghapus akun admin.', 'error')
        return redirect(url_for('admin.employees'))
    
    db.session.delete(employee)
    db.session.commit()
    
    flash(f'Karyawan {employee.full_name} berhasil dihapus.', 'success')
    return redirect(url_for('admin.employees'))

@bp.route('/attendance')
@login_required
@admin_required
def attendance():
    """View all attendance records"""
    page = request.args.get('page', 1, type=int)
    per_page = 20
    
    # Filter by date if provided
    filter_date = request.args.get('date')
    query = Attendance.query
    
    if filter_date:
        try:
            filter_date = datetime.strptime(filter_date, '%Y-%m-%d').date()
            query = query.filter_by(date=filter_date)
        except ValueError:
            pass
    
    attendances = query.order_by(Attendance.date.desc(), Attendance.check_in_time.desc()).paginate(
        page=page, per_page=per_page, error_out=False
    )
    
    return render_template('admin/attendance.html', attendances=attendances)
