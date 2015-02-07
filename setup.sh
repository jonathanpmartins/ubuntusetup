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

#
# UPDATE / UPGRADE
#

sudo apt-get update;
sudo apt-get upgrade;

#
#  INSTALL
#

#git
sudo apt-get install git;

# sublime text 3 
sudo apt-get install sublime-text-installer;




#
# SHOW SSH PUBLIC KEY
#

echo cat ~/.ssh/id_rsa.pub