# SDD Template (PaaS Edition)

> **Spec-Driven Development** template ottimizzato per deployment su Platform as a Service.

## Supported PaaS

| Platform | Status | Notes |
|----------|--------|-------|
| **Railway** | ✅ Recommended | Best DX, easy setup |
| **Render** | ✅ Supported | Good free tier |
| **Fly.io** | ✅ Supported | Global edge deployment |
| **Platform.sh** | ✅ Supported | Symfony-native |

## Quick Start

```bash
# 1. Clone this template
git clone https://github.com/YOUR_USER/sdd-template-paas.git my-project
cd my-project

# 2. Remove template history and init
rm -rf .git
git init
git add .
git commit -m "chore: init from sdd-template-paas"

# 3. Configure
cp .env.example .env
# Edit _bmad/bmm/config.yaml with your project name

# 4. Local development
make dev-up        # Start local Docker stack
# or
make prototype-up  # Minimal stack for prototyping

# 5. Start developing
claude
/start-feature
```

## Project Structure

```
├── _bmad/                    # BMAD Framework + Custom Workflows
├── _bmad-output/             # Generated artifacts (gitignored)
├── .claude/commands/         # Claude Code custom commands
├── docs/                     # Constitution + Changelog
├── docker/                   # Local development only
├── backend/                  # API (Hexagonal Architecture)
├── frontend/                 # React + TypeScript
├── prototype/                # Symfony + HTMX (validation)
└── railway.json / render.yaml # PaaS config
```

## Two Modes

| Mode | Command | Stack | When |
|------|---------|-------|------|
| **Prototype** | `/prototype` | Symfony + HTMX | Validate idea fast |
| **Production** | `/production` | API Platform + React | Scalable build |

## Deploy to PaaS

### Railway (Recommended)

```bash
# 1. Install Railway CLI
npm install -g @railway/cli

# 2. Login and init
railway login
railway init

# 3. Add services
railway add --database postgres
railway add --database redis

# 4. Deploy
railway up

# 5. Set environment variables in Railway dashboard
```

### Render

```bash
# 1. Push to GitHub
git remote add origin https://github.com/YOU/my-project.git
git push -u origin main

# 2. Connect repo in Render dashboard
# 3. Render auto-detects render.yaml and creates services
```

### Fly.io

```bash
# 1. Install Fly CLI
curl -L https://fly.io/install.sh | sh

# 2. Login and launch
fly auth login
fly launch

# 3. Add managed Postgres
fly postgres create
fly postgres attach

# 4. Deploy
fly deploy
```

## Local Development Commands

```bash
# Docker
make dev-up          # Start full stack (API + Frontend + DB + Redis)
make dev-down        # Stop stack
make dev-logs        # View logs
make dev-shell       # Shell into app container

# Prototype mode
make prototype-up    # Minimal stack (Symfony + DB only)
make prototype-down

# Testing
make test            # Run all tests
make test-unit       # Unit tests only
make quality         # Linting + Static analysis

# Database
make db-migrate      # Run migrations
make db-reset        # Reset database
```

## Claude Code Commands

- `/start-feature` - Start new feature (asks mode)
- `/prototype` - Start prototype mode
- `/production` - Start production mode
- `/promote` - Promote prototype → production
- `/feature-status` - Show current status

## Documentation

- [Constitution](docs/constitution.md) - Architectural rules
- [Changelog](docs/CHANGELOG.md) - Version history
- [PaaS Deploy Guide](docs/paas-deploy.md) - Detailed deploy instructions

## Requirements

**Local Development:**
- Docker + Docker Compose
- Claude Code CLI
- Node.js 22+

**PaaS Deployment:**
- Git repository (GitHub/GitLab)
- PaaS account (Railway/Render/Fly.io)

## License

MIT
