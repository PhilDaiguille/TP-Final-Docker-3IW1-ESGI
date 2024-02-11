#!/bin/bash

composer self-update

composer update --no-interaction --optimize-autoloader && \
composer install --no-interaction --prefer-dist --no-dev

php artisan key:generate
php artisan migrate:fresh --seed

npm install
npm run build

php-fpm