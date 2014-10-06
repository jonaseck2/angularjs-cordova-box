#!/usr/bin/env bash
apt-get -y update

apt-get -y install unzip
apt-get -y install git
apt-get -y install vim

apt-get -y install python-software-properties python g++ make
add-apt-repository ppa:chris-lea/node.js
apt-get -y update

apt-get -y install nodejs

apt-get -y install openjdk-7-jdk
apt-get -y install ant
apt-get -y install expect