#!/bin/bash
mkdir /backup
mkdir /backup/mySQL
mkdir /backup/bashRC
mkdir /backup/misc
mkdir /backup/ssh
cp /etc/my.cnf /root/.my.cnf /var/cpanel/databases /var/lib/mysql /backup/mySQL
cp /etc/profile /etc/bash.bashrc /backup/bashRC
cp /etc/sysctl.conf /etc/sudoers /etc/environment /etc/inputrc /etc/crontab /backup/misc
cp /ssh/sshd_config /etc/pam.d -r /backup/ssh



