ARG BUILD_FROM
FROM $BUILD_FROM

LABEL maintainer = ShonP40 <contact@shon.codes>

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8

# Install requirements for add-on
RUN apk update && apk add --no-cache bash jq iw linux-firmware-other \
                            linux-firmware-ath6k linux-firmware-ath10k \
                            linux-firmware-ath9k_htc \
                            hostapd networkmanager iptables \
                            net-tools sudo busybox-extras  && \
                            rm -rf /var/cache/apk/*

COPY hostapd.conf /
COPY udhcpd.conf /etc/udhcpd.conf
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
