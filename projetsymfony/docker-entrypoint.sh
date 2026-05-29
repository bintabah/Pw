#!/bin/bash
set -e

echo "Fixing cache/log permissions..."
mkdir -p /var/www/html/var/cache/prod /var/www/html/var/log
chown -R www-data:www-data /var/www/html/var/
chmod -R 775 /var/www/html/var/

echo "Warming up Symfony cache..."
sudo -u www-data php bin/console cache:warmup --env=prod 2>/dev/null || php bin/console cache:warmup --env=prod

echo "Waiting for MariaDB to be ready..."
MAX_RETRIES=30
RETRIES=0
until php bin/console doctrine:query:sql "SELECT 1" > /dev/null 2>&1; do
    RETRIES=$((RETRIES + 1))
    if [ $RETRIES -ge $MAX_RETRIES ]; then
        echo "Database not available after ${MAX_RETRIES} retries, starting anyway..."
        break
    fi
    echo "Waiting... ($RETRIES/$MAX_RETRIES)"
    sleep 3
done

echo "Running Doctrine migrations..."
php bin/console doctrine:migrations:migrate --no-interaction --allow-no-migration 2>/dev/null || echo "Migrations skipped"

echo "Starting Apache..."
exec apache2-foreground
