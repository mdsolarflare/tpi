# Install ZFS
sudo apt update
sudo apt install raspberrypi-kernel-headers zfs-dkms zfsutils-linux -y
sudo apt full-upgrade -y
sudo reboot

# Once rebooted
# sudo apt autoremove && sudo apt clean

# Setup ZFS
# Verify ZFS is loaded
dmesg | grep ZFS

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
sudo zpool create media raidz1 nvme0n1 nvme1n1 nvme2n1 nvme3n1 -f

zfs list
#NAME    USED  AVAIL  REFER  MOUNTPOINT
#media   136K  2.63T  32.9K  /media
