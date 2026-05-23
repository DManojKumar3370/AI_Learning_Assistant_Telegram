# Use Node.js LTS as base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install OpenClaw globally
RUN npm install -g openclaw

# Create directories for configuration and skills
RUN mkdir -p /root/.openclaw/skills/user-onboarding
RUN mkdir -p /root/.openclaw/skills/daily-quiz

# Copy skill files
COPY skills/user-onboarding/SKILL.md /root/.openclaw/skills/user-onboarding/SKILL.md
COPY skills/daily-quiz/SKILL.md /root/.openclaw/skills/daily-quiz/SKILL.md

# Copy configuration files
COPY config/openclaw.json /root/.openclaw/openclaw.json
COPY config/.env /root/.openclaw/.env

# Copy entrypoint script
COPY scripts/entrypoint.sh /app/scripts/entrypoint.sh
RUN chmod +x /app/scripts/entrypoint.sh

# Expose the OpenClaw gateway port (default: 3000)
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:3000/health || exit 1

# Set environment variables for OpenClaw
ENV NODE_ENV=production
ENV OPENCLAW_CONFIG_PATH=/root/.openclaw/openclaw.json

# Use entrypoint for initialization
ENTRYPOINT ["/app/scripts/entrypoint.sh"]
