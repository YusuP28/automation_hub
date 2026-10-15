# Automation Hub - Mobile App (Flutter)

## 🎯 Overview

Aplikasi mobile Flutter untuk Automation Hub, menampilkan antarmuka untuk manajemen tugas otomatisasi.

## 📋 Struktur

```
mobile/automation_mobile/
├── lib/              # Kode Dart utama
│   └── main.dart     # Aplikasi Flutter utama
├── analysis_options.yaml
├── pubspec.yaml     # Konfigurasi Flutter
├── README.md        # Dokumentasi aplikasi mobile
├── android/         # Konfigurasi Android
├── ios/             # Konfigurasi iOS
├── linux/           # Konfigurasi Linux
├── macos/           # Konfigurasi macOS
├── windows/         # Konfigurasi Windows
└── web/             # Konfigurasi Web
```

## 🚀 Cara Kerja

### UI Components

1. **Task List** - Menampilkan daftar semua tugas dengan status
2. **Quick Action Buttons** - 4 tombol untuk membuat tugas cepat
3. **Progress Indicators** - Visual progress untuk tugas yang sedang berjalan
4. **Real-time Updates** - Update UI saat backend memperbarui status

### Features

- **4 Tipe Tugas**: Backup, Email, Deploy, Data Processing
- **Status Visual**: Indikator warna dan progress bar
- **Real-time Sync**: Koneksi ke backend API
- **Offline First**: Cache dan sinkronisasi nanti
- **Material Design**: Antarmuka pengguna yang konsisten

## 🛠️ Setup

### Persyaratan
```bash
# Flutter SDK
# Dart SDK
# Git
```

### Setup Proyek
```bash
# Buat proyek Flutter baru
cd mobile
flutter create automation_mobile

# Pindah ke direktori proyek
cd automation_mobile

# Jalankan dependensi
flutter pub get
```

### Jalankan Aplikasi
```bash
# Di Android Emulator
flutter run --device-type=android

# Di iOS Simulator
flutter run --device-type=ios

# Di Web
flutter run --web
```

## 📊 Contoh Kode

### Widget Utama
```dart
class AutomationHomePage extends StatefulWidget {
  const AutomationHomePage({Key? key}) : super(key: key);\n
  @override
  _AutomationHomePageState createState() => _AutomationHomePageState();
}

class _AutomationHomePageState extends State<AutomationHomePage> {
  List<Map<String, dynamic>> tasks = [];
  bool isLoadingอง = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // API call to backend
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/tasks'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          tasks = data.map((item) => Map<String, dynamic>.from(item)).toList();
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load tasks';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading tasks: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automation Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTasks,
          ),
        ],
      ),
      body: Column(
        children: [
          // Error message
          if (errorMessage != null)
            Container(
              color: Colors.red[100],
              padding: const EdgeInsets.all(8),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          
          // Loading indicator
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          
          // Task list
          if (!isLoading)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Icon(
                        _getTaskIcon(task['type']),
                        color: _getTaskColor(task['type']),
                      ),
                      title: Text(task['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${task['id']}'),
                          Text('Tipe: ${task['type']}'),
                          Text('Status: ${task['status']}'),
                        ],\n```

## 📲 Installasi

### Android
```bash
# Install Flutter SDK
apto-get install flutter

# Setup Android Studio IDE
# Download from https
```

### iOS
```bash
# Install Xcode
# Download from https://developer.apple.com/xcode/
```

### Web
```bash
# Flutter Web Support
flutter channel stable
flutter upgrade
flutter config --enable-web
```

## 🔧 Konfigurasi

### pubspec.yaml
```yaml
name: automation_mobile
description: Automation Hub mobile application
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  http: ^1.2.1
  shared_preferences: ^2.3.2
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.1

flutter:
  uses-material-design: true
```

## 📚 Referensi

- Flutter Docs: https://flutter.dev/docs
- Dart Language: https://dart.dev/language
- Material Design: https://material.io/design

## 🤝 Kontribusi

1. Fork repository
2. Buat branch: `git checkout -b feature/awesome-feature`
3. Commit: `git commit -m 'Add awesome feature'`
4. Push: `git push origin feature/awesome-feature`
5. PR

## 📄 Lisensi

MIT License
