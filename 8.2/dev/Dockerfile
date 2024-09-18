FROM regitcars/php:8.2-fpm-ci

COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

RUN wget https://github.com/FriendsOfPHP/pickle/releases/latest/download/pickle.phar -O /usr/local/bin/pickle \
  && chmod +x /usr/local/bin/pickle

RUN /usr/local/bin/pickle install xdebug
RUN docker-php-ext-enable xdebug
