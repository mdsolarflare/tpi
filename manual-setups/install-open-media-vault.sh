# Following the jeff g demo on youtube found https://wiki.omv-extras.org/doku.php?id=omv7%3Araspberry_pi_install which is/was setup by a member of the OMV mod community
# For magic persistence - manual setup here - https://docs.openmediavault.org/en/stable/installation/on_debian.html
# Github here - https://github.com/OpenMediaVault-Plugin-Developers/installScript

sudo apt-get update
sudo apt-get upgrade -y
wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/preinstall | sudo bash

# we have to reboot after
sudo reboot

# then finish install which also triggers an automatic reboot
wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash
# note: for some reason i had to run this twice... even with the reboot.

