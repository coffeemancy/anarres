#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# update pacman cache
sudo pacman -Sy

# install python2 to use with ansible
sudo pacman -S --noconfirm python2
sudo pacman -S --noconfirm python2-pip

# install ansible and python packages
sudo pip2 install -r requirements.txt

# run the playbook
sudo ansible-playbook setup.yml -i HOSTS -b -M ./ansible_modules -u cstedman "$@"

