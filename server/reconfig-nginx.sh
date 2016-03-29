#!/bin/bash

mkdir ~/BKP;
sudo cp -R /etc/nginx/ ~/BKP/;
sudo apt-get purge -y nginx*;
sudo apt-get autoremove;

cd ~/;
wget http://nginx.org/keys/nginx_signing.key;
sudo apt-key add nginx_signing.key;

echo "

deb http://nginx.org/packages/ubuntu/ trusty nginx
deb-src http://nginx.org/packages/ubuntu/ trusty nginx
" | sudo tee -a /etc/apt/sources.list;

sudo apt-get -y update;
sudo apt-get -y upgrade;

sudo apt-get install nginx;

sudo mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak;
sudo mv /etc/nginx/conf.d/example_ssl.conf /etc/nginx/conf.d/example_ssl.conf.bak;

sudo cp ~/BKP/nginx/sites-available/api /etc/nginx/conf.d/api.conf;

sudo service nginx restart;


# sudo cp ~/BKP/nginx/sites-available/admin.getmo.com.br /etc/nginx/conf.d/admin.getmo.com.br.conf;
# sudo cp ~/BKP/nginx/sites-available/awsdb.getmo.com.br /etc/nginx/conf.d/awsdb.getmo.com.br.conf;
# sudo cp ~/BKP/nginx/sites-available/beanstalkd.getmo.com.br /etc/nginx/conf.d/beanstalkd.getmo.com.br.conf;
# sudo cp ~/BKP/nginx/sites-available/broadcast.getmo.com.br /etc/nginx/conf.d/broadcast.getmo.com.br.conf;
# sudo cp ~/BKP/nginx/sites-available/dev-admin.getmo.com.br /etc/nginx/conf.d/dev-admin.getmo.com.br.conf;
# sudo cp ~/BKP/nginx/sites-available/dev-api.getmo.com.br /etc/nginx/conf.d/dev-api.getmo.com.br.conf;
# sudo cp ~/BKP/nginx/sites-available/supervisor.getmo.com.br /etc/nginx/conf.d/supervisor.getmo.com.br.conf;
# sudo cp ~/BKP/nginx/sites-available/www.getmo.com.br /etc/nginx/conf.d/www.getmo.com.br.conf;
# sudo cp ~/BKP/nginx/sites-available/www.instad.com.br /etc/nginx/conf.d/www.instad.com.br.conf;
# sudo cp ~/BKP/nginx/sites-available/www.lyx.com.br /etc/nginx/conf.d/www.lyx.com.br.conf;

#log_format complete '$time_local - $http_x_forwarded_for : $remote_addr ($status) "$request" ["$request_body"] $remote_user - "$http_referer" - "$http_user_agent"';