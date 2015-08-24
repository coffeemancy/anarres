#!/usr/bin/env bash

# arrays
boxen[0]="anarres-vbox-arch"
tmpls[0]="arch"

# returns true if vagrant already has box installed, otherwise false
function vagrant_has_box() {
    local box=$1

    if echo $(vagrant box list) | grep -q -e "$box"; then
        printf "\e[32m$box already installed\e[00m\n"
        return 0 # true
    else
        printf "\e[31m$box not installed!\e[00m\n"
        return 1 # false
    fi
}

# returns true if vagrant box built at boxpath, otherwise false
function packer_has_built_boxpath(){
    local boxpath=$1

    if [ -f $boxpath ]; then
        printf "\e[32m$boxpath exists\e[00m\n"
        return 0 # true
    else
        printf "\e[31m$boxpath does not exist!\e[00m\n"
        return 1 # false
    fi
}

# checks if vagrant box already exists, otherwise builds with packer
function exists_or_packer_build() {
    local box=$1; local tmpl=$2

    boxpath="out/vagrant/$box.box"

    if packer_has_built_boxpath $boxpath; then
        printf "\e[33m(delete $boxpath to force rebuild)\e[00m\n"
    else
        printf "\e[33mbuilding $box...\e[00m\n"
        echo packer build packer/templates/$tmpl.json
    fi
}

# adds a vagrant box, if not already added
function vagrant_add() {
   local box=$1

   if vagrant_has_box $box; then
       printf "\e[33m(remove $box from vagrant to force adding again)\e[00m\n"
   else
       printf "\e[33madding $box\e[00m\n"
       vagrant box add --name $box out/vagrant/$box.box --provider virtualbox
   fi
}

# iterate over all boxen
for ((i=0;i<${#tmpls[@]};++i)); do
    exists_or_packer_build ${boxen[$i]} ${tmpls[$i]}
    vagrant_add ${boxen[$i]}
done
