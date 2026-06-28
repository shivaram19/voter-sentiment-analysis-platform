#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/.."

echo "Building backend..."
cd backend
mvn clean package -DskipTests
cd ..

echo "Building admin dashboard..."
cd admin
npm ci
npm run build
cd ..

echo "Building Flutter APK..."
cd mobile
flutter pub get
flutter build apk
cd ..

echo "All builds completed."
