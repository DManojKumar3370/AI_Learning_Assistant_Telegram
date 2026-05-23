# 🤖 Personalized AI Learning Assistant on Telegram

A cutting-edge personalized learning assistant built with **OpenClaw**, a self-hosted AI framework. This bot learns your technical interests and delivers curated daily interview questions and technical insights right to your Telegram every evening at 9 PM.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Option A: Local Setup](#option-a-local-setup)
  - [Option B: Docker Setup](#option-b-docker-setup)
- [Configuration](#configuration)
- [Usage](#usage)
- [Skills Documentation](#skills-documentation)
- [Automation & Scheduling](#automation--scheduling)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)
- [Advanced Configuration](#advanced-configuration)
- [Project Structure](#project-structure)

## 📖 Overview

This project implements a personalized Telegram bot powered by OpenClaw, an open-source personal AI assistant framework. Unlike traditional chatbots, this system:

- **Learns your preferences** through an intelligent onboarding process
- **Proactively delivers content** via automated daily jobs
- **Maintains persistent memory** to remember user profiles across sessions
- **Leverages web search** to find fresh, relevant content daily
- **Runs privately** on your own hardware or cloud instance

### Key Technologies

- **OpenClaw**: Open-source personal AI framework
- **LLM**: Ollama (local) or cloud providers (OpenAI, Anthropic, Google)
- **Communication**: Telegram Bot API
- **Search**: DuckDuckGo, SearXNG, or Google
- **Containerization**: Docker & Docker Compose
- **Automation**: Built-in cron scheduler

## ✨ Features

✅ **Intelligent Onboarding**
- Conversational flow to understand user preferences
- Captures technical domains, experience level, and learning goals
- Persistent user profiles stored in memory

✅ **Personalized Daily Briefs**
- 5 tailored interview questions matched to user's skill level
- 3-5 technical tidbits sourced from web search
- Delivered daily at 9 PM in user's local timezone
- Beautiful Markdown formatting optimized for mobile

✅ **Web Search Integration**
- Automatically searches for fresh content in user's technical domains
- Synthesizes insights from multiple sources
- Prioritizes recent and relevant results

✅ **Autonomous Operation**
- Automatic trigger for first-time users
- Scheduled daily delivery via cron jobs
- No manual intervention required after setup

✅ **Privacy-First Design**
- Self-hosted on your own hardware
- Data stored locally
- No vendor lock-in
- Full control over your data

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        User (Telegram)                           │
└─────────────────────────────────────────────────────────────────┘
                                 ↕
                        ┌────────────────┐
                        │  Telegram API  │
                        │   (Channel)    │
                        └────────────────┘
                                 ↕
┌─────────────────────────────────────────────────────────────────┐
│                    OpenClaw Gateway                              │
│ ┌──────────────────────────────────────────────────────────┐   │
│ │                  Molty (Core Agent)                       │   │
│ │  - Reasoning Engine                                       │   │
│ │  - Multi-step Task Execution                              │   │
│ │  - Memory Management                                      │   │
│ └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│ ┌──────────────────────────────────────────────────────────┐   │
│ │              Tools & Integrations                         │   │
│ │  - web_search       - web_fetch                          │   │
│ │  - memory_store     - command_execute                    │   │
│ │  - file_system      - http_request                       │   │
│ └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│ ┌──────────────────────────────────────────────────────────┐   │
│ │           Skills & Automation                            │   │
│ │  - user-onboarding/SKILL.md                              │   │
│ │  - daily-quiz/SKILL.md                                   │   │
│ │  - Cron Scheduler (9 PM daily)                           │   │
│ │  - Standing Orders (new user detection)                  │   │
│ └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│ ┌──────────────────────────────────────────────────────────┐   │
│ │           Persistent Memory Store                        │   │
│ │  - user_profile_{user_id}                                │   │
│ │  - conversation_history                                  │   │
│ │  - asked_questions_tracking                              │   │
│ └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
                                 ↕
        ┌────────────────────────────────────────┐
        │     LLM Provider                       │
        │ ┌──────────────────────────────────┐  │
        │ │ Ollama (Local) OR Cloud API      │  │
        │ │ - llama3:8b, gemma, mistral...   │  │
        │ │ - OpenAI, Anthropic, Google      │  │
        │ └──────────────────────────────────┘  │
        └────────────────────────────────────────┘
                                 ↕
        ┌────────────────────────────────────────┐
        │     Web Search Provider                │
        │ - DuckDuckGo (recommended)             │
        │ - SearXNG                              │
        │ - Google Search                        │
        └────────────────────────────────────────┘
```

### Data Flow

1. **Onboarding**: User sends first message → Standing Order triggers → Onboarding skill executes → Profile stored in memory
2. **Daily Brief**: Cron job triggers at 9 PM → Daily quiz skill executes → Web search for fresh content → Questions generated → Message formatted → Telegram API sends to user

## 🔧 Prerequisites

### System Requirements

- **OS**: Linux, macOS, or Windows (with WSL2)
- **RAM**: Minimum 4GB (8GB+ recommended for Ollama)
- **Disk**: 10GB+ free space (for LLM models)
- **Network**: Stable internet connection

### Software Requirements

- **Node.js**: v18+ (LTS recommended)
- **Docker & Docker Compose**: Latest versions (for containerized setup)
- **Ollama**: (Only if using local LLM)
- **Git**: For cloning the repository

### Accounts & Keys

- **Telegram Bot Token**: From @BotFather
- **LLM API Key**: (Optional) OpenAI, Anthropic, or Google
- **Web Search**: (Optional) None needed for DuckDuckGo

## 📦 Installation

### Option A: Local Setup

Follow these steps to run OpenClaw directly on your machine.

#### Step 1: Install OpenClaw

```bash
# Install OpenClaw globally
npm install -g openclaw

# Verify installation
openclaw --version
```

#### Step 2: Set Up the Language Model

**Option A1: Ollama (Recommended - Free & Private)**

```bash
# Install Ollama from https://ollama.ai

# In a separate terminal, start Ollama server
ollama serve

# In another terminal, pull a model
ollama pull llama3:8b
```

**Option A2: Cloud Provider**

If you prefer a cloud-based LLM (OpenAI, Anthropic, etc.), have your API key ready.

#### Step 3: Create Telegram Bot

1. Open Telegram and search for `@BotFather`
2. Send `/newbot` command
3. Provide a name and username (must end in "bot")
4. Copy the HTTP API token (this is your `TELEGRAM_BOT_TOKEN`)

#### Step 4: Clone This Repository

```bash
git clone https://github.com/yourusername/AI_Learning_Assistant_Telegram.git
cd AI_Learning_Assistant_Telegram
```

#### Step 5: Run Setup Script

```bash
# Make the setup script executable
chmod +x scripts/setup.sh

# Run the setup script
./scripts/setup.sh
```

#### Step 6: OpenClaw Onboarding

```bash
# Run OpenClaw's interactive setup
openclaw onboard

# Follow the prompts:
# 1. Model Provider: Choose 'ollama' (or your cloud provider)
# 2. Model: Select 'llama3:8b' (or your chosen model)
# 3. Telegram: When asked about channels, say 'yes' and provide your bot token
# 4. Web Search: Choose 'duckduckgo'
```

This creates `~/.openclaw/openclaw.json` with your configuration.

#### Step 7: Verify Configuration

```bash
# View your OpenClaw config
cat ~/.openclaw/openclaw.json

# Verify skills are loaded
ls ~/.openclaw/skills/user-onboarding/
ls ~/.openclaw/skills/daily-quiz/
```

#### Step 8: Start the Gateway

```bash
# Start the OpenClaw gateway
openclaw gateway start

# You should see logs indicating:
# - Gateway started on port 3000
# - Telegram plugin connected
```

#### Step 9: Test the Bot

1. Open Telegram
2. Find your bot and send a message like "Hello"
3. You should receive a response from the agent
4. The onboarding should trigger automatically

#### Step 10: Set Up Automation

**Create Standing Order for Onboarding**

```bash
openclaw standing-orders add \
  --name "trigger-user-onboarding" \
  --if "memory.user_profile_{{user.id}} does not exist" \
  --run-skill "user-onboarding"
```

**Create Cron Job for Daily Quiz**

```bash
# Replace 'America/New_York' with your timezone
openclaw cron add \
  --name "nightly-tech-brief" \
  --cron "0 21 * * *" \
  --tz "America/New_York" \
  --session isolated \
  --message "Run the daily-quiz skill for the user. Retrieve their profile from memory, search for fresh content in their technical domains, generate 5 interview questions and 3-5 tidbits, and send the formatted daily brief to them on Telegram." \
  --announce \
  --channel telegram
```

### Option B: Docker Setup

For an easier, more reproducible setup using containers.

#### Step 1: Prerequisites

- Docker and Docker Compose installed
- Telegram bot token (from @BotFather)
- (Optional) OpenAI/Anthropic API key

#### Step 2: Clone Repository

```bash
git clone https://github.com/yourusername/AI_Learning_Assistant_Telegram.git
cd AI_Learning_Assistant_Telegram
```

#### Step 3: Configure Environment

```bash
# Copy the example environment file
cp .env.example .env

# Edit .env with your configuration
nano .env
# Or use your preferred editor
```

#### Step 4: Update Configuration File

```bash
# Copy the example OpenClaw config
cp config/openclaw.json.example config/openclaw.json

# Edit to match your setup
nano config/openclaw.json
```

#### Step 5: Build and Run

```bash
# Build the Docker image
docker-compose build

# Start all services (OpenClaw + Ollama)
docker-compose up -d

# View logs
docker-compose logs -f openclaw-gateway

# Stop services
docker-compose down
```

#### Step 6: Initialize OpenClaw in Container

```bash
# Access the container
docker exec -it ai-learning-assistant /bin/sh

# Run onboarding
openclaw onboard

# Exit container
exit
```

#### Step 7: Set Up Automation (Same as Local Setup)

```bash
# From your host machine
docker exec ai-learning-assistant openclaw standing-orders add \
  --name "trigger-user-onboarding" \
  --if "memory.user_profile_{{user.id}} does not exist" \
  --run-skill "user-onboarding"

docker exec ai-learning-assistant openclaw cron add \
  --name "nightly-tech-brief" \
  --cron "0 21 * * *" \
  --tz "America/New_York" \
  --session isolated \
  --message "Run the daily-quiz skill and send the personalized brief to the user." \
  --announce \
  --channel telegram
```

## ⚙️ Configuration

### openclaw.json Configuration

The main configuration file is located at `~/.openclaw/openclaw.json`. Here's an example:

```json
{
  "agent": {
    "name": "PersonalLearningAssistant",
    "description": "A personalized AI learning assistant",
    "version": "1.0.0"
  },
  "gateway": {
    "port": 3000,
    "host": "0.0.0.0"
  },
  "models": [
    {
      "id": "primary",
      "provider": "ollama",
      "model": "llama3:8b",
      "config": {
        "temperature": 0.7,
        "maxTokens": 2048
      }
    }
  ],
  "plugins": {
    "entries": {
      "telegram": {
        "enabled": true,
        "package": "@openclaw/plugin-telegram",
        "config": {
          "botToken": "${env.TELEGRAM_BOT_TOKEN}",
          "parseMode": "Markdown"
        }
      }
    }
  },
  "tools": {
    "webSearch": {
      "enabled": true,
      "provider": "duckduckgo"
    },
    "memoryStore": {
      "enabled": true,
      "type": "persistent",
      "config": {
        "storePath": "/root/.openclaw/memory.json"
      }
    }
  },
  "scheduler": {
    "enabled": true,
    "timezone": "America/New_York"
  },
  "skills": {
    "path": "/root/.openclaw/skills",
    "autoLoad": true
  }
}
```

### Environment Variables

Create a `.env` file in your home directory or use Docker environment variables:

```bash
# LLM Configuration
LLM_PROVIDER=ollama                    # ollama, openai, anthropic, google
LLM_MODEL=llama3:8b                    # Model name
OPENAI_API_KEY=sk-your-key-here        # Only for OpenAI
OLLAMA_API_URL=http://localhost:11434  # Ollama endpoint

# Telegram
TELEGRAM_BOT_TOKEN=your-token-here

# Web Search
WEB_SEARCH_PROVIDER=duckduckgo          # duckduckgo, searxng, google

# General
TIMEZONE=America/New_York               # User's timezone
NODE_ENV=production
```

### Supported LLM Providers

| Provider | Setup | Notes |
|----------|-------|-------|
| **Ollama** | Local | Free, private, requires 4GB+ RAM |
| **OpenAI** | API Key | GPT-4o, GPT-4-turbo, GPT-3.5-turbo |
| **Anthropic** | API Key | Claude 3 Opus, Sonnet, Haiku |
| **Google** | API Key | Gemini Pro, Gemini Ultra |
| **Local LLaMA** | Via Ollama | Llama 3, Mistral, Gemma, Neural Chat |

## 🚀 Usage

### Starting the Service

**Local Setup:**
```bash
# Terminal 1: Start Ollama (if using local LLM)
ollama serve

# Terminal 2: Start OpenClaw Gateway
openclaw gateway start

# Logs should show:
# ✓ Gateway started on port 3000
# ✓ Telegram plugin connected
# ✓ Skills loaded from /root/.openclaw/skills
```

**Docker Setup:**
```bash
docker-compose up -d
docker-compose logs -f openclaw-gateway
```

### Interacting with the Bot

1. **First Message (Triggers Onboarding):**
   ```
   User: Hello, I want to start learning!
   Bot: Welcome to your Personal AI Learning Assistant! 🎓
        Let me get to know you better...
   ```

2. **Onboarding Flow:**
   - Bot asks about technical domains
   - Bot asks about experience level
   - Bot asks about learning goals
   - Bot asks about timezone
   - Profile is saved to memory

3. **Daily Brief (Automatic at 9 PM):**
   ```
   🦞 *Your Daily Tech Brief* — May 22, 2024
   
   ━━━━━━━━━━━━━━━━━━━━
   🧠 *Interview Questions*
   ━━━━━━━━━━━━━━━━━━━━
   
   *Q1: Conceptual — Go*
   Explain how goroutines differ from OS threads...
   
   ...
   ```

### Useful Commands

```bash
# View user profile in memory
openclaw memory get "user_profile_123456"

# Manually trigger the daily quiz
openclaw cron trigger "nightly-tech-brief"

# List all scheduled cron jobs
openclaw cron list

# List all standing orders
openclaw standing-orders list

# View gateway logs
openclaw gateway logs

# Stop the gateway
openclaw gateway stop
```

## 📚 Skills Documentation

### Onboarding Skill (`skills/user-onboarding/SKILL.md`)

**Triggered By:** Standing Order when user has no profile in memory

**Workflow:**
1. Warm greeting and introduction
2. Ask about technical domains (Go, Python, ML, DevOps, etc.)
3. Ask about experience level (junior, mid-level, senior, staff)
4. Ask about learning goals (interview prep, staying current, deep dive)
5. Ask about timezone
6. Store profile in memory with structure:
   ```json
   {
     "user_profile_123456": {
       "domains": ["Go", "distributed systems"],
       "level": "mid-level",
       "goals": ["interview preparation", "system design"],
       "timezone": "America/New_York"
     }
   }
   ```
7. Confirm preferences and inform user about daily brief timing

**Key Features:**
- Conversational and friendly tone
- Handles ambiguous answers by asking clarifications
- Validates timezone input
- Stores data in a consistent JSON structure

### Daily Quiz Skill (`skills/daily-quiz/SKILL.md`)

**Triggered By:** Cron job at 9 PM daily in user's timezone

**Workflow:**
1. Retrieve user profile from memory using their ID
2. Perform web search for each technical domain:
   - Search queries like "latest Go performance optimization 2024"
   - Fetch 1-2 results per domain for fresh content
3. Synthesize 3-5 technical tidbits:
   - Recent development or best practice
   - Actionable insight related to user's domains
   - Accurate and verifiable information
4. Generate exactly 5 interview questions:
   - Matched to user's experience level
   - Mix of conceptual, coding, system design, behavioral
   - Relevant to user's technical domains
5. Format message with Markdown:
   - Title with date
   - Interview questions section with Q1-Q5
   - Technical tidbits section
   - Call-to-action for user feedback
6. Send via Telegram API

**Example Output:**
```
🦞 *Your Daily Tech Brief* — May 22, 2024

━━━━━━━━━━━━━━━━━━━━
🧠 *Interview Questions*
━━━━━━━━━━━━━━━━━━━━

*Q1: Conceptual — Distributed Systems*
Explain the CAP theorem and its implications for designing distributed databases.

*Q2: Coding — Go*
Implement a thread-safe counter in Go that can handle concurrent increments.

*Q3: System Design — DevOps*
Design a monitoring system for a microservices architecture with 100+ services.

*Q4: Conceptual — Machine Learning*
What is the difference between model training, validation, and testing? Why separate them?

*Q5: Behavioral — General*
Tell us about a time you had to learn a new technology quickly for a project.

━━━━━━━━━━━━━━━━━━━━
💡 *Today's Tidbits*
━━━━━━━━━━━━━━━━━━━━

• Go 1.22 introduces range-over-func for more flexible iteration patterns, enabling cleaner code for custom data structures.

• Raft consensus algorithm simplified distributed system design - most modern systems now use Raft for leader election and log replication.

• Kubernetes 1.28 deprecated legacy container runtime interfaces, standardizing on CRI (Container Runtime Interface).

• LangChain 0.1.0 introduced improved memory management for long-running agent applications.

• WebAssembly (WASM) adoption in edge computing growing 45% YoY, enabling serverless functions at the edge.

━━━━━━━━━━━━━━━━━━━━
Reply *answers* to get feedback, or *more* for extra questions.
```

## ⏰ Automation & Scheduling

### Standing Orders (New User Detection)

Standing Orders are rules that trigger skills based on conditions.

```bash
# Trigger onboarding for any new user
openclaw standing-orders add \
  --name "trigger-user-onboarding" \
  --if "memory.user_profile_{{user.id}} does not exist" \
  --run-skill "user-onboarding"

# Verify standing order
openclaw standing-orders list
```

### Cron Jobs (Scheduled Tasks)

Cron jobs schedule recurring tasks using standard cron syntax.

```bash
# Schedule daily brief at 9 PM in user's timezone
openclaw cron add \
  --name "nightly-tech-brief" \
  --cron "0 21 * * *" \
  --tz "America/New_York" \
  --session isolated \
  --message "Run the daily-quiz skill. Retrieve the user's profile, search for fresh content in their domains, generate 5 interview questions and 3-5 tidbits, format as a daily brief, and send to user on Telegram." \
  --announce \
  --channel telegram

# List all cron jobs
openclaw cron list

# Test cron job immediately
openclaw cron trigger "nightly-tech-brief"

# Remove cron job
openclaw cron remove "nightly-tech-brief"
```

### Cron Syntax Explanation

`0 21 * * *` = 9 PM every day
- `0` = minute (0-59)
- `21` = hour (0-23) in 24-hour format
- `*` = day of month (1-31)
- `*` = month (1-12)
- `*` = day of week (0-6, where 0 = Sunday)

### Timezone Support

Supported timezone formats (IANA):
- `America/New_York`, `America/Los_Angeles`, `America/Chicago`
- `Europe/London`, `Europe/Paris`, `Europe/Berlin`
- `Asia/Tokyo`, `Asia/Shanghai`, `Asia/Kolkata`, `Asia/Dubai`
- `Australia/Sydney`, `Australia/Melbourne`
- `UTC`, `GMT`, `Etc/UTC`

## ✅ Testing

### Manual Testing

```bash
# 1. Test onboarding skill
# Send a message from a new Telegram account to your bot

# 2. Check saved profile
openclaw memory get "user_profile_123456"

# 3. Test daily quiz skill
openclaw cron trigger "nightly-tech-brief"

# 4. Check gateway logs for errors
openclaw gateway logs | tail -50

# 5. Verify Telegram message delivery
# Check if message was received on Telegram
```

### Debugging

```bash
# Enable debug logging
DEBUG=openclaw:* openclaw gateway start

# Check if skills are loaded
ls -la ~/.openclaw/skills/

# View memory store
cat ~/.openclaw/memory.json

# Test web search
openclaw tools invoke web_search --query "Go programming language"

# Test Telegram connection
openclaw plugins test telegram
```

## 🔧 Troubleshooting

### Common Issues & Solutions

#### 1. "OpenClaw is not installed"

```bash
npm install -g openclaw
openclaw --version
```

#### 2. Gateway won't start

```bash
# Check if port 3000 is already in use
lsof -i :3000
# Or kill the process using port 3000
kill -9 <PID>

# Check logs for errors
openclaw gateway logs
```

#### 3. Telegram bot not responding

```bash
# Verify bot token is correct
cat ~/.openclaw/openclaw.json | grep botToken

# Restart gateway
openclaw gateway stop
openclaw gateway start

# Test bot on Telegram
```

#### 4. Skills not loading

```bash
# Verify skill files exist
ls ~/.openclaw/skills/user-onboarding/SKILL.md
ls ~/.openclaw/skills/daily-quiz/SKILL.md

# Check permissions
chmod 644 ~/.openclaw/skills/*/SKILL.md

# Restart gateway to reload skills
```

#### 5. Cron job not running

```bash
# Verify cron job exists
openclaw cron list

# Check timezone
cat ~/.openclaw/openclaw.json | grep timezone

# Test job manually
openclaw cron trigger "nightly-tech-brief"

# View logs at the time the job should run
openclaw gateway logs
```

#### 6. Memory not persisting

```bash
# Check memory file exists and is readable
ls -la ~/.openclaw/memory.json

# Verify memory_store tool is enabled
cat ~/.openclaw/openclaw.json | grep -A5 '"memoryStore"'

# Test memory operations
openclaw memory set "test_key" "test_value"
openclaw memory get "test_key"
```

#### 7. Web search not working

```bash
# Verify DuckDuckGo or other provider works
curl "https://duckduckgo.com/?q=go+programming&format=json"

# Check web search configuration
cat ~/.openclaw/openclaw.json | grep -A5 '"webSearch"'

# Test web search tool
openclaw tools invoke web_search --query "test query"
```

### Logs & Debugging

```bash
# View real-time logs
openclaw gateway logs -f

# Filter logs for errors
openclaw gateway logs | grep ERROR

# Check Telegram plugin logs
openclaw gateway logs | grep telegram

# Enable verbose debugging
DEBUG=openclaw:* openclaw gateway start
```

## 🎯 Advanced Configuration

### Custom LLM Models

To use different models:

```bash
# For Ollama
ollama pull mistral:latest
openclaw config set models.0.model "mistral:latest"

# For OpenAI
openclaw config set models.0.provider "openai"
openclaw config set models.0.model "gpt-4-turbo-preview"
```

### Customizing Skill Behavior

Edit the skill files directly:

```bash
# Edit onboarding skill
nano ~/.openclaw/skills/user-onboarding/SKILL.md

# Edit daily quiz skill
nano ~/.openclaw/skills/daily-quiz/SKILL.md

# Reload skills (restart gateway)
openclaw gateway restart
```

### Adding More Automation

You can create additional standing orders or cron jobs:

```bash
# Send weekly summary
openclaw cron add \
  --name "weekly-summary" \
  --cron "0 18 * * 0" \
  --tz "America/New_York" \
  --message "Generate a weekly learning summary"

# Response to specific keywords
openclaw standing-orders add \
  --name "explain-concept" \
  --if "message contains 'explain'" \
  --run-skill "concept-explainer"
```

### Using Different Web Search Providers

**SearXNG (Self-hosted search engine):**
```json
{
  "tools": {
    "webSearch": {
      "provider": "searxng",
      "config": {
        "url": "https://your-searxng-instance.com",
        "maxResults": 5
      }
    }
  }
}
```

**Google Search:**
```json
{
  "tools": {
    "webSearch": {
      "provider": "google",
      "config": {
        "apiKey": "${env.GOOGLE_API_KEY}",
        "customSearchEngineId": "${env.GOOGLE_CX}",
        "maxResults": 5
      }
    }
  }
}
```

### Persistent Data Management

```bash
# Backup memory
cp ~/.openclaw/memory.json ~/.openclaw/memory.backup.json

# View specific user profile
openclaw memory get "user_profile_USER_ID"

# Update user profile
openclaw memory set "user_profile_USER_ID" '{"domains":["new_domain"],"level":"senior","goals":[],"timezone":"UTC"}'

# Export all memory
openclaw memory export > memory_export.json

# Clear all data (be careful!)
openclaw memory clear
```

## 📁 Project Structure

```
AI_Learning_Assistant_Telegram/
├── skills/
│   ├── user-onboarding/
│   │   └── SKILL.md                 # Onboarding skill definition
│   └── daily-quiz/
│       └── SKILL.md                 # Daily quiz skill definition
├── config/
│   ├── openclaw.json.example        # Example configuration
│   └── setup-config.json            # Setup wizard config
├── scripts/
│   ├── setup.sh                     # Setup script
│   ├── test-skills.sh               # Testing script
│   └── deploy.sh                    # Deployment script
├── Dockerfile                        # Container image definition
├── docker-compose.yml                # Docker Compose orchestration
├── .env.example                      # Environment variables template
├── README.md                         # This file
├── LICENSE                          # Project license
└── .gitignore                       # Git ignore rules
```

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test thoroughly
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Ideas for Contribution

- Additional skills (code review, mock interviews, etc.)
- Support for more LLM providers
- Enhanced memory management
- Improved web search filtering
- Better error handling and recovery
- Additional test coverage
- Documentation improvements

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **OpenClaw**: Open-source personal AI framework
- **OpenAI**, **Anthropic**, **Google**: For amazing LLM providers
- **Ollama**: For making local LLMs accessible
- **Telegram**: For the excellent Bot API

## 📞 Support & Community

- 📖 [OpenClaw Documentation](https://openclaw.dev/docs)
- 💬 [Discussion Forum](https://github.com/openclaw/openclaw/discussions)
- 🐛 [Issue Tracker](https://github.com/yourusername/AI_Learning_Assistant_Telegram/issues)
- 📧 Email: support@example.com

## 🗺️ Roadmap

- [ ] Multi-language support
- [ ] Advanced analytics dashboard
- [ ] Custom skill builder UI
- [ ] Integration with Discord, Slack
- [ ] Mobile app for iOS/Android
- [ ] Advanced prompt optimization
- [ ] Cloud deployment templates
- [ ] Community skill marketplace

---

**Happy learning! 🚀**

*Built with ❤️ using OpenClaw*
