#!/usr/bin/env bash
set -e

echo "Backend source already scaffolded. Run Maven build:"
cd ../backend
mvn clean package -DskipTests
