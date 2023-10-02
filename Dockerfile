FROM php:7.2-apache
COPY . /var/www/html/
RUN apt-get update && apt-get install -y \
    libpng-dev \
    zlib1g-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \
    zip \
  && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd \
  && pecl install redis \
  && docker-php-ext-enable redis \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && composer install --no-interaction \
  && chown -R www-data:www-data /var/www \
  && chmod -R 777 storage
COPY .env.example .env
RUN php artisan key:generate
EXPOSE 80
CMD ['apache2-foreground']