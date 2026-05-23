@echo off
REM Setup script for Windows users
REM OpenClaw Telegram Learning Assistant

setlocal enabledelayedexpansion

cls
echo ======================================
echo OpenClaw Learning Assistant Setup
echo ======================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js is not installed!
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo [OK] Node.js %NODE_VERSION% found
echo.

REM Check if OpenClaw is installed
openclaw --version >nul 2>&1
if errorlevel 1 (
    echo [INFO] OpenClaw is not installed globally
    echo Installing OpenClaw...
    call npm install -g openclaw
    if errorlevel 1 (
        echo [ERROR] Failed to install OpenClaw
        pause
        exit /b 1
    )
)

for /f "tokens=*" %%i in ('openclaw --version') do set OPENCLAW_VERSION=%%i
echo [OK] OpenClaw %OPENCLAW_VERSION% found
echo.

REM Create directories
echo Creating OpenClaw directories...
if not exist "%USERPROFILE%\.openclaw" mkdir "%USERPROFILE%\.openclaw"
if not exist "%USERPROFILE%\.openclaw\skills\user-onboarding" mkdir "%USERPROFILE%\.openclaw\skills\user-onboarding"
if not exist "%USERPROFILE%\.openclaw\skills\daily-quiz" mkdir "%USERPROFILE%\.openclaw\skills\daily-quiz"
if not exist "%USERPROFILE%\.openclaw\logs" mkdir "%USERPROFILE%\.openclaw\logs"

echo [OK] Directories created
echo.

echo ======================================
echo Pre-Configuration Checklist
echo ======================================
echo.
echo Before running 'openclaw onboard', ensure:
echo.
echo 1. LLM Setup:
echo    - Option A (Recommended): Ollama installed and running
echo      Download from https://ollama.ai
echo      Command: ollama pull llama3:8b
echo      Command: ollama serve
echo    - Option B: Cloud API key ready (OpenAI, Anthropic, Google)
echo.
echo 2. Telegram Bot Setup:
echo    - Open Telegram and search for @BotFather
echo    - Send /newbot command
echo    - Create a new bot and save the token
echo.
echo 3. Web Search (Optional):
echo    - DuckDuckGo: No setup needed (recommended)
echo    - SearXNG: Provide instance URL
echo    - Google: Provide API key and Custom Search Engine ID
echo.
echo ======================================
echo.
echo Next steps:
echo.
echo 1. Run OpenClaw onboarding:
echo    openclaw onboard
echo.
echo 2. Start the gateway (in a new terminal):
echo    openclaw gateway start
echo.
echo 3. Test the bot on Telegram
echo.
echo 4. Set up automation:
echo.
echo    # Trigger onboarding for new users:
echo    openclaw standing-orders add ^
echo      --name "trigger-user-onboarding" ^
echo      --if "memory.user_profile_{{user.id}} does not exist" ^
echo      --run-skill "user-onboarding"
echo.
echo    # Schedule daily quiz:
echo    openclaw cron add ^
echo      --name "nightly-tech-brief" ^
echo      --cron "0 21 * * *" ^
echo      --tz "America/New_York" ^
echo      --session isolated ^
echo      --message "Run the daily-quiz skill..." ^
echo      --announce ^
echo      --channel telegram
echo.
echo [OK] Setup check complete!
echo.
pause
