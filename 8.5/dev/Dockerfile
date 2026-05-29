FROM regitcars/php:8.5-fpm-ci

COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

RUN pecl install xdebug-3.5.1 \
    && docker-php-ext-enable xdebug
