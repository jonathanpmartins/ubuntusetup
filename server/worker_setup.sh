#!/bin/bash

#
# UPDATE / UPGRADE
#

#
# MongoDB
#
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10;
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list;


echo "--------------- Update + Upgrade";

sudo apt-get update;
sudo apt-get -y upgrade;

#
#  INSTALL
#
echo "--------------- Installing Tools";

apt_get_packages=( "git" "php5-cli" "curl" "php5-curl" "mcrypt" "php5-mcrypt" "memcached" "php5-memcached" "php5-mysql" "php5-fpm" "php5-json" "php5-dev" "php-pear" "nginx" "supervisor" "mongodb-org" );

for i in "${!apt_get_packages[@]}"; do
	if [ $(dpkg-query -W -f='${Status}' "${apt_get_packages[$i]}" 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
		echo "--------------- Installing ${apt_get_packages[$i]}";
		sudo apt-get install -y ${apt_get_packages[$i]};
	else
		echo "--------------- '${apt_get_packages[$i]}' already installed";
	fi
done

sudo php5enmod mcrypt;
sudo service nginx restart;

# composer
if [ ! -f /usr/local/bin/composer ]; then
	echo "--------------- Installing Composer";
	curl -sS https://getcomposer.org/installer | php;
	sudo mv composer.phar /usr/local/bin/composer;
else
	echo "--------------- Updating Composer";
	sudo composer self-update;
fi

#
# ADD ALIASES TO BASH
#
if [ $(cat ~/.bashrc | grep -c "mybash") -eq 0 ];
then

echo '

alias reload="sudo service nginx reload"
alias restart="sudo service nginx restart"
alias restartphp="sudo service php5-fpm restart"
alias restartsql="sudo service mysql restart"

alias hosts="sudo vi /etc/hosts"
alias phpini="sudo vi /etc/php5/fpm/php.ini"
alias mybash="vi ~/.bashrc"

alias vhosts="cd /etc/nginx/sites-available; ls -li"
alias www="cd /var/www; ls -li"
alias logs="cd /var/log/nginx; ls -li"

alias dir="ls -la"
alias b="cd .."
alias ..="cd .."
alias ...="cd ../.."

' >> ~/.bashrc;
	exec bash;
fi
