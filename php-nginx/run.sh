#!/bin/sh
/usr/sbin/sshd -o PermitRootLogin=yes -o UseDNS=no
chown -R $DEV_USER /www /etc/nginx /etc/php7 /var/log /var/lib/nginx /tmp /etc/s6.d
exec su-exec $DEV_USER /bin/s6-svscan /etc/s6.d
