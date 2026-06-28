#!/usr/bin/env bash
set -e

echo "Installing admin dashboard dependencies..."
cd ../admin
npm install
echo "Admin dashboard ready. Run with: npm run dev"
