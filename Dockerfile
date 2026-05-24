# මෙතන php 8.3 කලා!
FROM php:8.3-fpm-alpine

RUN apk add --no-cache \
    zip \
    libzip-dev \
    freetype \
    libjpeg-turbo \
    libpng \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    oniguruma-dev \
    bash \
    mysql-client

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql bcmath mbstring zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/webapps/vehicle_booking

COPY . .

RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist

RUN chown -R www-data:www-data /var/webapps/vehicle_booking \
    && chmod -R 775 /var/webapps/vehicle_booking/storage \
    && chmod -R 775 /var/webapps/vehicle_booking/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]