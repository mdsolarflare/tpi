# Assign the mac to a IP on the dhcp server
sudo apt update
sudo apt upgrade -y
sudo apt install -y iptables

# Installing k3s worker per https://docs.k3s.io/quick-start
curl -sfL https://get.k3s.io | K3S_URL="https://$2:6443" K3S_TOKEN=$1 sh -
