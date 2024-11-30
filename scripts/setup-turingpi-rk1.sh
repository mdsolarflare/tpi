# flash it via web ui
# First, identify your network interface:

#bash  ->  ip addr  -> was eth 0

# sudo nano /etc/netplan/1-netcfg.yaml
# example cfg
#network:
#  version: 2
#  renderer: networkd
#  ethernets:
#    enp0s3:  # Replace with YOUR actual interface name
#      addresses: [192.168.1.100/24]  # Static IP you want to use
#      gateway4: 192.168.1.1  # Your router's IP address
#      nameservers:
#        addresses: [8.8.8.8, 1.1.1.1]  # Google and Cloudflare DNS

#bash -> sudo netplan apply
