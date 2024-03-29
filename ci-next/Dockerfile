FROM php:8.1-rc-fpm-alpine

# install packages and build tools
RUN apk --no-cache --update add \
    gcc musl-dev make curl bash openssl openssl-dev autoconf shadow \
    freetype-dev libjpeg-turbo-dev libpng-dev libwebp-dev curl libxml2-dev libmemcached-dev icu-dev g++ \
    libzip libzip-dev libssl3 libcrypto3 oniguruma oniguruma-dev libgcrypt-dev libxslt-dev \
    gettext-dev gmp-dev imap-dev unzip git

RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install soap
RUN docker-php-ext-install zip
RUN docker-php-ext-install imap
RUN docker-php-ext-install opcache
RUN docker-php-ext-install calendar
RUN docker-php-ext-install sockets
RUN docker-php-ext-install exif
RUN docker-php-ext-install gettext
RUN docker-php-ext-install gmp
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install intl
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install xsl
RUN docker-php-ext-install mbstring
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-install gd
RUN docker-php-ext-enable imap


COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

# install composer
RUN curl -L -o /usr/local/bin/composer https://getcomposer.org/composer-stable.phar  \
    && chmod a+rx /usr/local/bin/composer

ENV PATH="/usr/local/bin:/composer/vendor/bin:${PATH}"
RUN mkdir /composer
ENV COMPOSER_HOME="/composer"
RUN composer global require pdepend/pdepend edgedesign/phpqa php-parallel-lint/php-parallel-lint \
 consolidation/robo:^2.0 --no-interaction


RUN curl -L -o /usr/local/bin/php-cs-fixer https://cs.symfony.com/download/php-cs-fixer-v3.phar
RUN curl -L -o /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-10.phar
RUN curl -L -o /usr/local/bin/phploc https://phar.phpunit.de/phploc.phar
RUN curl -L -o /usr/local/bin/phpmd https://phpmd.org/static/latest/phpmd.phar
RUN curl -L -o /usr/local/bin/phpcpd https://phar.phpunit.de/phpcpd.phar
RUN curl -L -o /usr/local/bin/psalm https://github.com/vimeo/psalm/releases/download/4.10.0/psalm.phar

RUN chmod +x /usr/local/bin/php-cs-fixer
RUN chmod +x /usr/local/bin/phpunit
RUN chmod +x /usr/local/bin/phploc
RUN chmod +x /usr/local/bin/phpmd
RUN chmod +x /usr/local/bin/phpcpd
RUN chmod +x /usr/local/bin/psalm

COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini


RUN git clone https://github.com/FriendsOfPHP/pickle.git /usr/local/bin/pickle
RUN cd /usr/local/bin/pickle && composer install --ignore-platform-reqs

RUN /usr/local/bin/pickle/bin/pickle install memcached
RUN docker-php-ext-enable memcached

RUN chmod -R 0777 /composer/cache

WORKDIR /var/www/app

EXPOSE 9000

CMD php-fpm
