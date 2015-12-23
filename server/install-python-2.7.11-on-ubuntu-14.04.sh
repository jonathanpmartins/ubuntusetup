#!/bin/bash

sudo apt-get update;
sudo apt-get upgrade;

sudo apt-get install autoconf automake gcc make git;
sudo apt-get install libffi-dev libncurses5-dev openssl patch python-dev python-virtualenv libreadline6-dev libsqlite3-dev libbz2-dev;
sudo apt-get install libsqlite3-dev libbz2-dev libdb5.3-dev tk8.6-dev libncurses5-dev libssl-dev libgdbm-dev;

wget https://launchpad.net/ubuntu/+archive/primary/+files/python2.7_2.7.11.orig.tar.gz;
tar xf python2.7_2.7.11.orig.tar.gz;
cd python2.7-2.7.11;

sudo rm -rf /usr/lib/python2.*;
sudo rm /usr/lib/python2.*;
sudo rm -rf /usr/local/lib/python2.*;
sudo rm /usr/local/lib/python2.*;

./configure --prefix=/usr --enable-unicode=ucs4 --enable-ipv6;
make;
sudo make install;

wget https://bootstrap.pypa.io/get-pip.py;
sudo python get-pip.py;

sudo pip install virtualenv;
