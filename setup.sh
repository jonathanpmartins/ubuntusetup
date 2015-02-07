#!/bin/sh

#
# GENERATE NEW SSH KEY
#

ssh-keygen;

#
# REPOSITORIES
#

# sublime text 3
sudo add-apt-repository ppa:webupd8team/sublime-text-3;
# brackets
sudo add-apt-repository ppa:webupd8team/brackets;

#
# UPDATE / UPGRADE
#

sudo apt-get update;
sudo apt-get -y upgrade;

#
#  INSTALL
#

#git
sudo apt-get -y install git;
# sublime text 3
sudo apt-get -y install sublime-text-installer;
# brackets
sudo apt-get -y install brackets;

#
# SHOW SSH PUBLIC KEY
#

echo cat ~/.ssh/id_rsa.pub


# nodejs, npm, meteor