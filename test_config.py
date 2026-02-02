"""Test configuration for local testing without MySQL"""
from datetime import timedelta

class TestConfig:
    """Test configuration using SQLite"""
    SECRET_KEY = 'test-secret-key'
    SQLALCHEMY_DATABASE_URI = 'sqlite:///test_absensi.db'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    PERMANENT_SESSION_LIFETIME = timedelta(hours=2)
    TESTING = True
