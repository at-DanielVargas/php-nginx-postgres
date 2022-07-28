FROM alpine:3.16

ENV PGDATA=/var/lib/postgresql/data

RUN apk add --no-cache \
  s6 \
  su-exec \
  openssh \
  openssl \
  nginx \
  postgresql \
  php81-fpm \
  php8-pecl-mcrypt \
  php81-json \
  php81-session \
  php81-zlib \
  php81-pdo \
  php81-pdo_pgsql \
  php81-mbstring && \
  mkdir -p /www && \
  mkdir -p $PGDATA && chmod 0755 $PGDATA && \
  mkdir -p /run/postgresql && chmod g+s /run/postgresql && \
  echo "<?php phpinfo(); ?>" > /www/index.php && \
  ssh-keygen -A && \
  rm -f /var/cache/apk/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php81/php-fpm.conf
COPY run.sh /usr/local/bin/run.sh
COPY s6.d /etc/s6.d

RUN chmod +x /usr/local/bin/run.sh /etc/s6.d/*/* /etc/s6.d/.s6-svscan/*

RUN wget "https://github.com/vrana/adminer/releases/download/v4.2.5/adminer-4.2.5-en.php" -O /www/adminer.php

EXPOSE 8080

CMD ["run.sh"]
