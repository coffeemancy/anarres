#!/bin/bash -x

groupadd sudo

useradd -m -s /usr/bin/bash -k /etc/skel -G sudo vagrant
passwd vagrant <<EOF
vagrant
vagrant
EOF

# create vagrant dir
mkdir -p /home/vagrant/.ssh

# install vagrant public ssh key
wget --no-check-certificate -O authorized_keys 'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub'
mv authorized_keys /home/vagrant/.ssh
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh
