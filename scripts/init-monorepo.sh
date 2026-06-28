#!/usr/bin/env bash
set -e

echo "Initializing Voter Sentiment Platform monorepo..."

mkdir -p backend/src/main/java/com/votersentiment
mkdir -p mobile/lib
mkdir -p admin/src
mkdir -p docs
mkdir -p scripts

echo "Monorepo structure created."
echo "Next steps:"
echo "  1. bash scripts/setup-env.sh"
echo "  2. bash scripts/init-backend.sh"
echo "  3. bash scripts/init-mobile.sh"
echo "  4. bash scripts/init-admin.sh"
