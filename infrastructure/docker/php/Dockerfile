FROM php:7.4-fpm-buster
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

# timezone environment
ENV TZ=UTC \
  # locale
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8 \
  # composer environment
  COMPOSER_HOME=/composer \
  # Laravel environment
  DB_CONNECTION=mysql \
  DB_HOST=db \
  DB_DATABASE=laravel_local \
  DB_USERNAME=phper \
  DB_PASSWORD=secret

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update && \
  apt-get -y install git libicu-dev libonig-dev libzip-dev unzip locales && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  locale-gen en_US.UTF-8 && \
  localedef -f UTF-8 -i en_US en_US.UTF-8 && \
  docker-php-ext-install intl pdo_mysql mbstring zip bcmath && \
  composer config -g process-timeout 3600 && \
  composer config -g repos.packagist composer https://packagist.org && \
  composer global require hirak/prestissimo && \
  mkdir -p /work/backend /var/run/php-fpm && \
  chown -R www-data:www-data /var/run/php-fpm /composer /work && \
  chmod -R 777 /var/run/php-fpm

COPY ./php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf
COPY ./php.ini /usr/local/etc/php/php.ini

USER www-data
WORKDIR /work/backend
