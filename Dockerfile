    # 📦 Image de base PHP CLI pour Artisan Serve
    FROM php:8.2-cli

    # 🧰 Installation des dépendances système
    RUN apt-get update && apt-get install -y \
        git \
        curl \
        zip \
        unzip \
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
        && docker-php-ext-install \
            pdo \
            pdo_pgsql \
            zip \
            mbstring \
            exif \
            pcntl \
            intl
    
    # 🧰 Installer Composer
    COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
    
    # 🔧 Installer Node.js (optionnel si tu utilises Vite)
    RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
        apt-get install -y nodejs=20.* --allow-downgrades
    
    # 📁 Répertoire de travail
    WORKDIR /var/www
    
    # 📦 Copier le code
    COPY . .
    
    # 🧱 Installer les dépendances Laravel
    RUN composer install --no-interaction --prefer-dist --optimize-autoloader
    RUN npm install && npm run build
    
    
    # 🔐 Donner les bons droits
    RUN chown -R www-data:www-data /var/www && \
        chmod -R 755 /var/www/storage
    
    # 🚀 Commande de démarrage
    CMD sh -c "php artisan migrate --force || echo 'Migration failed' && php artisan serve --host=0.0.0.0 --port=8000"
    
    