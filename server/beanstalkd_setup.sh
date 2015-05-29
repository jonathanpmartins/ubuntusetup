#!/bin/bash

#
# UPDATE / UPGRADE
#

echo "--------------- Update + Upgrade";

sudo apt-get update;
sudo apt-get -y upgrade;
sudo apt-get -y dist-upgrade;

#
#  INSTALL
#
echo "--------------- Installing Tools";

apt_get_packages=( "beanstalkd"  );

for i in "${!apt_get_packages[@]}"; do
	if [ $(dpkg-query -W -f='${Status}' "${apt_get_packages[$i]}" 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
		echo "--------------- Installing ${apt_get_packages[$i]}";
		sudo apt-get install -y ${apt_get_packages[$i]};
	else
		echo "--------------- '${apt_get_packages[$i]}' already installed";
	fi
done