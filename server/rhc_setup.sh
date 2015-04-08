#!/bin/bash

sudo apt-get update;
sudo apt-get -y upgrade;

sudo apt-get -y install php5-cli;
sudo apt-get -y install php5-mysql;
sudo apt-get -y install php5-curl;

sudo apt-get -y install ruby-full;
sudo apt-get -y install rubygems-integration;

sudo apt-get -y install git-core;

sudo gem install rubygems-update;
sudo update_rubygems;

sudo gem install rhc;