FROM php:7.3.15-fpm-alpine

RUN apk upgrade --update

# lib dependencies
RUN apk add --no-cache git jpeg-dev libpng-dev freetype-dev libxslt-dev icu-dev libzip-dev $PHPIZE_DEPS

# install extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd bcmath xsl intl pdo pdo_mysql soap zip \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Prestissimo
RUN composer global require hirak/prestissimo
