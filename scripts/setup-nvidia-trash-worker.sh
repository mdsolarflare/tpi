# Other stuff:
# 1. Assign the mac to a IP on the dhcp server
# 2. Flash in SDK manager
# DO NOT UPGRADE ANYTHING thru ubuntu, NVIDIA SUCKS

# Required:
# SDK Manager 2.1.0.11669 x86_64
# Ubuntu Jammy - I ran Ubuntu Jammy on VMware Workstation 17 Player
# Installed:
# JetPack 5.1.3

# Required:
# SDK Manager 2.3.x
# Ubuntu 22 - I ran Ubuntu 22 on VMware Workstation 17 Player
# Installed:
# JetPack 6.2
# NOTE: Docker not compatible out of the box because NVIDIA sucks - https://forums.developer.nvidia.com/t/new-jetson-orin-nano-docker-issue/324669/2
sudo apt install docker-ce=5:27.5.1-1~ubuntu.22.04~jammy \
                 docker-ce-cli=5:27.5.1-1~ubuntu.22.04~jammy
sudo apt-mark hold docker-ce=5:27.5.1-1~ubuntu.22.04~jammy
sudo apt-mark hold docker-ce-cli=5:27.5.1-1~ubuntu.22.04~jammy


# REDO XAVIER
# ref: https://viking-drone.com/wiki/upgrading-nvidia-jetson-xavier-nx-to-ubuntu-20-04/

# Installing k3s worker per https://docs.k3s.io/quick-start
curl -sfL https://get.k3s.io | K3S_URL="https://$2:6443" K3S_TOKEN=$1 sh -

