#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/.."

echo "Starting local development environment..."
docker compose up --build -d

echo "Services:"
echo "  Backend API: http://localhost:8080/api"
echo "  Admin UI:    http://localhost:3000"
echo "  PostgreSQL:  localhost:5432"
echo "  Redis:       localhost:6379"
