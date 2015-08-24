#!/usr/bin/env bash

# arrays for ISOs, because bash doesn't really have hashes, yuck
isos[0]="archlinux-2015.08.01-dual.iso"
urls[0]="https://www.archlinux.org/releng/releases/2015.08.01/torrent/"
shas[0]="e98320cd5f0c346fff4140af0b5ffadd59849168"

# checks iso SHASUM is correct, otherwise downloads it
function check_or_download() {
    local iso=$1; local url=$2; local sha=$3

    # calculate sha for iso, if already downloaded
    local the_sha=$(shasum packer/isos/$iso)

    if echo $the_sha | grep -q $sha; then
        printf "\e[32m$iso matches expected SHASUM ($sha)\e[00m\n"
    else
        printf "\e[31m$iso does not match expected SHASUM ($sha)!\e[00m\n"
        printf "\e[33mDownloading torrent. Assure to packer/isos/$iso!\e[00m\n"
        curl -L $url -o packer/torrents/$iso.torrent
        transmission-gtk packer/torrents/$iso.torrent
    fi
}

# iterate over all the ISOs, checking SHASUMs, downloading torrent if needed
for ((i=0;i<${#isos[@]};++i)); do
    check_or_download ${isos[$i]} ${urls[$i]} ${shas[$i]}
done
