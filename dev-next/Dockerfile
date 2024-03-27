FROM regitcars/php-fpm:ci-next

COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

RUN apk --no-cache --update add \
    linux-headers

RUN /usr/local/bin/pickle/bin/pickle install xdebug
RUN docker-php-ext-enable xdebug
