# app/routes/routes.py

from flask import Blueprint
from app.controllers.homeController import home

main = Blueprint('main', __name__)

@main.route('/')
def index():
    return home()