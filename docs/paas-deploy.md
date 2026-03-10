# PaaS Deployment Guide

Guida dettagliata per il deploy su Platform as a Service.

---

## Overview

Con PaaS, il deploy è semplificato:
- **Push to Git** → Auto-deploy
- **Database managed** → No backup manuale
- **SSL automatico** → No configurazione
- **Scaling automatico** → No infrastruttura

---

## Railway (Recommended)

### Perché Railway

- Developer experience eccellente
- Deploy in 2 minuti
- Managed PostgreSQL + Redis inclusi
- Preview environments automatici
- Prezzo ragionevole ($5/mese per hobby)

### Setup Iniziale

```bash
# 1. Installa CLI
npm install -g @railway/cli

# 2. Login
railway login

# 3. Vai nel progetto
cd my-project

# 4. Inizializza Railway
railway init
# Seleziona "Empty Project"

# 5. Linka il progetto
railway link
```

### Aggiungi Servizi

```bash
# PostgreSQL
railway add
# Seleziona: Database → PostgreSQL

# Redis
railway add
# Seleziona: Database → Redis
```

### Configura Backend

```bash
# Crea servizio per backend
railway service create backend

# Configura
railway service update backend \
  --root-directory backend \
  --build-command "composer install --no-dev --optimize-autoloader" \
  --start-command "php bin/console doctrine:migrations:migrate --no-interaction && frankenphp run"
```

### Configura Frontend

```bash
# Crea servizio per frontend
railway service create frontend

# Configura
railway service update frontend \
  --root-directory frontend \
  --build-command "npm ci && npm run build" \
  --start-command "npm run preview"
```

### Environment Variables

Nel dashboard Railway, aggiungi:

```bash
# Backend
APP_ENV=prod
APP_DEBUG=0
APP_SECRET=<genera-con-openssl-rand-hex-32>
DATABASE_URL=${{Postgres.DATABASE_URL}}
REDIS_URL=${{Redis.REDIS_URL}}
CORS_ALLOW_ORIGIN=^https://.*\.up\.railway\.app$

# Frontend
VITE_API_URL=https://backend-xxx.up.railway.app
```

### Deploy

```bash
# Deploy manuale
railway up

# Oppure push to GitHub (auto-deploy)
git push origin main
```

### Custom Domain

```bash
railway domain add api.myproject.com --service backend
railway domain add myproject.com --service frontend
```

---

## Render

### Setup

1. **Push to GitHub** il tuo progetto

2. **Connetti repo** nel dashboard Render

3. Render legge `render.yaml` e crea i servizi automaticamente

### render.yaml

```yaml
# render.yaml
services:
  # Backend API
  - type: web
    name: api
    runtime: docker
    dockerfilePath: ./docker/production/Dockerfile
    dockerContext: ./backend
    envVars:
      - key: APP_ENV
        value: prod
      - key: APP_DEBUG
        value: "0"
      - key: APP_SECRET
        generateValue: true
      - key: DATABASE_URL
        fromDatabase:
          name: db
          property: connectionString
      - key: REDIS_URL
        fromService:
          name: redis
          type: redis
          property: connectionString
    healthCheckPath: /health
    autoDeploy: true

  # Frontend
  - type: web
    name: frontend
    runtime: static
    buildCommand: cd frontend && npm ci && npm run build
    staticPublishPath: ./frontend/dist
    envVars:
      - key: VITE_API_URL
        fromService:
          name: api
          type: web
          property: host
    headers:
      - path: /*
        name: Cache-Control
        value: public, max-age=31536000
    routes:
      - type: rewrite
        source: /*
        destination: /index.html

  # Worker (Symfony Messenger)
  - type: worker
    name: worker
    runtime: docker
    dockerfilePath: ./docker/production/Dockerfile.worker
    dockerContext: ./backend
    envVars:
      - key: APP_ENV
        value: prod
      - key: DATABASE_URL
        fromDatabase:
          name: db
          property: connectionString
      - key: REDIS_URL
        fromService:
          name: redis
          type: redis
          property: connectionString

databases:
  - name: db
    plan: starter
    databaseName: app
    user: app

  - name: redis
    plan: starter
```

### Deploy

```bash
# Push e Render deploya automaticamente
git push origin main
```

