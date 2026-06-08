# ==========================================
# Stage 1: Composer Dependencies (PHP)
# ==========================================
FROM composer:2 AS vendor
WORKDIR /app

# මුළු කෝඩ් එකම Copy කරලා Composer Install කරනවා
COPY . .
RUN composer install --no-dev --optimize-autoloader --no-interaction

# ==========================================
# Stage 2: Build Frontend Assets (Node.js)
# ==========================================
FROM node:22-alpine AS frontend
WORKDIR /app

# Package files ටික දාලා npm install කරනවා
COPY package.json package-lock.json* ./
RUN npm install

# මුළු කෝඩ් එකම Copy කරනවා
COPY . .

# **මෙන්න විසඳුම!** Stage 1 එකෙන් හැදුණු vendor ෆෝල්ඩර් එක මෙතනට Copy කරගන්නවා
COPY --from=vendor /app/vendor ./vendor

# දැන් බය නැතුව Production එකට Build කරනවා (දැන් Ziggy හොයාගන්න පුළුවන්)
RUN npm run build

# ==========================================
# Stage 3: Production PHP-FPM Server
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

WORKDIR /var/www

# Laravel කෝඩ් එක සර්වර් එකට Copy කිරීම
COPY . .

# Stage 1 එකෙන් vendor ෆෝල්ඩර් එක Copy කරගැනීම
COPY --from=vendor /app/vendor ./vendor

# Stage 2 එකෙන් Frontend Build ෆයිල් ටික Copy කරගැනීම
COPY --from=frontend /app/public/build ./public/build

# සර්වර් එකට ඕනේ කරන Permissions හැදීම
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 775 /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]