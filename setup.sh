#!/bin/bash
ask() {
    while true; do
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        read -p "$1 [$prompt] " REPLY
 
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi
 
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac 
    done
}

#
# GENERATE NEW SSH KEY
#

if [ ! -f ~/.ssh/id_rsa.pub ]; then
	ssh-keygen;
fi

echo "----- Here is your ssh public key -----";
cat ~/.ssh/id_rsa.pub || echo;

if ask "----- Have you copied the key? Can we proceed? -----" y; then
    echo "Forward...";
else
    exit 0;
fi

#
# REPOSITORIES
#

echo "----- Adding new repositories -----";

# sublime text 3
#sudo add-apt-repository ppa:webupd8team/sublime-text-3;
# brackets
#sudo add-apt-repository ppa:webupd8team/brackets;
# chrome
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - ;
#sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list';

#
# UPDATE / UPGRADE
#

echo "----- Update + Upgrade -----";

#sudo apt-get update;
#sudo apt-get -y upgrade;

#
#  INSTALL
#
echo "----- Installing Tools -----";

apt_get_packages=( "google-chrome-stable" "git" "gitk" "sublime-text" "brackets" "nodejs-legacy" "npm" "nginx" "mysql-server" "php5" "php5-mcrypt" "php5-curl" "curl" "phantomjs" );

for i in "${!apt_get_packages[@]}"; do
	if [ $(dpkg-query -W -f='${Status}' "${apt_get_packages[$i]}" 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
		echo "----- Installing ${apt_get_packages[$i]} -----";
		sudo apt-get install -y ${apt_get_packages[$i]};
	else
		echo "----- '${apt_get_packages[$i]}' already installed -----";
	fi
done

sudo php5enmod mcrypt;

npm_packages=( "gulp" "bower" "mup" "browserify" );

for i in "${!npm_packages[@]}"; do

	if [ $(npm list -g "${npm_packages[$i]}" 2>/dev/null | grep -c "${npm_packages[$i]}") -eq 0 ];
	then
		echo "----- Installing ${npm_packages[$i]} -----";
		sudo npm install -g ${npm_packages[$i]};
	else
		echo "----- '${npm_packages[$i]}' already installed -----";
	fi
done

# composer
if [ ! -f /usr/local/bin/composer ]; then
	echo "----- Installing Composer -----";
	curl -sS https://getcomposer.org/installer | php;
	sudo mv composer.phar /usr/local/bin/composer;
else
	echo "----- Updating Composer -----";
	sudo composer self-update;
fi

# meteor js
if [ ! -d ~/.meteor ]; then
	echo "----- Installing Meteor -----";
	curl https://install.meteor.com/ | sh;
else
	echo "----- Updating Meteor -----";
	#sudo composer self-update;
fi

sudo chown -R jonathan:jonathan ~/.npm;

exit 0;