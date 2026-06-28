#!/usr/bin/env bash
set -e

echo "Initializing Flutter mobile project..."
cd ../mobile
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs || true
echo "Flutter project ready. Build with: flutter build apk"
