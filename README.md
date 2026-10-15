# Automation Hub - API + Mobile Application

## 🎯 Overview

Automation Hub adalah platform otomatisasi mobile + backend yang mengimplementasikan **alur kerja audit yang ketat** untuk mengembangkan aplikasi Flutter dan API backend dengan reliability tinggi.

## 📋 Struktur Proyek

```
automation_hub/
├── backend/                    # Backend API (FastAPI)
│   └── automation_backend/     # Backend API lengkap
│       ├── main.py            # Server FastAPI
│       ├── .env              # Environment variables
│       ├── requirements.txt  # Dependencies
│       └── venv/             # Virtual environment
│
├── mobile/                     # Aplikasi Flutter
│   └── automation_mobile/     # Proyek Flutter
│       ├── lib/              # Kode Dart utama
│       │   └── main.dart     # Aplikasi Flutter
│       ├── analysis_options.yaml
│       ├── pubspec.yaml     # Konfigurasi Flutter
│       └── README.md        # Dokumentasi Flutter
│
├── scripts/                    # Skrip otomatisasi
│   └── deploy.sh             # Setup otomatis
│
├── .github/                    # CI/CD pipeline
│   └── workflows/
│       └── ci-cd.yml         # GitHub Actions
│
├── test_backend_simulation.py # Simulasi backend API
├── test_mobile_simulation.py  # Simulasi aplikasi mobile
├├─ docs/                       # Dokumentasi (file ini)
│   └── README.md             # Panduan penggunaan
│
├── README.md                  # Documentasi ini
├── .git/                      # Git repository
└── start_application.sh       # Skrip startup
```

## 🚀 Cara Kerja

### 1. Backend API (`backend/automation_backend/main.py`)
- **Framework**: FastAPI
- **Language**: Python
- **Features**:
  - REST API endpoints
  - Task management (4 tipe: backup, email, deploy, data_processing)
  - Background task execution
  - Real-time status updates
  - CORS middleware

### .**Database (automation_hub/backend/automation_backend/.env`)
  - Environment variables
  - Konfigurasi API key
  - Database connection string

### 2. Aplikasi Mobile (`mobile/automation_mobile/lib/main.dart`)
- **Framework**: Flutter
- **Language**: Dart
- **Features**:
  - UI untuk manajemen tugas
  - 4 tombol aksi cepat
  - Progress bar visual untuk eksekusi tugas
  - Koneksi API real-time

### 3. Otomatisasi (`scripts/deploy.sh`)
- **Audit-first workflow**: AUDIT → SETUP → BACKUP → CHECK → PREVIEW → COMMIT
- Membuat direktori dan menginisialisasi proyek
- Menginstal dependensi
- Menjalankan backend dan mobile

### 4. CI/CD (`.github/workflows/ci-cd.yml`)
- **GitHub Actions**: Test & Deploy otomatis
- **Flutter testing**: `flutter test`
- **API testing**: `pytest`
- **Docker build**: Containerisasi aplikasi

## 📦 Cara Menggunakan

### Persyaratan
```bash
# Python 3.7+
# Flutter SDK
# Git
# Docker (opsional)
```

### 1. Setup Otomatis (Direkomendasikan)
```bash
# Clone repository
cd ~
git clone https:github.com/YusuP28/automation_hub.git

# Jalankan skrip setup otomatis
cd automation_hub
./scripts/deploy.sh
```

### 2. Manual Setup

#### A. Backend API
```bash
# Buat virtual environment
cd automation_hub/backend/automation_backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Jalankan server
cd automation_hub/backend/automation_backend
python main.py
```

#### B. Aplikasi Mobile
```bash
# Buat proyek Flutter (jika belum ada)
cd automation_hub/mobile
flutter create automation_mobile

# Jalankan dependensi
cd automation_hub/mobile/automation_mobile
flutter pub get

# Jalankan aplikasi
cd automation_hub/mobile/automation_mobile
flutter run
```

#### C. Test API
```bash
# Test endpoint health
curl http://localhost:8000/health

# Buat tugas baru
curl -X POST http://localhost:8000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Task",
    "type": "backup",
    "schedule": "immediate",
    "parameters": {
      "source": "/data",
      "destination": "s3://bucket"
    }
  }'
```

## 🚀 Uji Coba Cepat

