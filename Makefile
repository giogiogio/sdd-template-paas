# Makefile - SDD Template (PaaS Edition)
# Docker is for LOCAL DEVELOPMENT only - PaaS handles production

.PHONY: help dev-up dev-down dev-logs dev-shell prototype-up prototype-down test quality db-migrate db-reset

# Default
help:
	@echo "SDD Template - PaaS Edition"
	@echo ""
	@echo "Local Development:"
	@echo "  dev-up          Start full stack (API + Frontend + DB + Redis)"
	@echo "  dev-down        Stop full stack"
	@echo "  dev-logs        View logs"
	@echo "  dev-shell       Shell into app container"
	@echo "  dev-tools       Start with Adminer + Mailpit"
	@echo ""
	@echo "Prototype Mode:"
	@echo "  prototype-up    Start minimal stack (Symfony + DB only)"
	@echo "  prototype-down  Stop prototype stack"
	@echo ""
	@echo "Testing:"
	@echo "  test            Run all tests"
	@echo "  test-unit       Run unit tests"
	@echo "  test-e2e        Run E2E tests"
	@echo "  quality         Run CS-Fixer + PHPStan"
	@echo ""
	@echo "Database:"
	@echo "  db-migrate      Run migrations"
	@echo "  db-diff         Generate migration diff"
	@echo "  db-reset        Reset database"
	@echo ""
	@echo "PaaS Deploy:"
	@echo "  deploy-railway  Deploy to Railway"
	@echo "  deploy-fly      Deploy to Fly.io"

# ===========================================
# LOCAL DEVELOPMENT (Full Stack)
# ===========================================
dev-up:
	cd docker/dev && docker compose up -d

dev-down:
	cd docker/dev && docker compose down

dev-logs:
	cd docker/dev && docker compose logs -f

dev-shell:
	cd docker/dev && docker compose exec app sh

dev-tools:
	cd docker/dev && docker compose --profile tools up -d

dev-restart:
	cd docker/dev && docker compose restart app

# ===========================================
# PROTOTYPE MODE (Minimal Stack)
# ===========================================
prototype-up:
	cd docker/prototype && docker compose up -d

prototype-down:
	cd docker/prototype && docker compose down

prototype-logs:
	cd docker/prototype && docker compose logs -f

prototype-shell:
	cd docker/prototype && docker compose exec app sh

# ===========================================
# TESTING
# ===========================================
test:
	cd docker/dev && docker compose exec app composer test

test-unit:
	cd docker/dev && docker compose exec app composer test:unit

test-integration:
	cd docker/dev && docker compose exec app composer test:integration

test-e2e:
	cd frontend && npm run test:e2e

# ===========================================
# QUALITY
# ===========================================
quality:
	cd docker/dev && docker compose exec app composer quality

cs-fix:
	cd docker/dev && docker compose exec app composer cs-fix

phpstan:
	cd docker/dev && docker compose exec app composer phpstan

lint:
	cd frontend && npm run lint

# ===========================================
# DATABASE
# ===========================================
db-migrate:
	cd docker/dev && docker compose exec app php bin/console doctrine:migrations:migrate --no-interaction

db-diff:
	cd docker/dev && docker compose exec app php bin/console doctrine:migrations:diff

db-reset:
	cd docker/dev && docker compose exec app php bin/console doctrine:database:drop --force --if-exists
	cd docker/dev && docker compose exec app php bin/console doctrine:database:create
	cd docker/dev && docker compose exec app php bin/console doctrine:migrations:migrate --no-interaction

# ===========================================
# MESSENGER (Background Jobs)
# ===========================================
messenger-consume:
	cd docker/dev && docker compose exec app php bin/console messenger:consume async -vv

messenger-failed:
	cd docker/dev && docker compose exec app php bin/console messenger:failed:show

# ===========================================
# CACHE
# ===========================================
cache-clear:
	cd docker/dev && docker compose exec app php bin/console cache:clear

# ===========================================
# PAAS DEPLOY
# ===========================================
deploy-railway:
	@echo "Railway auto-deploys on push to main."
	@echo "For manual deploy: railway up"
	@command -v railway >/dev/null 2>&1 && railway up || echo "Install Railway CLI: npm i -g @railway/cli"

deploy-fly:
	@echo "Deploying to Fly.io..."
	@command -v flyctl >/dev/null 2>&1 && cd backend && flyctl deploy || echo "Install Fly CLI: curl -L https://fly.io/install.sh | sh"

deploy-render:
	@echo "Render auto-deploys on push to main."
	@echo "Connect your repo at: https://dashboard.render.com"

# ===========================================
# SETUP
# ===========================================
setup:
	cp .env.example .env
	cd docker/dev && docker compose build
	@echo ""
	@echo "Setup complete! Run: make dev-up"

install-deps:
	cd docker/dev && docker compose exec app composer install
	cd frontend && npm install
