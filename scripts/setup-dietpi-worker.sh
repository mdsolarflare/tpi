#!/bin/bash
# Usage
# ./setup-worker.sh $token $masterIp $thisNodeName

# probably missed some stuff ill run into later and add here next time

# Post DietPi setup, pre-k3s
sed -i '1s/$/cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt

# running kubectl logs -n longhorn-system pod/longhorn-manager-d97hr -p
# time="2024-11-15T10:18:02Z" level=fatal msg="Error starting manager: Failed environment check, please make sure you have iscsiadm/open-iscsi installed on the host: failed to execute: /usr/bin/nsenter [nsenter --mount=/host/proc/453509/ns/mnt --net=/host/proc/453509/ns/net iscsiadm --version], output , stderr nsenter: failed to execute iscsiadm: No such file or directory\n: exit status 127" func=main.main.DaemonCmd.func3 file="daemon.go:92"
# 
# longhorn was failing because of missing packages
sudo apt update
sudo apt install -y open-iscsi
sudo systemctl enable --now iscsid
# 
# looks like service restart and checks didn't help, will try deleting the pods so it starts over
# dietpi@dietpi:~$ kubectl -n longhorn-system delete pod -l app=longhorn-manager
# pod "longhorn-manager-pvmxn" deleted
# pod "longhorn-manager-7w5f2" deleted
# pod "longhorn-manager-d97hr" deleted
# pod "longhorn-manager-cx2cz" deleted
# looks like healthy after that, i didn't restart all machines. 
# so let's make sure we do the above since it's a missing package 
# from dietpi and it doesn't seem to have a place to install it

# Installing k3s worker per https://docs.k3s.io/quick-start
curl -sfL https://get.k3s.io | K3S_URL="https://$2:6443" K3S_TOKEN=$1 sh -
