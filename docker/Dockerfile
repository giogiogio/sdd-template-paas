# Dockerfile - Production Build
# Used by PaaS platforms (Railway, Render, Fly.io)

FROM dunglas/frankenphp:latest-php8.4-alpine

# Install PHP extensions
RUN install-php-extensions \
    pdo_pgsql \
    intl \
    opcache \
    zip \
    apcu \
    redis

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy composer files first (better caching)
COPY composer.json composer.lock ./

# Install dependencies
RUN composer install --no-dev --no-scripts --no-autoloader --prefer-dist

# Copy application code
COPY . .

# Generate optimized autoloader
RUN composer dump-autoload --optimize --no-dev

# Set permissions
RUN chown -R www-data:www-data /app/var || true

# Environment
ENV APP_ENV=prod
ENV FRANKENPHP_CONFIG="worker ./public/index.php"

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Expose port
EXPOSE 8000

# Start FrankenPHP
CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
