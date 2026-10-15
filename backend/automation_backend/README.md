# Automation Hub - Backend API

## 🎯 Overview

Backend API untuk Automation Hub, menggunakan FastAPI dengan task automation lengkap.

## 📋 Struktur

```
backend/automation_backend/
├── main.py                    # Server FastAPI
├── .env                      # Environment variables
├── requirements.txt          # Dependencies
└── venv/                     # Virtual environment
```

## 🚀 Cara Kerja

### Endpoint

| Endpoint | Method | Deskripsi |
|----------|--------|-----------|
| `/` | GET | Health check |
| `/health` | GET | System status |
| `/api/tasks` | GET | List semua tasks |
| `/api/tasks/{id}` | GET | Detail task |
| `/api/tasks` | POST | Buat task baru |

### Task Types

- **backup**: Backup data ke cloud/local storage
- **email**: Kirim email otomatis
- **deploy**: Deploy aplikasi
- **data_processing**: Proses data

### Status Task

- **pending**: Menunggu eksekusi
- **running**: Sedang dieksekusi
- **completed**: Selesai dengan sukses
- **error**: Gagal dieksekusi

## 🛠️ Setup

### Persyaratan
```bash
# Python 3.7+
cd backend/automation_backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Jalankan Server
```bash
cd automation_hub/backend/automation_backend
python main.py
```

### API Endpoints

#### Health Check
```bash
curl http://localhost:8000/health
```

#### List Tasks
```bash
curl http://localhost:8000/api/tasks
```\n
```bash
curl -X POST http://localhost:8000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Task",
    "type": "backup",
    "schedule": "immediate",
    "parameters": {
      "source": "/data",
      "destination": "s3://bucket",
      "compression": true
    }
  }'
```

## 📊 Fitur Utama

### Task Management
- Buat task dengan 4 tipe berbeda
- Progress monitoring real-time
- Error handling dan recovery
- Task scheduling

### Backend Features
- FastAPI framework
- Background task execution
- CORS middleware
- WebSocket support
- Environment configuration

## 🔧 Development

### Lokal Development
```bash
# Buat virtual environment
cd backend/automation_backend
python3 -m venv venv
source venv/bin/activate

# Instal dependencies
pip install -r requirements.txt

# Jalankan server
python main.py
```

### Testing
```bash
# Uji API endpoints
curl http://localhost:8000/api/tasks
```

### Environment
```bash
# Buat file .env
cp .env.example .env
# Edit .env dengan konfigurasi Anda
```

## 📚 Referensi

- FastAPI: https://fastapi.tiangolo.com/
- Python: https://docs.python.org/3/

## 🤝 Kontribusi

1. Fork repository
2. Buat branch: `git checkout -b feature/awesome-feature`
3. Commit: `git commit -m 'Add awesome feature'`
4. Push: `git push origin feature/awesome-feature`
5. PR

## 📄 Lisensi

MIT License
