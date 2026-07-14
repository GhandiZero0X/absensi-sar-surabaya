# app/models/potModel.py
from app import db


class MfPot(db.Model):
    """
    Model untuk tabel MF_POT.
    Menyimpan aturan potongan (deduction rules) untuk keterlambatan,
    pulang cepat, dan ketidakhadiran.

    Primary Key : POTONGAN_ID
    """
    __tablename__ = 'MF_POT'

    # Primary Key
    POTONGAN_ID = db.Column(db.Integer, primary_key=True, nullable=False)

    # Kategori potongan (misal: TLM = terlambat, PSW = pulang cepat, ALPA = tanpa kabar)
    KATEGORI = db.Column(db.String(50))
    # Tingkatan potongan (misal: ringan, sedang, berat)
    TINGKAT = db.Column(db.String(50))
    # Persentase pemotongan Tunjangan Kinerja (Tukin)
    PERSEN_POT = db.Column(db.Float)
    # Tanggal mulai berlaku aturan ini
    TGL_MULAI = db.Column(db.DateTime)
    # Batas bawah rentang keterlambatan (dalam menit)
    RANGE_AWAL = db.Column(db.Float)
    # Batas atas rentang keterlambatan (dalam menit)
    RANGE_AKHIR = db.Column(db.Float)
    # Nama singkat potongan untuk tampilan
    NAMA_POT = db.Column(db.String(50))
    # Metadata audit
    UPDATE_BY = db.Column(db.String(50))
    UPDATE_DATE = db.Column(db.DateTime)

    # Flag apakah potongan ini memerlukan dokumen pendukung (Y/N)
    IS_PENDUKUNG = db.Column(db.String(2))
    # Keterangan tindakan (misal: "Potong 1% tukin" atau "Teguran lisan")
    TINDAKAN = db.Column(db.String(250))
    # Durasi potongan dalam satuan tertentu (misal: jumlah hari tidak masuk)
    DURASI_POT = db.Column(db.Float)
    # Satuan durasi (misal: hari, menit)
    SATUAN_DURASI = db.Column(db.String(10))

    def __repr__(self):
        return f'<MfPot {self.POTONGAN_ID} - {self.NAMA_POT}>'

    def to_dict(self):
        return {
            'potongan_id': self.POTONGAN_ID,
            'kategori': self.KATEGORI,
            'tingkat': self.TINGKAT,
            'persen_pot': self.PERSEN_POT,
            'tgl_mulai': self.TGL_MULAI.isoformat() if self.TGL_MULAI else None,
            'range_awal': self.RANGE_AWAL,
            'range_akhir': self.RANGE_AKHIR,
            'nama_pot': self.NAMA_POT,
            'update_by': self.UPDATE_BY,
            'update_date': self.UPDATE_DATE.isoformat() if self.UPDATE_DATE else None,
            'is_pendukung': self.IS_PENDUKUNG,
            'tindakan': self.TINDAKAN,
            'durasi_pot': self.DURASI_POT,
            'satuan_durasi': self.SATUAN_DURASI
        }