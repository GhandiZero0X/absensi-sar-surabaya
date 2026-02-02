from datetime import datetime
from app import db

class Attendance(db.Model):
    """Attendance model for check-in/check-out records"""
    __tablename__ = 'attendances'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    date = db.Column(db.Date, nullable=False, default=datetime.utcnow().date)
    check_in_time = db.Column(db.DateTime)
    check_out_time = db.Column(db.DateTime)
    notes = db.Column(db.Text)
    status = db.Column(db.String(20), default='present')  # present, absent, late, leave
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    def __repr__(self):
        return f'<Attendance {self.user_id} - {self.date}>'
    
    def get_work_duration(self):
        """Calculate work duration in hours"""
        if self.check_in_time and self.check_out_time:
            duration = self.check_out_time - self.check_in_time
            return round(duration.total_seconds() / 3600, 2)
        return 0
