FROM regitcars/php:8.4-fpm-ci

COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

RUN pecl install xdebug-3.4.5 \
    && docker-php-ext-enable xdebug
