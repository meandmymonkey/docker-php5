FROM meandmymonkey/nginx

MAINTAINER Andreas Hucks "andreas@inputrequired.org"

RUN add-apt-repository -y ppa:ufirst/php5
RUN apt-get update
RUN \
    apt-get -y install \
    php5-fpm \
    php5-mysql \
    php-apc \
    php5-imagick \
    php5-mcrypt \
    php5-curl \
    php5-cli \
    php5-gd \
    php5-pgsql \
    php5-sqlite \
    php5-common \
    php-pear \
    php5-json \
    curl \
    supervisor
RUN \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ && \
    mv /usr/bin/composer.phar /usr/bin/composer

RUN echo "<?php phpinfo();" > /var/www/index.php && rm /var/www/index.html

ADD ./default /etc/nginx/sites-available/default
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]