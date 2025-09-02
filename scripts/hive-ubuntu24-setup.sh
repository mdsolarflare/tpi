# Install ZFS - https://ubuntu.com/tutorials/setup-zfs-storage-pool#1-overview
sudo apt update
# RPI 5
# sudo apt install raspberrypi-kernel-headers zfs-dkms zfsutils-linux -y
# Intel N150
sudo apt install zfsutils-linux
# sudo apt full-upgrade -y
# sudo reboot

# Once rebooted
# sudo apt autoremove && sudo apt clean

# Setup ZFS
# Verify ZFS is loaded
whereis zfs

# Inspect disks
lsblk
#NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
#mmcblk0     179:0    0  59.7G  0 disk
#├─mmcblk0p1 179:1    0   512M  0 part /boot/firmware
#└─mmcblk0p2 179:2    0  59.2G  0 part /
#nvme0n1     259:0    0 931.5G  0 disk
#├─nvme0n1p1 259:1    0 931.5G  0 part
#└─nvme0n1p9 259:2    0     8M  0 part
#nvme1n1     259:3    0 931.5G  0 disk
#├─nvme1n1p1 259:4    0 931.5G  0 part
#└─nvme1n1p9 259:5    0     8M  0 part
#nvme2n1     259:6    0 931.5G  0 disk
#├─nvme2n1p1 259:7    0 931.5G  0 part
#└─nvme2n1p9 259:8    0     8M  0 part
#nvme3n1     259:9    0 931.5G  0 disk
#├─nvme3n1p1 259:10   0 931.5G  0 part
#└─nvme3n1p9 259:11   0     8M  0 part

# If it's bad, fix it!
# Otherwise, create the pool. 
# https://www.raidz-calculator.com/raidz-types-reference.aspx
sudo zpool create <pool name> raidz1 drive1 drive2 drive3 drive4 -f

zfs list
#NAME    USED  AVAIL  REFER  MOUNTPOINT
#media   136K  2.63T  32.9K  /media
sudo chown myusername /media
sudo chmod -R u+rw /media

# https://docs.docker.com/engine/install/ubuntu/
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

#
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Restart the Docker service and add your user to the docker group, so that you don't need to use the command with sudo .
sudo systemctl restart docker
sudo usermod -aG docker $USER
newgrp docker

docker run hello-world
