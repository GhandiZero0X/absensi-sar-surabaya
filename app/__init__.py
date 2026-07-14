# app/__init__.py
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from config import Config

db = SQLAlchemy()  # instance db dibuat di luar, biar bisa di-import model manapun

def create_app():
    app = Flask(
        __name__,
        template_folder='templates',
        static_folder='static'
    )
    app.config.from_object(Config)

    db.init_app(app)  # bind db ke app instance

    from app.routes.routes import main
    app.register_blueprint(main)

    return app