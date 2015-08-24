#!/bin/bash -x

sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers
sed -i -e 's/.*%sudo.*/%sudo\tALL=NOPASSWD:ALL/g' /etc/sudoers
