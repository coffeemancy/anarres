# anarres

Superliminal configuration of my workstations with ansible.

# development and testing

anarres can use packer to build a vagrant box from an ISO, for use in testing. Alternatively, vagrant boxen can be installed manually. The vagrant boxen are spun up with test-kitchen, provisioned via ansible, and tested via serverspec.

## building a packer image

Run `make packer`. Currently this just builds an image for Arch Linux.

### downloading ISOs

Although `packer` has the ability to download ISOs and perform checksums, it does not support (as of 0.8.5) downloading via torrents, which is the preferred method of downloading ISOs for most linux distributions, as it greatly decreases their bandwidth usage.

Currently, `make packer` will download the torrents (into "packer/torrents"), and try to run `transmission-gtk` to download the ISO via torrent. The ISO must be stuffed into the "packer/isos" directory.

# et cetera

♡ 2015 by Carlton Stedman. Copying art is an act of love. Please copy.
