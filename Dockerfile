# ==========================================
# Stage 1: Build Frontend Assets (Node.js)
# ==========================================
FROM node:22-alpine AS frontend

WORKDIR /app

# Package files ටික දාලා npm install කරනවා
COPY package.json package-lock.json* ./
RUN npm install

# මුළු කෝඩ් එකම දාලා Production එකට Build කරනවා
COPY . .
RUN npm run build

# ==========================================
# Stage 2: Production PHP-FPM Server
# ==========================================
FROM php:8.3-fpm-alpine

# PHP Extensions සහ අවශ්‍ය අමතර දේවල් Install කිරීම
RUN apk add --no-cache \
    linux-headers \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zip \
    libzip-dev \
    unzip \
    curl \
    mariadb-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql bcmath gd zip

# Composer දාගැනීම
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Laravel කෝඩ් එක සර්වර් එකට Copy කිරීම
COPY . .

# අර Stage 1 එකේ හැදුව Frontend Build ෆයිල් ටික මෙතනට Copy කරගැනීම
COPY --from=frontend /app/public/build ./public/build

# Development ටූල්ස් නැතුව Production එකට විතරක් Composer Install කිරීම
RUN composer install --no-dev --optimize-autoloader --no-interaction

# සර්වර් එකට ඕනේ කරන Permissions හැදීම
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 775 /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]