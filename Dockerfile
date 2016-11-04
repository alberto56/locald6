# The Drupal 7 container does not work for Drupal 6 because it is based
# on php 7. We'll copy
# https://github.com/docker-library/drupal/blob/master/7/apache/Dockerfile
# and base it instead on php 5.
FROM php:5.6-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

# https://www.drupal.org/node/3060/release
ENV DRUPAL_VERSION 7.51
ENV DRUPAL_MD5 49f82c1cac8e4bd4941ca160fcbee93d

RUN curl -fSL "https://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz" -o drupal.tar.gz \
	&& echo "${DRUPAL_MD5} *drupal.tar.gz" | md5sum -c - \
	&& tar -xz --strip-components=1 -f drupal.tar.gz \
	&& rm drupal.tar.gz \
	&& chown -R www-data:www-data sites

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN apt-get update
RUN apt-get install -y git
RUN composer global require drush/drush:8
RUN ln -s /root/.composer/vendor/drush/drush/drush /bin/drush

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mysql-client

ADD docker-resources/run.sh /run.sh
ADD docker-resources/settings.php-database /settings.php-database

# See https://www.drupal.org/node/1826652
RUN echo 'sendmail_path = /bin/true' >> /usr/local/etc/php/php.ini

RUN apt-get install -y php5-mysql
RUN echo 'extension = /usr/lib/php5/20131226/mysql.so' >> /usr/local/etc/php/php.ini

EXPOSE 80
