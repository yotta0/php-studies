FROM php:7.3-apache

WORKDIR /var/www/html

RUN apt-get --allow-releaseinfo-change update && apt-get install -y \
  libxml2-dev \
  libzip-dev \
  libpng-dev \
  vim \
  unzip \
  git \
  curl \
  libpq-dev \
  postgresql-client \
  libc-client-dev libkrb5-dev \
  wget \
  ffmpeg

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install imap
RUN docker-php-ext-install exif
RUN docker-php-ext-install zip
RUN docker-php-ext-install pgsql
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install gd
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install xml


# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Update permissions
RUN chmod -R 777 /var/www/html