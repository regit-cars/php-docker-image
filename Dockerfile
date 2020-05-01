FROM php:7.4-fpm-alpine

RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

RUN apk update

# install packages and build tools
RUN apk --no-cache add \
    gcc musl-dev make curl bash openssl openssl-dev autoconf shadow \
    freetype-dev libjpeg-turbo-dev libpng-dev curl libxml2-dev libmemcached-dev icu-dev g++ \
    libzip libzip-dev libressl3.0-libcrypto oniguruma oniguruma-dev libgcrypt-dev libxslt-dev \
    gettext-dev gmp-dev imap-dev unzip git

# If you use Alpine, you need to set this value to "alpine"
ENV current_os=alpine
RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/$current_os/amd64/$version \
    && mkdir -p /tmp/blackfire \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire \
    && mv /tmp/blackfire/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini \
    && rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz
# Please note that the Blackfire Probe is dependent on the session module.
# If it isn't present in your install, you will need # to enable it yourself.

RUN pecl install memcached \
    && pecl install xdebug \
    && rm -rf /tmp/pear

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
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-enable xdebug memcached imap


COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

# install composer
RUN curl -L -o /usr/local/bin/composer https://getcomposer.org/composer-stable.phar  \
    && chmod a+rx /usr/local/bin/composer

ENV PATH="/usr/local/bin:/composer/vendor/bin:${PATH}"
RUN mkdir /composer
ENV COMPOSER_HOME="/composer"
RUN composer global require behat/behat behat/mink behat/mink-extension behat/mink-selenium2-driver pdepend/pdepend \
 instaclick/php-webdriver edgedesign/phpqa php-parallel-lint/php-parallel-lint sensiolabs/security-checker \
 consolidation/robo:^1.0 --no-interaction

RUN curl -L -o /usr/local/bin/php-cs-fixer https://cs.symfony.com/download/php-cs-fixer-v2.phar
RUN curl -L -o /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-9.phar
RUN curl -L -o /usr/local/bin/phploc https://phar.phpunit.de/phploc.phar
RUN curl -L -o /usr/local/bin/phpmd https://phpmd.org/static/latest/phpmd.phar
RUN curl -L -o /usr/local/bin/phpcpd https://phar.phpunit.de/phpcpd.phar
RUN curl -L -o /usr/local/bin/psalm https://raw.githubusercontent.com/psalm/phar/3.9.5/psalm.phar

RUN chmod +x /usr/local/bin/php-cs-fixer
RUN chmod +x /usr/local/bin/phpunit
RUN chmod +x /usr/local/bin/phploc
RUN chmod +x /usr/local/bin/phpmd
RUN chmod +x /usr/local/bin/phpcpd
RUN chmod +x /usr/local/bin/psalm


WORKDIR /var/www/app

EXPOSE 9000
