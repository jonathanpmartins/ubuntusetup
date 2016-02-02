#!/bin/bash

sudo apt-get update;
sudo apt-get upgrade;

sudo add-apt-repository ppa:chris-lea/redis-server;
sudo apt-get update;
sudo apt-get install redis-server;

redis-benchmark -q -n 1000 -c 10 -P 5;

