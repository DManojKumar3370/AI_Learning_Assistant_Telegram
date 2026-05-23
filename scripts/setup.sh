#!/bin/bash

# Setup script for OpenClaw Telegram Learning Assistant
# This script initializes OpenClaw with the necessary configuration and skills

set -e

echo "======================================"
echo "OpenClaw Learning Assistant Setup"
echo "======================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if OpenClaw is installed
if ! command -v openclaw &> /dev/null; then
    echo -e "${RED}✗ OpenClaw is not installed!${NC}"
    echo "Please install it using: npm install -g openclaw"
    exit 1
fi

echo -e "${GREEN}✓ OpenClaw found${NC}"
echo ""

# Check if node is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}✗ Node.js is not installed!${NC}"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node --version)
echo -e "${GREEN}✓ Node.js ${NODE_VERSION} found${NC}"
echo ""

# Create necessary directories
echo "Creating OpenClaw directories..."
mkdir -p ~/.openclaw/skills/user-onboarding
mkdir -p ~/.openclaw/skills/daily-quiz
mkdir -p ~/.openclaw/logs

echo -e "${GREEN}✓ Directories created${NC}"
echo ""

# Copy skill files if they exist in the project
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

if [ -f "$PROJECT_ROOT/skills/user-onboarding/SKILL.md" ]; then
    cp "$PROJECT_ROOT/skills/user-onboarding/SKILL.md" ~/.openclaw/skills/user-onboarding/
    echo -e "${GREEN}✓ Onboarding skill installed${NC}"
fi

if [ -f "$PROJECT_ROOT/skills/daily-quiz/SKILL.md" ]; then
    cp "$PROJECT_ROOT/skills/daily-quiz/SKILL.md" ~/.openclaw/skills/daily-quiz/
    echo -e "${GREEN}✓ Daily quiz skill installed${NC}"
fi

echo ""
echo "======================================"
echo "Pre-Configuration Checklist"
echo "======================================"
echo ""
echo "Before running 'openclaw onboard', please ensure:"
echo ""
echo "1. LLM Setup:"
echo "   - Option A (Recommended): Ollama installed and running"
echo "     $ ollama pull llama3:8b"
echo "     $ ollama serve"
echo "   - Option B: Cloud API key ready (OpenAI, Anthropic, Google)"
echo ""
echo "2. Telegram Bot Setup:"
echo "   - Talk to @BotFather on Telegram"
echo "   - Create a new bot: /newbot"
echo "   - Save the bot token"
echo ""
echo "3. Web Search (Optional):"
echo "   - DuckDuckGo: No configuration needed"
echo "   - SearXNG: Requires instance URL"
echo "   - Google: Requires API key"
echo ""
echo "======================================"
echo ""
echo "Next steps:"
echo ""
echo "1. Run the OpenClaw onboarding:"
echo "   $ openclaw onboard"
echo ""
echo "2. Start the gateway:"
echo "   $ openclaw gateway start"
echo ""
echo "3. Test the bot on Telegram"
echo ""
echo "4. Set up standing orders and cron jobs:"
echo ""
echo "   # Trigger onboarding for new users:"
echo "   $ openclaw standing-orders add \\"
echo "     --name 'trigger-user-onboarding' \\"
echo "     --if 'memory.user_profile_{{user.id}} does not exist' \\"
echo "     --run-skill 'user-onboarding'"
echo ""
echo "   # Schedule daily quiz at 9 PM:"
echo "   $ openclaw cron add \\"
echo "     --name 'nightly-tech-brief' \\"
echo "     --cron '0 21 * * *' \\"
echo "     --tz 'America/New_York' \\"
echo "     --session isolated \\"
echo "     --message 'Run the daily-quiz skill and send the personalized brief to the user on Telegram.' \\"
echo "     --announce \\"
echo "     --channel telegram"
echo ""
echo -e "${GREEN}Setup check complete!${NC}"
echo ""