### Uji Coba Simulasi
```bash
# Simulasikan backend API
python3 test_backend_simulation.py

# Simulasikan aplikasi mobile
python3 test_mobile_simulation.py
```

### Uji Coba Backend Nyata
```bash
# Jalankan backend API
cd automation_hub/backend/automation_backend
python main.py

# Test API endpoints
# Buka browser ke: http://localhost:8000/docs
```

### Uji Coba Mobile App
```bash
# Jalankan aplikasi mobile
cd automation_hub/mobile/automation_mobile
flutter run

# Atau jalankan di emulator
flutter run --device-type=android

# Atau jalankan di simulator
flutter run --device-type=ios
```

## 📊 Prinsip Kerja

### Audit-First Workflow
1. **AUDIT**: Baca kode yang sudah ada
2. **SETUP**: Buat direktori dan backup
3. **CHECK**: Validasi struktur dan bracket
4. **PREVIEW**: Tampilkan diff ke developer
5. **COMMIT**: Commit terpisah dari patch

### 4 Layer Keterangan
1. **Frontend**: HTML, CSS, JavaScript, React, Vue, Next.js
2. **Backend**: Node Express, Laravel, Django, Flask, PHP
3. **Mobile**: Flutter, React Native, Kotlin, Electron
4. **DevOps**: Docker, K8s, GH Actions, AWS, VPS

## 🎯 Fitur Utama

### Backend API
- **4 Tipe Tugas**: Backup, Email, Deploy, Data Processing
- **Status Tracking**: pending, running, completed, error
- **Progress Bar**: Visual progress monitoring
- **Error Handling**: Recovery dan retry
- **Real-time Updates**: WebSocket support

### Aplikasi Mobile
- **4 Tombol Aksi Cepat**: Langsung buat tugas
- **Status Visual**: Indikator warna dan progress bar
- **Real-time Sync**: Update UI saat backend memperbarui status
- **Offline First**: Cache dan sinkronisasi nanti

### Otomatisasi
- **CI/CD**: GitHub Actions dengan test otomatis
- **Docker**: Containerized deployment
- **Setup Script**: One-command setup
- **Git Hooks**: Pre-commit dan post-commit

## 🛠️ Teknologi Stack

### Frontend (Flutter)
- Dart 3.x
- Flutter 3.19.6
- Provider state management
- Material Design

### Backend (Python)
- FastAPI
- Python 3.11+
- SQLite/PostgreSQL
- WebSocket

### DevOps
- GitHub Actions
- Docker
- Linux Mint, Ubuntu, macOS
- WSL support

## 🚀 Roadmap

### Fase 1: Inti (Sudah Selesai)
- [x] Backend API dengan FastAPI
- [x] Aplikasi Flutter dengan UI
- [x] Simulasi tugas dan eksekusi
- [x] Simulasi backend testing
- [x] Dokumentasi lengkap

### Fase 2: Penambahan Fitur
- [ ] AI integration untuk task automation
- [ ] WebSocket real-time updates
- [ ] Advanced task scheduling
- [ ] Multi-device synchronization

### Fase 3: Produksi
- [ ] CI/CD pipeline otomatis
- [ ] Docker containerization
- [ ] Monitoring & logging
- [ ] Security hardening

## 📚 Sumber Belajar

### Backend (FastAPI)
- FastAPI Documentation: https://fastapi.tiangolo.com/
- Python Docs: https://docs.python.org/3/

### Mobile (Flutter)
- Flutter Docs: https://flutter.dev/docs
- Dart Language: https.
//dart.dev/language

### DevOps
- GitHub Actions: https://docs.github.com/actions
- Docker: https://docs.docker.com/

## 🤝 Kontribusi

1. Fork repository
2. Buat branch fitur: `git checkout -b feature/awesome-feature`
3. Commit perubahan: `git commit -m 'Add awesome feature'`
4. Push ke branch: `git push origin feature/awesome-feature`
5. Buat Pull Request

## 📄 Lisensi

MIT License

## 🙏 Terima Kasih

- Development: All automation tools and frameworks
- Community: Open source contributors
- Documentation: Technical writers and maintainers

---

*✨ Dibuat dengan ❤️ menggunakan Flutter dan Python, mengikuti protokol otomatisasi Dev*
*📧 Untuk pertanyaan: muhamadyusup0704@gmail.com*
