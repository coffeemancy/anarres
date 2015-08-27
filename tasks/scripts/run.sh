#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# arch linux
if echo $(uname -r) | grep -q ARCH; then
    # update pacman cache and packages
    sudo pacman -Syu --noconfirm

    # install python2 to use with ansible
    sudo pacman -S --noconfirm python2
    sudo pacman -S --noconfirm python2-pip

    # install ansible and python packages
    sudo pip2 install -r requirements.txt
# otherwise, presume debian/ubuntu, for now
else
    # update apt cache
    sudo apt-get update

    # install ansible and python packages
    sudo pip install -r requirements.txt
fi

# run the playbook
sudo ansible-playbook setup.yml -i HOSTS -b -M ./ansible_modules -u cstedman "$@"

