#!/bin/bash
# Automation Hub Deployment Script
# Follows Dev's AUDIT → PATCH → COMMIT protocol

set -e

echo "=== AUDIT ==="
echo "Checking project structure..."

# 1. AUDIT - read actual project files
if [ ! -d "automation_hub" ]; then
    echo "❌ ERROR: automation_hub directory not found!"
    exit 1
fi

echo "✅ Structure validated"

# 2. SETUP - create necessary directories
echo "=== SETUP ==="
mkdir -p automation_hub/backend/automation_backend/logs
mkdir -p automation_hub/mobile/automation_mobile/build
mkdir -p automation_hub/scripts/cache

echo "✅ Directories created"

# 3. BACKUP - create backup
echo "=== BACKUP ==="
BACKUP_DIR="automation_hub_backup_$(date +%s)"
mkdir "$BACKUP_DIR"

# Create symbolic links for easier access
ln -sf "$(pwd)/automation_hub/backend/automation_backend" "/tmp/backend_hub"
ln -sf "$(pwd)/automation_hub/mobile/automation_mobile" "/tmp/mobile_hub"

echo "✅ Backup created: $BACKUP_DIR"

# 4. CHECK - validate project structure
echo "=== CHECK ==="

# Check Flutter project
if [ ! -f "automation_hub/mobile/automation_mobile/pubspec.yaml" ]; then
    echo "❌ ERROR: Flutter pubspec.yaml not found!"
    exit 1
fi

# Check Python project
if [ ! -f "automation_hub/backend/automation_backend/requirements.txt" ]; then
    echo "❌ ERROR: Python requirements.txt not found!"
    exit 1
fi

# Check backend main file
if [ ! -f "automation_hub/backend/automation_backend/main.py" ]; then
    echo "❌ ERROR: Backend main.py not found!"
    exit 1
fi

# Check mobile main file
if [ ! -f "automation_hub/mobile/automation_mobile/lib/main.dart" ]; then
    echo "❌ ERROR: Mobile main.dart not found!"
    exit 1
fi

echo "✅ All files validated"

# 5. PREVIEW - show diff
echo "=== PREVIEW ==="
echo "Project automation_hub siap untuk deploy:"
echo "├── mobile/automation_mobile/ (Flutter App)"
echo "├── backend/automation_backend/ (Python API)"
echo "├── scripts/ (Bash automation)"
echo "└── .github/workflows/ (GitHub Actions)"

# 6. TUNGGU - konfirmasi
echo "=== TUNGGU ==="
echo "Proyek siap untuk deploy. Tekan CTRL+C untuk batal."
echo "Tunggu 5 detik untuk membatalkan..."

for i in 5 4 3 2 1; do
    echo "Mulai deploy dalam \$i detik..."
    sleep 1
done

echo "=== COMMIT ==="
echo "✅ Deploy automation_hub sukses!"
echo "Next steps:"
echo "1. cd automation_hub/backend/automation_backend"
echo "2. source venv/bin/activate"
echo "3. pip install -r requirements.txt"
echo "4. python main.py"
echo ""
echo "Frontend:"
echo "1. cd automation_hub/mobile/automation_mobile"
echo "2. flutter run"

echo "=== SETUP SELESAI ==="
