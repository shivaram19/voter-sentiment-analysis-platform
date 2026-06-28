#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

ADMIN_PORT="${ADMIN_PORT:-3000}"

# Find a free backend port starting at 8080.
BACKEND_PORT=8080
while ss -tln 2>/dev/null | grep -q ":${BACKEND_PORT} "; do
  BACKEND_PORT=$((BACKEND_PORT + 1))
done
export BACKEND_PORT ADMIN_PORT

BACKEND_URL="http://localhost:${BACKEND_PORT}"
ADMIN_URL="http://localhost:${ADMIN_PORT}"

wait_for_url() {
  local url=$1
  local label=$2
  local attempts=30
  echo "==> Waiting for ${label}..."
  for i in $(seq 1 ${attempts}); do
    if curl -fsS "${url}" >/dev/null 2>&1; then
      echo "    ${label} OK"
      return 0
    fi
    sleep 2
  done
  echo "    ${label} FAILED after ${attempts} attempts" >&2
  return 1
}

echo "==> Starting docker-compose stack on backend port ${BACKEND_PORT}..."
docker compose up --build -d

cleanup() {
  echo "==> Stopping docker-compose stack..."
  docker compose down
}
trap cleanup EXIT

wait_for_url "${BACKEND_URL}/api/health/live" "backend liveness"
wait_for_url "${BACKEND_URL}/api/health/ready" "backend readiness"
wait_for_url "${ADMIN_URL}" "admin dashboard root"
wait_for_url "${ADMIN_URL}/api/health/live" "admin -> backend proxy"

echo "==> Smoke tests passed."
