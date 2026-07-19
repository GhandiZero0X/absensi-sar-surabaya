# app/utils/decorators.py
from functools import wraps
from flask import session, redirect, url_for

def login_required(view_func):
    """
    Decorator untuk melindungi route admin/dashboard.
    Jika session belum login, redirect ke home page.
    """
    @wraps(view_func)
    def wrapped_view(*args, **kwargs):
        if not session.get('logged_in'):
            return redirect(url_for('main.index'))
        return view_func(*args, **kwargs)
    return wrapped_view