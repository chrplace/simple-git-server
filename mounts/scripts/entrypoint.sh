#!/bin/sh


if grep -qs '/mnt ' /proc/mounts; then
  echo "/mnt seems to be mounted, continuing"
else
  echo "/mnt is not mounted, exiting."
  exit
fi

echo "Setting up mounted user files"
ln -sf /mnt/etc/passwd /etc/passwd
ln -sf /mnt/etc/shadow /etc/shadow
ln -sf /mnt/etc/group /etc/group

if [ ! -f /mnt/ssh2/hostkey ]; then
  echo "Generating hostkey"
  ssh-keygen -f /mnt/ssh2/hostkey -N '' -t rsa
fi

echo "Setting permissions"
umask 002
chown root:gitwriters -R /mount/repos
#chmod g+ws -R /mount/repos

echo "Staring ssh server"
/usr/sbin/sshd -f /mnt/etc/sshd_config -D -e
