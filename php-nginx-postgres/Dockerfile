FROM alpine:3.5

ENV PGDATA=/var/lib/postgresql/data

RUN apk add --no-cache \
      s6 \
      su-exec \
      openssh \
      openssl \
      nginx \
      postgresql \
      php7-fpm \
      php7-mcrypt \
      php7-json \
      php7-session \
      php7-zlib \
      php7-pdo \
      php7-pdo_pgsql \
      php7-mbstring && \
    mkdir -p /www && \
    mkdir -p $PGDATA && chmod 0755 $PGDATA && \
    mkdir -p /run/postgresql && chmod g+s /run/postgresql && \
    echo "<?php phpinfo(); ?>" > /www/index.php && \
    ssh-keygen -A && \
    rm -f /var/cache/apk/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY run.sh /usr/local/bin/run.sh
COPY s6.d /etc/s6.d

RUN chmod +x /usr/local/bin/run.sh /etc/s6.d/*/* /etc/s6.d/.s6-svscan/*

RUN wget "https://github.com/vrana/adminer/releases/download/v4.2.5/adminer-4.2.5-en.php" -O /www/adminer.php

EXPOSE 8080

CMD ["run.sh"]
