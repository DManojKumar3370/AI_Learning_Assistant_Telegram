#!/bin/bash

# Deploy OpenClaw to production
# This script handles deployment tasks

set -e

echo "======================================"
echo "OpenClaw Deployment Script"
echo "======================================"
echo ""

# Check for Docker and Docker Compose
if ! command -v docker &> /dev/null; then
    echo "✗ Docker is not installed"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "✗ Docker Compose is not installed"
    exit 1
fi

echo "✓ Docker and Docker Compose found"
echo ""

# Get the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

cd "$PROJECT_ROOT"

# Check for required files
if [ ! -f ".env" ]; then
    echo "Creating .env file from .env.example..."
    cp .env.example .env
    echo "✗ Please edit .env with your configuration and run this script again"
    exit 1
fi

echo "Building Docker image..."
docker-compose build

echo ""
echo "Starting services..."
docker-compose up -d

echo ""
echo "Waiting for services to be ready..."
sleep 10

echo ""
echo "Services status:"
docker-compose ps

echo ""
echo "✓ Deployment complete!"
echo ""
echo "Next steps:"
echo "1. Run setup inside container: docker-compose exec openclaw-gateway openclaw onboard"
echo "2. View logs: docker-compose logs -f openclaw-gateway"
echo "3. Stop services: docker-compose down"
echo ""
