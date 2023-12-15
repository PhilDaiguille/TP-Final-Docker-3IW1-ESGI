FROM php:8.2-fpm

WORKDIR /var/www

COPY . .

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libzip-dev \
    curl \
    && docker-php-ext-install pdo pdo_mysql zip \
    && curl -fsSL https://deb.nodesource.com/setup_current.x | bash - \
    && apt-get install -y nodejs

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

COPY --chown=www:www . /var/www

#COPY docker-entrypoint.sh .
#RUN chmod +x docker-entrypoint.sh

ENV COMPOSER_ALLOW_SUPERUSER=1

##RUN composer update \
##    && composer install \
##    && npm install \
##    && npm run build \
##    && php artisan key:generate
## && php artisan migrate:fresh --seed

USER www

EXPOSE 9000

CMD ["php-fpm"]

