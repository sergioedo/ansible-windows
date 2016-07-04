#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

# Install python-pip
apt-get -y install python-pip python-dev build-essential 
pip install --upgrade pip 
pip install --upgrade virtualenv 

#install some required libraries
#https://github.com/fabric8io/fabric8-ansible-hawtapp/issues/2
pip install xmltodict

#install winrm for windows remote connection
pip install pywinrm

#Custom config, ansible directories in /src
sudo cp /src/ansible.cfg /etc/ansible