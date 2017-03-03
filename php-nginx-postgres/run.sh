#!/bin/sh
/usr/sbin/sshd -o PermitRootLogin=yes -o UseDNS=no
chown -R $DEV_USER:$DEV_USER /www /etc/nginx /etc/php7 /var/log /var/lib/nginx /var/lib/postgresql /run/postgresql /tmp /etc/s6.d
su-exec $DEV_USER:$DEV_USER /bin/s6-svscan /etc/s6.d
