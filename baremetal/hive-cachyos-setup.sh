# Intel N100/N150
sudo pacman -Syu

# Install ZFS 
# Verify, as ZFS came pre-installed because it was used as the backing storage in the cachyos installer.

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

# If it's bad, fix it! Otherwise, create the pool. There should be some references in openwebui
# https://www.raidz-calculator.com/raidz-types-reference.aspx
sudo zpool create -f -o ashift=12 -O compression=lz4 -O atime=off -O mountpoint=/media media raidz1 /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1

zpool list
#NAME        SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
#media      5.45T   912K  5.45T        -         -     0%     0%  1.00x    ONLINE  -
#zpcachyos   115G  6.48G   109G        -         -     0%     5%  1.00x    ONLINE  -

sudo chown <username> /media
sudo chmod -R u+rw /media

# https://docs.docker.com/desktop/setup/install/linux/archlinux/ for display install
# https://wiki.archlinux.org/title/Docker for headless... SMH
# 1. Install the native engine and compose plugin
sudo pacman -S docker docker-compose
# 2. Enable the service so it starts on boot
sudo systemctl enable --now docker
# 3. Add yourself to the group (to avoid using 'sudo' for every command)
sudo usermod -aG docker $USER
newgrp docker

docker run hello-world
