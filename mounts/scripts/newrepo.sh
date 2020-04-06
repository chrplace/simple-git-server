#!/bin/sh

cd ${2:-'/mnt/repos'}
umask 002
git init --bare $1.git
chown root:gitwriters -R $1.git
chmod g+sw -R $1.git
