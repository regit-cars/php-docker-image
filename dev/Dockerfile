FROM regitcars/php-fpm:ci

COPY php.ini /usr/local/etc/php/php.ini
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

RUN apk --no-cache --update add gcc g++ make musl-dev autoconf git linux-headers \
    && pecl install xdebug \
	&& docker-php-ext-enable xdebug \
    && apk del gcc g++ make musl-dev autoconf

# If you use Alpine, you need to set this value to "alpine"
ENV current_os=alpine
RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/$current_os/amd64/$version \
    && mkdir -p /tmp/blackfire \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire \
    && mv /tmp/blackfire/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8307\n" > $PHP_INI_DIR/conf.d/blackfire.ini \
    && rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz
# Please note that the Blackfire Probe is dependent on the session module.
# If it isn't present in your install, you will need # to enable it yourself.
