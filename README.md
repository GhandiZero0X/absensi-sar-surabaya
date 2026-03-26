# Sistem Informasi Manajemen Kepegawaian dan Operasional SAR Surabaya
Website untuk pengelelolaan pegawai yang akan digunakan oleh SAR Surabaya yang akan memiliki fitur Utama yaitu Homepage Informasi, Pengelolaan Pegawai (pencatatan absensi kehadiran, kegiatan dinas, izin (sakit dan cuti)), Rekapitulasi Laporan (Rekap absensi, izin, pelanggaran, tunjangan, lembur, dsb), Media Informasi Pengumuman, Pengeloaan Jadwal Petugas Siaga, dan Arsip Data Diri Personal.

## Background

Sistem ini dikembangkan untuk membantu digitalisasi proses administrasi dan operasional di lingkungan SAR Surabaya, yang sebelumnya masih dilakukan secara manual atau semi-digital.

## Features

- 📊 Dashboard informasi
- 👥 Manajemen data pegawai
- ⏱️ Sistem absensi (check-in / check-out)
- 📅 Pengelolaan jadwal petugas siaga
- 📝 Manajemen izin (sakit, cuti)
- 📈 Rekapitulasi laporan (absensi, lembur, tunjangan, pelanggaran)
- 📢 Sistem pengumuman internal
- 📂 Arsip data personal pegawai

## Technology Stack

- **Backend**: Python
- **Database**: MySQL
- **Frontend**: HTML5, CSS3, JavaScript, Jinja2 templating
- **Framework**: Flask

## Architecture

Flask-based MVC pattern:
- Models: Database layer
- Routes: Controller logic
- Templates: View layer

## User Roles

### Admin
- Mengelola data pegawai
- Melihat laporan
- Mengatur jadwal

### Employee
- Melakukan absensi
- Melihat riwayat
- Mengajukan izin

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
### Clone repository
git clone https://github.com/username/absensi-sar-surabaya.git

### Masuk folder
cd absensi-sar-surabaya

### Install dependency
pip install -r requirements.txt

### Database Setup
- Create database: `sar_surabaya`
- Schema database ada di dalam folder development
- Configure connection di `config.py`

### Run app
python app.py

## Database Models

<!-- ### User Model
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
- `updated_at`: Last update timestamp -->

## API Endpoints

### Authentication
<!-- - `GET /` - Redirect to login
- `GET /login` - Login page
- `POST /login` - Login handler
- `GET /logout` - Logout handler -->

### Admin Routes (require admin role)
<!-- - `GET /admin/dashboard` - Admin dashboard
- `GET /admin/employees` - List all employees
- `GET /admin/employees/add` - Add employee form
- `POST /admin/employees/add` - Create employee
- `GET /admin/employees/<id>/edit` - Edit employee form
- `POST /admin/employees/<id>/edit` - Update employee
- `POST /admin/employees/<id>/delete` - Delete employee
- `GET /admin/attendance` - View attendance records -->

### Employee Routes
<!-- - `GET /employee/dashboard` - Employee dashboard
- `POST /employee/check-in` - Record check-in
- `POST /employee/check-out` - Record check-out
- `GET /employee/history` - View attendance history -->

## Security Features
- Password hashing using Werkzeug
- Session-based authentication with Flask-Login
- CSRF protection (Flask default)
- SQL injection prevention (SQLAlchemy ORM)
- Secure password storage (never stored in plain text)