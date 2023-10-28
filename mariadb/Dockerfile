ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
RUN apk add --no-cache \
    mariadb=10.6.14-r0 \
    mariadb-client=10.6.14-r0 \
    mariadb-server-utils=10.6.14-r0 \
    pwgen

ENV \
    LD_PRELOAD="/usr/local/lib/libjemalloc.so.2" \
    S6_SERVICES_GRACETIME=18000

# Copy data
COPY rootfs /

WORKDIR /
