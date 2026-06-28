#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/.."

cp backend/.env.example backend/.env
cp admin/.env.example admin/.env

echo "Environment files copied. Review and update:"
echo "  backend/.env"
echo "  admin/.env"