---

## Fly.io

### Setup

```bash
# Installa CLI
curl -L https://fly.io/install.sh | sh

# Login
fly auth login

# Inizializza (nella root del progetto)
fly launch
# Rispondi alle domande:
# - App name: my-project-api
# - Region: fra (Frankfurt) per EU
# - PostgreSQL: Yes
# - Redis: Yes
```

### fly.toml (Backend)

```toml
# fly.toml
app = "my-project-api"
primary_region = "fra"

[build]
  dockerfile = "docker/production/Dockerfile"

[env]
  APP_ENV = "prod"
  APP_DEBUG = "0"

[http_service]
  internal_port = 8000
  force_https = true
  auto_stop_machines = true
  auto_start_machines = true
  min_machines_running = 1

[[services]]
  protocol = "tcp"
  internal_port = 8000

  [[services.ports]]
    port = 80
    handlers = ["http"]

  [[services.ports]]
    port = 443
    handlers = ["tls", "http"]

  [[services.http_checks]]
    interval = "10s"
    timeout = "2s"
    path = "/health"
```

### Database

```bash
# Crea PostgreSQL
fly postgres create --name my-project-db

# Attach al progetto
fly postgres attach my-project-db

# Fly setta automaticamente DATABASE_URL
```

### Secrets

```bash
fly secrets set APP_SECRET=$(openssl rand -hex 32)
fly secrets set REDIS_URL=redis://...
```

### Deploy

```bash
fly deploy
```

### Frontend (su Fly o Cloudflare Pages)

Per il frontend, consiglio **Cloudflare Pages**:

```bash
# Installa Wrangler
npm install -g wrangler

# Login
wrangler login

# Deploy
cd frontend
npm run build
wrangler pages deploy dist --project-name=my-project
```

---

## Platform.sh (Symfony Native)

Se vuoi supporto Symfony nativo:

### .platform.app.yaml

```yaml
name: api
type: php:8.4

build:
  flavor: composer

dependencies:
  php:
    composer/composer: "^2"

relationships:
  database: "db:postgresql"
  redis: "cache:redis"

web:
  locations:
    "/":
      root: "public"
      passthru: "/index.php"

mounts:
  "/var": { source: local, source_path: var }

hooks:
  build: |
    set -e
    composer install --no-dev --optimize-autoloader
  deploy: |
    set -e
    php bin/console doctrine:migrations:migrate --no-interaction
    php bin/console cache:clear
```

### .platform/services.yaml

```yaml
db:
  type: postgresql:16
  disk: 1024

cache:
  type: redis:7.0
```

---

## CI/CD Semplificato per PaaS

Con PaaS, il workflow CI/CD si semplifica:

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:18
        env:
          POSTGRES_USER: test
          POSTGRES_PASSWORD: test
          POSTGRES_DB: test_db
        ports:
          - 5432:5432
        options: --health-cmd pg_isready --health-interval 10s --health-timeout 5s --health-retries 5

    steps:
      - uses: actions/checkout@v4

      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: '8.4'
          extensions: pdo_pgsql, redis, intl

      - name: Install dependencies
        working-directory: backend
        run: composer install

      - name: Run tests
        working-directory: backend
        run: composer test
        env:
          DATABASE_URL: postgresql://test:test@localhost:5432/test_db

      - name: Run quality checks
        working-directory: backend
        run: composer quality

  # NO deploy job needed - PaaS auto-deploys on push!
```

---

## Checklist Pre-Deploy PaaS

```
[ ] Tutti i test passano in CI
[ ] .env.example documentato
[ ] Health check endpoint (/health)
[ ] Migrations funzionano
[ ] CORS configurato per dominio PaaS
[ ] Secrets configurati nel PaaS dashboard
[ ] DNS configurato (se custom domain)
```

---

## Costi Stimati

| PaaS | Hobby/Dev | Production |
|------|-----------|------------|
| Railway | $5/mese | $20+/mese |
| Render | Free tier | $7+/mese |
| Fly.io | Free tier | $5+/mese |
| Platform.sh | N/A | $10+/mese |

**Incluso:**
- App hosting
- Managed PostgreSQL
- Managed Redis
- SSL automatico
- Auto-scaling base
