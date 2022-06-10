# docker-alpine-php8-oracle
Docker `php:8.1-fpm-alpine` with oracle client setup.

## Install
Clone, cd into and run `docker build -t oraclephp .` to build the image.
Start the container and run `php -i|grep oci` to see that `oci8` ist installed.

Thanks to https://stackoverflow.com/a/68105097/294074
