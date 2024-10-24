#!/bin/bash
# Usage
# ./setup-worker.sh $token $masterIp $thisNodeName

# probably missed some stuff ill run into later and add here next time

# Post DietPi setup, pre-k3s
sed -i '1s/$/cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt

# Installing k3s worker per https://docs.k3s.io/quick-start
curl -sfL https://get.k3s.io | K3S_URL="https://$2:6443" K3S_TOKEN=$1 sh -

# Arkade? - https://github.com/alexellis/arkade#getting-arkade
# Note: you can also run without `sudo` and move the binary yourself
#curl -sLS https://get.arkade.dev | sudo sh
#
#arkade --help
#ark --help  # a handy alias
