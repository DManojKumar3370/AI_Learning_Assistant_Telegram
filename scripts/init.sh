#!/bin/bash

# Initialize OpenClaw Configuration and Setup
# This script handles the initial OpenClaw configuration

set -e

OPENCLAW_CONFIG_DIR="$HOME/.openclaw"
SKILLS_DIR="$OPENCLAW_CONFIG_DIR/skills"

echo "Initializing OpenClaw Configuration..."

# Create directories
mkdir -p "$SKILLS_DIR/user-onboarding"
mkdir -p "$SKILLS_DIR/daily-quiz"
mkdir -p "$OPENCLAW_CONFIG_DIR/logs"

# Copy skill files if they don't exist
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

if [ -f "$PROJECT_ROOT/skills/user-onboarding/SKILL.md" ]; then
    cp "$PROJECT_ROOT/skills/user-onboarding/SKILL.md" "$SKILLS_DIR/user-onboarding/"
    echo "✓ Onboarding skill installed"
fi

if [ -f "$PROJECT_ROOT/skills/daily-quiz/SKILL.md" ]; then
    cp "$PROJECT_ROOT/skills/daily-quiz/SKILL.md" "$SKILLS_DIR/daily-quiz/"
    echo "✓ Daily quiz skill installed"
fi

# Create or update OpenClaw configuration
if [ ! -f "$OPENCLAW_CONFIG_DIR/openclaw.json" ]; then
    if [ -f "$PROJECT_ROOT/config/openclaw.json.example" ]; then
        cp "$PROJECT_ROOT/config/openclaw.json.example" "$OPENCLAW_CONFIG_DIR/openclaw.json"
        echo "✓ Configuration file created"
    fi
fi

echo "✓ Initialization complete"
