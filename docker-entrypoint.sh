#!/bin/bash

if [ -f composer.json ]; then
    echo "Installing Composer dependencies..."
    composer update
    composer install
fi

if [ -f package.json ]; then
    echo "Installing NPM dependencies..."
    npm install
    npm run build
fi

if [ -f artisan ]; then
    echo "Running Artisan commands..."
    php artisan key:generate
    php artisan migrate:fresh —seed
fi

exec "$@"
