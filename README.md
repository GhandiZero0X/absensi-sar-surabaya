# Sistem Manajemen dan Absensi SAR Surabaya

Web-based Employee Attendance and Management System for SAR Surabaya built with Flask python and MySQL
## Features


## Technology Stack

- **Backend**: Flask (Python)
- **Database**: MySQL with SQLAlchemy ORM
- **Frontend**: HTML5, CSS3, JavaScript with Jinja2 templating

## Project Structure

```
absensi-sar-surabaya/
├── app/
│   ├── __init__.py           # Application factory
│   ├── models/
│   │   ├── __init__.py
│   │   ├── user.py           # User model
│   │   └── attendance.py     # Attendance model
│   ├── routes/
│   │   ├── __init__.py
│   │   ├── auth.py           # Authentication routes
│   │   ├── admin.py          # Admin routes
│   │   └── employee.py       # Employee routes
│   ├── templates/
│   │   ├── base.html         # Base template
│   │   ├── login.html        # Login page
│   │   ├── admin/            # Admin templates
│   │   │   ├── dashboard.html
│   │   │   ├── employees.html
│   │   │   ├── add_employee.html
│   │   │   ├── edit_employee.html
│   │   │   └── attendance.html
│   │   └── employee/         # Employee templates
│   │       ├── dashboard.html
│   │       └── history.html
│   └── static/
│       ├── css/
│       │   └── style.css     # Main stylesheet
│       └── js/
│           └── main.js       # JavaScript functionality
├── config.py                 # Configuration
├── app.py                    # Application entry point
├── requirements.txt          # Python dependencies
├── .gitignore               # Git ignore rules
└── README.md                # This file
```

## Installation & Setup


## Database Models

### User Model
- `id`: Primary key
- `username`: Unique username
- `email`: Unique email address
- `password_hash`: Hashed password
- `full_name`: Employee's full name
- `role`: 'admin' or 'employee'
- `position`: Job position
- `department`: Department name
- `phone`: Contact number
- `is_active`: Account status
- `created_at`: Registration timestamp

### Attendance Model
- `id`: Primary key
- `user_id`: Foreign key to User
- `date`: Attendance date
- `check_in_time`: Check-in timestamp
- `check_out_time`: Check-out timestamp
- `notes`: Additional notes
- `status`: 'present', 'absent', 'late', 'leave'
- `created_at`: Record creation timestamp
- `updated_at`: Last update timestamp

## API Endpoints

### Authentication
- `GET /` - Redirect to login
- `GET /login` - Login page
- `POST /login` - Login handler
- `GET /logout` - Logout handler

### Admin Routes (require admin role)
- `GET /admin/dashboard` - Admin dashboard
- `GET /admin/employees` - List all employees
- `GET /admin/employees/add` - Add employee form
- `POST /admin/employees/add` - Create employee
- `GET /admin/employees/<id>/edit` - Edit employee form
- `POST /admin/employees/<id>/edit` - Update employee
- `POST /admin/employees/<id>/delete` - Delete employee
- `GET /admin/attendance` - View attendance records

### Employee Routes (require authentication)
- `GET /employee/dashboard` - Employee dashboard
- `POST /employee/check-in` - Record check-in
- `POST /employee/check-out` - Record check-out
- `GET /employee/history` - View attendance history

## Security Features

- Password hashing using Werkzeug
- Session-based authentication with Flask-Login
- CSRF protection (Flask default)
- SQL injection prevention (SQLAlchemy ORM)
- Secure password storage (never stored in plain text)