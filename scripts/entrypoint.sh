#!/bin/sh

# Docker entrypoint script
# Handles initialization and startup of OpenClaw

set -e

echo "======================================"
echo "OpenClaw Telegram Assistant"
echo "======================================"
echo ""

# Check if openclaw is installed
if ! command -v openclaw &> /dev/null; then
    echo "✗ OpenClaw is not installed"
    echo "Installing OpenClaw..."
    npm install -g openclaw
fi

# Initialize configuration if needed
echo "Initializing OpenClaw..."

# Create necessary directories
mkdir -p /root/.openclaw/skills/user-onboarding
mkdir -p /root/.openclaw/skills/daily-quiz
mkdir -p /root/.openclaw/logs

# Copy skills if they exist
if [ -f "/app/skills/user-onboarding/SKILL.md" ]; then
    cp /app/skills/user-onboarding/SKILL.md /root/.openclaw/skills/user-onboarding/
    echo "✓ Onboarding skill installed"
fi

if [ -f "/app/skills/daily-quiz/SKILL.md" ]; then
    cp /app/skills/daily-quiz/SKILL.md /root/.openclaw/skills/daily-quiz/
    echo "✓ Daily quiz skill installed"
fi

# Copy configuration if it doesn't exist
if [ ! -f "/root/.openclaw/openclaw.json" ]; then
    if [ -f "/app/config/openclaw.json" ]; then
        cp /app/config/openclaw.json /root/.openclaw/openclaw.json
        echo "✓ Configuration installed"
    fi
fi

echo ""
echo "======================================"
echo "Starting OpenClaw Gateway"
echo "======================================"
echo ""

# Start the gateway
exec openclaw gateway start
