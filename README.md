# tpi

This repository provides scripts and manifests to set up a Kubernetes cluster using k3s on Raspberry Pi devices.

## Prerequisites
- Multiple Raspberry Pi devices (one for the master node and others for worker 
 nodes).
- SSH access to each Raspberry Pi.
- Basic understanding of Kubernetes and k3s.

### Hardware Requirements
The hardware requirements will vary depending on your desired workload. However, it's recommended to have at least 2GB of RAM and a microSD card for each Raspberry Pi.

### Software Requirements
The Raspberry Pi OS (previously known as Raspbian) installed on each device.
You can also use DietPI - https://dietpi.com/


## Cluster Setup
The setup process involves two main steps:

### Setting up the Master Node:

See ```./scripts/setup-master-minimal.md``` script. This doc guides install and configure k3s as the master node in your cluster.

### Setting up Worker Nodes:

On each worker node Raspberry Pi, see ```./scripts/setup-worker.sh``` script. This script will install and configure k3s as a worker node, joining it to the master node you set up previously.


# Additional Notes
Refer to the k3s documentation for more detailed information on managing your k3s cluster: https://github.com/k3s-io/docs
