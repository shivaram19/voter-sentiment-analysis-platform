#!/usr/bin/env bash
set -e

echo "Seeding admin user..."
# TODO: replace with a curl call to POST /api/auth/register once backend is running.
echo "Run the backend, then execute:"
echo "  curl -X POST http://localhost:8080/api/auth/register \\"
echo "    -H 'Content-Type: application/json' \\"
echo "    -u admin:changeme \\"
echo "    -d '{\"username\":\"admin\",\"password\":\"changeme\",\"name\":\"System Admin\",\"role\":\"ADMIN\"}'"
