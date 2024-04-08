FROM regitcars/php-fpm:8.1-rc-ci

COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

RUN apk --no-cache --update add \
    linux-headers

RUN /usr/local/bin/pickle/bin/pickle install xdebug
RUN docker-php-ext-enable xdebug
