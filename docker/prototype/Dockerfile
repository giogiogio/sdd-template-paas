# Dockerfile - Prototype (FrankenPHP)
FROM dunglas/frankenphp:latest-php8.4-alpine

# Install PHP extensions
RUN install-php-extensions \
    pdo_pgsql \
    intl \
    opcache \
    zip \
    apcu

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Symfony environment
ENV APP_ENV=dev
ENV FRANKENPHP_CONFIG="worker ./public/index.php"

# Expose port
EXPOSE 8000

# Start FrankenPHP
CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
