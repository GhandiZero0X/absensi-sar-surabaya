# Sistem Absensi SAR Surabaya

Web-based Employee Attendance and Management System for SAR Surabaya built with Flask, MySQL, and SQLAlchemy.

## Features

- **Session-based Authentication**: Secure login system with admin and employee roles
- **Employee Management (Admin)**: 
  - Create, Read, Update, Delete employee records
  - Manage employee status (active/inactive)
  - View employee details and positions
- **Attendance System**:
  - Check-in/Check-out functionality
  - Daily attendance records
  - Automatic work duration calculation
- **Admin Dashboard**: 
  - View statistics (total employees, daily attendance)
  - Monitor recent attendance records
  - Filter attendance by date
- **Employee Dashboard**:
  - Personal attendance tracking
  - View attendance history
  - Quick check-in/check-out access
- **Responsive Design**: Clean and modern UI with mobile-friendly layout

## Technology Stack

- **Backend**: Flask (Python)
- **Database**: MySQL with SQLAlchemy ORM
- **Frontend**: HTML5, CSS3, JavaScript with Jinja2 templating
- **Authentication**: Flask-Login
- **Containerization**: Docker & Docker Compose

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
├── run.py                    # Application entry point
├── requirements.txt          # Python dependencies
├── Dockerfile                # Docker configuration
├── docker-compose.yml        # Docker Compose setup
├── .gitignore               # Git ignore rules
└── README.md                # This file
```

## Installation & Setup

### Prerequisites

- Python 3.8+
- MySQL 8.0+ (or use Docker)
- Docker & Docker Compose (optional, recommended)

### Option 1: Using Docker (Recommended)

1. Clone the repository:
```bash
git clone https://github.com/GhandiZero0X/absensi-sar-surabaya.git
cd absensi-sar-surabaya
```

2. Build and run with Docker Compose:
```bash
docker-compose up --build
```

3. Access the application at `http://localhost:5000`

4. Default admin credentials:
   - Username: `admin`
   - Password: `admin123`

### Option 2: Manual Setup

1. Clone the repository:
```bash
git clone https://github.com/GhandiZero0X/absensi-sar-surabaya.git
cd absensi-sar-surabaya
```

2. Create virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Set up MySQL database:
```sql
CREATE DATABASE absensi_db;
CREATE USER 'absensi_user'@'localhost' IDENTIFIED BY 'absensi_pass';
GRANT ALL PRIVILEGES ON absensi_db.* TO 'absensi_user'@'localhost';
FLUSH PRIVILEGES;
```

5. Configure environment variables (optional):
```bash
export DATABASE_URL="mysql+pymysql://absensi_user:absensi_pass@localhost/absensi_db"
export SECRET_KEY="your-secret-key-here"
```

6. Run the application:
```bash
python run.py
```

7. Access the application at `http://localhost:5000`

8. Default admin credentials:
   - Username: `admin`
   - Password: `admin123`

## Usage

### Admin Functions

1. **Login** as admin (admin/admin123)
2. **Manage Employees**:
   - Navigate to "Karyawan" menu
   - Add new employees with username, email, password, and position details
   - Edit employee information
   - Deactivate or delete employee accounts
3. **View Attendance**:
   - Navigate to "Absensi" menu
   - Filter attendance records by date
   - Monitor check-in/check-out times and work duration
4. **Dashboard**:
   - View total employees count
   - See today's attendance count
   - Monitor recent attendance activity

### Employee Functions

1. **Login** with employee credentials
2. **Check-in**:
   - Click "Check In" button on dashboard
   - System records current timestamp
3. **Check-out**:
   - Click "Check Out" button after check-in
   - System calculates work duration
4. **View History**:
   - Navigate to "Riwayat" menu
   - View personal attendance records
   - See work duration for each day

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
- Role-based access control (admin/employee)
- CSRF protection (Flask default)
- SQL injection prevention (SQLAlchemy ORM)
- Secure password storage (never stored in plain text)

## Development

### Running in Development Mode

```bash
export FLASK_ENV=development
python run.py
```

### Database Migrations

The application automatically creates database tables on first run. To reset the database:

```bash
# Using Docker
docker-compose down -v
docker-compose up --build

# Manual setup
# Drop and recreate the database, then restart the application
```

## Configuration

Edit `config.py` to customize:
- `SECRET_KEY`: Application secret key (change in production!)
- `SQLALCHEMY_DATABASE_URI`: Database connection string
- `PERMANENT_SESSION_LIFETIME`: Session timeout duration

## Docker Commands

```bash
# Start services
docker-compose up

# Start in detached mode
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Rebuild containers
docker-compose up --build

# Remove volumes (reset database)
docker-compose down -v
```

## Troubleshooting

### Database Connection Issues
- Ensure MySQL is running
- Check database credentials in `config.py` or environment variables
- Verify database exists and user has proper permissions

### Port Already in Use
- Change port in `docker-compose.yml` or `run.py`
- Kill existing process using the port

### Permission Issues (Docker)
- Run with sudo: `sudo docker-compose up`
- Add user to docker group: `sudo usermod -aG docker $USER`

## Future Enhancements

- Export attendance reports to Excel/PDF
- Email notifications for attendance alerts
- Biometric integration
- Mobile app
- REST API for integrations
- Advanced reporting and analytics
- Leave management system
- Overtime tracking
- Multi-language support

## License

This project is developed as a starter code for SAR Surabaya attendance management system.

## Support

For issues and questions, please create an issue in the repository.

---

**Note**: This is starter code. Remember to:
- Change default admin password after first login
- Update SECRET_KEY in production
- Configure proper database backups
- Set up HTTPS in production
- Review and adjust security settings for production use