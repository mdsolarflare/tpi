# Assign the mac to a IP on the dhcp server

# Required:
# SDK Manager 2.1.0.11669 x86_64
# Ubuntu Jammy - I ran Ubuntu Jammy on VMware Workstation 17 Player
# Installed:
# JetPack 5.1.3

# Before doing the flash mode dance and flashing dance in sdkmanager, make sure to run the following manual in the staged install

# At this stage, we can create a default user name and hostname for the headless installation. 
# While this step is optional, it is also highly suggested to perform - makes the operating system 
# ready to use right after flashing without a need to use GUI to finish the installation, important 
# if you use an Orin module in any other node than 1:
# sudo ./tools/l4t_create_default_user.sh -u <username> -p <password> -a -n <hostname>
# where:
# <username> - replace with your user name
# <password> - replace with your password
# <hostname> - replace with the hostname to use in your network (also for the ssh connections)
# -a - autologin, if you are going to use desktop
# For example:
# 
# sudo ./tools/l4t_create_default_user.sh -u daniel -p topsecretpasswd -a -n orinnx

sudo apt update
sudo apt upgrade -y

# sad -> NBNA (Never Buy Nvidia Again)
# lsb_release -a
# No LSB modules are available.
# Distributor ID:	Ubuntu
# Description:	Ubuntu 20.04.6 LTS
# Release:	20.04
# Codename:	focal

# Installing k3s worker per https://docs.k3s.io/quick-start
curl -sfL https://get.k3s.io | K3S_URL="https://$2:6443" K3S_TOKEN=$1 sh -

