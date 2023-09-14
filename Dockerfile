FROM php:7.4-cli
RUN apt-get update && apt-get install -y zlib1g-dev libpng-dev 
RUN docker-php-ext-install pdo_mysql gd 
WORKDIR /usr/src/laravel-angular2
COPY . . 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer 
RUN composer update --no-interaction --no-cache
RUN composer install --no-interaction --prefer-dist --no-scripts --no-dev --no-progress --no-suggest
CMD [ "php", "/usr/src/laravel-angular2/artisan", "serve", "--host", "0.0.0.0", "--port", "8000" ]
EXPOSE 8000
