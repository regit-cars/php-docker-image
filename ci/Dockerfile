FROM php:8.1-fpm-alpine

# install packages and build tools
RUN apk --no-cache --update add \
    gcc g++ musl-dev make curl bash openssl openssl-dev autoconf shadow \
    freetype-dev libjpeg-turbo-dev libpng-dev libwebp-dev libxml2-dev libmemcached-dev icu-dev \
    libzip libzip-dev libssl1.1 libcrypto1.1 oniguruma oniguruma-dev libgcrypt-dev libxslt-dev \
    gettext-dev gmp-dev imap-dev unzip

RUN docker-php-ext-install mysqli \
    && docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap \
    && docker-php-ext-install zip \
    && docker-php-ext-install imap \
    && docker-php-ext-install opcache \
    && docker-php-ext-install calendar \
    && docker-php-ext-install sockets \
    && docker-php-ext-install exif \
    && docker-php-ext-install gettext \
    && docker-php-ext-install gmp \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install intl \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install xsl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install gd \
    && docker-php-ext-enable imap

RUN pecl install memcached \
	&& docker-php-ext-enable memcached

# install composer
RUN curl -L -o /usr/local/bin/composer https://getcomposer.org/composer-stable.phar  \
    && chmod a+rx /usr/local/bin/composer

ENV PATH="/usr/local/bin:/composer/vendor/bin:${PATH}"
RUN mkdir /composer
ENV COMPOSER_HOME="/composer"

RUN curl -L -o /usr/local/bin/php-cs-fixer https://cs.symfony.com/download/php-cs-fixer-v3.phar \
    && curl -L -o /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-10.phar \
    && curl -L -o /usr/local/bin/phploc https://phar.phpunit.de/phploc.phar \
    && curl -L -o /usr/local/bin/phpmd https://phpmd.org/static/latest/phpmd.phar \
    && curl -L -o /usr/local/bin/phpcpd https://phar.phpunit.de/phpcpd.phar \
    && curl -L -o /usr/local/bin/psalm https://github.com/vimeo/psalm/releases/download/4.24.0/psalm.phar \
    && curl -L -o /usr/local/bin/phpstan https://github.com/phpstan/phpstan/releases/download/1.8.1/phpstan.phar \
    && chmod +x /usr/local/bin/php-cs-fixer \
    && chmod +x /usr/local/bin/phpunit \
    && chmod +x /usr/local/bin/phploc \
    && chmod +x /usr/local/bin/phpmd \
    && chmod +x /usr/local/bin/phpcpd \
    && chmod +x /usr/local/bin/psalm \
    && chmod +x /usr/local/bin/phpstan

COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

RUN apk del gcc g++ make musl-dev autoconf

WORKDIR /var/www/app

EXPOSE 9000

CMD php-fpm
