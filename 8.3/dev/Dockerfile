FROM regitcars/php:8.3-fpm-ci

COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

RUN /usr/local/bin/pickle install xdebug
RUN docker-php-ext-enable xdebug
