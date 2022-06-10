ARG PHP_VERSION=8.1

FROM php:${PHP_VERSION}-fpm-alpine


ENV LD_LIBRARY_PATH "/opt/oci8/instantclient_21_1"

# Install OCI8
RUN set -eux; \
 apk add --no-cache composer libaio-dev libc6-compat \
 && mkdir -p /opt/oci8 \
 && cd /opt/oci8 \
 && wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basiclite-linux.x64-21.1.0.0.0.zip -O- | busybox unzip -q - \
 && wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-sdk-linux.x64-21.1.0.0.0.zip -O- | busybox unzip -q -

RUN set -eux; \
 cp /opt/oci8/instantclient_21_1/libclntsh.so.21.1 /opt/oci8/instantclient_21_1/libclntsh.so \
 && cp /lib64/ld-linux-x86-64.so.2 /opt/oci8/instantclient_21_1/ \
 && cp /lib/libc.so.6 /usr/lib/libresolv.so.2 \
 && ln -s /lib64/ld-linux-x86-64.so.2 /lib/ld-linux-x86-64.so.

RUN set -eux; \
 docker-php-ext-configure oci8 --with-oci8=instantclient,/opt/oci8/instantclient_21_1 \
 && docker-php-ext-install oci8

# Startup script
CMD ["php-fpm", "-F"]

EXPOSE 9000
