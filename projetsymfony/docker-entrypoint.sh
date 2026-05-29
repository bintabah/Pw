#!/bin/bash
set -e

echo "Waiting for MySQL to be ready..."
until php bin/console doctrine:query:sql "SELECT 1" > /dev/null 2>&1; do
    sleep 2
done

echo "Running Doctrine migrations..."
php bin/console doctrine:migrations:migrate --no-interaction --allow-no-migration

echo "Starting Apache..."
exec apache2-foreground
