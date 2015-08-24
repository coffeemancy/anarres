# packer.mk

packer: packer/build

# build vagrant boxen with packer
packer/build: packer/isos
	./tasks/scripts/packer-build.sh

packer/dirs:
	mkdir -p packer/isos && mkdir -p packer/torrents

# download ISOs, prefer torrents
packer/isos: packer/isos/torrents

packer/isos/torrents: packer/dirs
	./tasks/scripts/packer-download.sh
