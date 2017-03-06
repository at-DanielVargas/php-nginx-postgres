#!/bin/sh
export DEV_USER=${DEV_USER:-dev}
export DEV_PASSWORD=${DEV_PASSWORD:-dev}
export ROOT_PASSWORD=${ROOT_PASSWORD:-root}

echo "root:${ROOT_PASSWORD}" | chpasswd > /dev/null 2>&1
echo -e "${DEV_PASSWORD}\n${DEV_PASSWORD}" | adduser ${DEV_USER} > /dev/null 2>&1
/usr/sbin/sshd -o PermitRootLogin=yes -o UseDNS=no
chown -R $DEV_USER:$DEV_USER /code /var/log /tmp /etc/s6.d
exec su-exec $DEV_USER:$DEV_USER /bin/s6-svscan /etc/s6.d
