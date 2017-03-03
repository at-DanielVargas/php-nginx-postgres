FROM alpine:3.5

ENV DEV_USER=dev \
    DEV_PASS=dev \
    ROOT_PASS=root

RUN apk add --no-cache \
      s6 \
      su-exec \
      openssh \
      nginx \
      php7-fpm \
      php7-mcrypt \
      php7-json \
      php7-session \
      php7-zlib \
      php7-pdo \
      php7-pdo_sqlite \
      php7-mbstring && \
    mkdir -p /www && \
    echo "<?php phpinfo(); ?>" > /www/index.php && \
    echo "root:${ROOT_PASS}" | chpasswd > /dev/null 2>&1 && \
    echo -e "${DEV_PASS}\n${DEV_PASS}" | adduser ${DEV_USER} > /dev/null 2>&1 && \
    ssh-keygen -A && \
    rm -f /var/cache/apk/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY run.sh /usr/local/bin/run.sh
COPY s6.d /etc/s6.d

RUN chmod +x /usr/local/bin/run.sh /etc/s6.d/*/* /etc/s6.d/.s6-svscan/*

EXPOSE 8080

CMD ["run.sh"]
