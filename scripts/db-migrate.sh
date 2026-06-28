#!/usr/bin/env bash
set -e

echo "Running Hibernate schema update via Quarkus dev mode..."
cd ../backend
mvn quarkus:dev &
QUARKUS_PID=$!
sleep 20
kill $QUARKUS_PID || true
echo "Schema updated."
