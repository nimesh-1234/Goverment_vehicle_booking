# ==========================================
# Stage 1: Composer Dependencies (PHP)
# ==========================================
FROM composer:2 AS vendor
WORKDIR /app

COPY . .
RUN composer install --no-dev --optimize-autoloader --no-interaction

# ==========================================
# Stage 2: Build Frontend Assets (Node.js)
# ==========================================
FROM node:22-alpine AS frontend
WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm install

COPY . .
COPY --from=vendor /app/vendor ./vendor
RUN npm run build

# ==========================================
# Stage 3: Production PHP-FPM Server (App)
# ==========================================
FROM php:8.3-fpm-alpine AS app_base

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

# මුළු Laravel කෝඩ් එකම සර්වර් එකට Copy කිරීම
COPY . .

# කලින් ස්ටේජ් වලින් Vendor සහ Build ෆයිල් ටික ඇදලා ගැනීම
COPY --from=vendor /app/vendor ./vendor
COPY --from=frontend /app/public/build ./public/build

# Permissions සැකසීම
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 775 /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]

# ==========================================
# Stage 4: Production Nginx Server (Web)
# ==========================================
FROM nginx:alpine AS web

WORKDIR /var/www

# 🚨 Stage 3 එකේ පිරිසිදුවට හැදුණු මුළු ප්‍රොජෙක්ට් කෝඩ් එකම Nginx එක ඇතුළටත් කොපි කරනවා!
COPY --from=app_base /var/www /var/www