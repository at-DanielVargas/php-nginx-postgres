#!/bin/sh
export DEV_USER=${DEV_USER:-dev}
export DEV_PASS=${DEV_USER:-dev}
export ROOT_PASS=${ROOT_PASS:-root}

echo "root:${ROOT_PASS}" | chpasswd > /dev/null 2>&1
echo -e "${DEV_PASS}\n${DEV_PASS}" | adduser ${DEV_USER} > /dev/null 2>&1
/usr/sbin/sshd -o PermitRootLogin=yes -o UseDNS=no
chown -R $DEV_USER /www /etc/nginx /etc/php7 /var/log /var/lib/nginx /tmp /etc/s6.d
exec su-exec $DEV_USER /bin/s6-svscan /etc/s6.d
