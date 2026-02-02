from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import login_user, logout_user, login_required
from app import db
from app.models.user import User

bp = Blueprint('auth', __name__)

@bp.route('/')
def index():
    """Redirect to login page"""
    return redirect(url_for('auth.login'))

@bp.route('/login', methods=['GET', 'POST'])
def login():
    """Login page and handler"""
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        user = User.query.filter_by(username=username).first()
        
        if user and user.check_password(password):
            if not user.is_active:
                flash('Akun Anda tidak aktif. Hubungi administrator.', 'error')
                return redirect(url_for('auth.login'))
            
            login_user(user)
            flash(f'Selamat datang, {user.full_name}!', 'success')
            
            # Redirect based on role
            if user.is_admin():
                return redirect(url_for('admin.dashboard'))
            else:
                return redirect(url_for('employee.dashboard'))
        else:
            flash('Username atau password salah.', 'error')
    
    return render_template('login.html')

@bp.route('/logout')
@login_required
def logout():
    """Logout handler"""
    logout_user()
    flash('Anda telah logout.', 'info')
    return redirect(url_for('auth.login'))
