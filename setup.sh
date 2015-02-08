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

mytools=( "git" "gitk" "sublime-text" "brackets" "nodejs" "npm" );

for i in "${!mytools[@]}"; do
	if [ $(dpkg-query -W -f='${Status}' "${mytools[$i]}" 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
		sudo apt-get install -y ${mytools[$i]};
	else
		echo "----- ${mytools[$i]} already installed -----";
	fi
done

exit 0;



# nodejs, npm, meteor