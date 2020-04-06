#!/bin/sh
set -e
USERHOME=/mnt/home/$1
GROUP=${2:-"nogroup"}
adduser -D -h ${USERHOME} -s /usr/bin/git-shell -G ${GROUP} $1
sed -i "s/${1}:./${1}:*/" /mnt/etc/passwd
sed -i "s/${1}:./${1}:*/" /mnt/etc/shadow
mkdir -p ${USERHOME}/.ssh
chmod 700 ${USERHOME}/.ssh
touch ${USERHOME}/.ssh/authorized_keys
chmod 600 ${USERHOME}/.ssh/authorized_keys
chown -R $1:${GROUP} ${USERHOME}/.ssh
