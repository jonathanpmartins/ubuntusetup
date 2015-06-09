#!/bin/bash

df -h;

sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=2048;
sudo chmod 600 /var/swap.1;
sudo /sbin/mkswap /var/swap.1;
sudo /sbin/swapon /var/swap.1;

echo '"/var/swap.1 none swap defaults 0 0" >> /etc/fstab' | sudo sh;

free -m;