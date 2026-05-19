# Stage 1: Build Node.js assets
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies (Changed to npm install to fix the lockfile error)
RUN npm install

# Copy the rest of the application
COPY . .

# Build Vite assets
RUN npm run build

# Stage 2: Build PHP application
FROM php:8.2-fpm-alpine

# Install system dependencies
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

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql bcmath mbstring zip

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory (Must match nginx.conf and docker-compose.yml)
WORKDIR /var/webapps/vehicle_booking

# Copy existing application directory contents
COPY . .

# Copy compiled assets from Stage 1
COPY --from=build /app/public/build ./public/build

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist

# Set permissions for Laravel
RUN chown -R www-data:www-data /var/webapps/vehicle_booking \
    && chmod -R 775 /var/webapps/vehicle_booking/storage \
    && chmod -R 775 /var/webapps/vehicle_booking/bootstrap/cache

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]