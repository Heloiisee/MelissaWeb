# Étape 1 : base PHP avec extensions nécessaires
FROM php:8.2-cli

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    zip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libicu-dev \
    libpq-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    ghostscript \
    poppler-utils \
    wkhtmltopdf \
    nodejs \
    npm \
    && docker-php-ext-install \
        pdo \
        pdo_pgsql \
        zip \
        mbstring \
        exif \
        pcntl \
        intl

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Créer un dossier de travail
WORKDIR /var/www

# Copier tout le code
COPY . .

# Installer les dépendances PHP
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Installer les dépendances JS et builder les assets Vite
RUN npm install && npm run build

# Fixer les permissions
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www/storage

# Commande de lancement Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
