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

NOTE: Please read the script beforehand, there are variables that may be different for your system.

Use ```./scripts/setup-master.sh``` script. This script will install and configure k3s as the master node in your cluster.

### Setting up Worker Nodes:

NOTE: Please read the script beforehand, there are variables that may be different for your system.

On each worker node Raspberry Pi, run ```./scripts/setup-worker.sh``` script. This script will install and configure k3s as a worker node, joining it to the master node you set up previously.

**Important Note:** Running these scripts will modify your Raspberry Pi system configurations. Ensure you understand the contents of the scripts before running them.

### Load Balancing (required for the following PiHole Manifest)
This repository includes a k3s manifest file (located in the k3s-manifest directory) for setting up Metallb as a load balancer for your cluster.

#### Deploy Metallb:
After setting up the master and worker nodes, deploy the metallb.yaml manifest using ```kubectl apply -f k3s-manifest/metallb-default-pool.yaml```. This will create the necessary resources for Metallb to function.

### PiHole Deployment
This repository also includes a k3s manifest file (located in the k3s-manifest directory) for deploying PiHole, a popular ad blocker, on your cluster.

#### Deploy PiHole:
After deploying Metallb (if desired), deploy the pihole-rpi.yaml manifest using ```kubectl apply -f k3s-manifest/pihole-rpi.yaml```. This will create a PiHole deployment using the previously configured Metallb for service discovery.

**Important Note:** Running pihole.yaml assumes a functional Metallb setup. Ensure you deploy k3s-manifest/metallb-default-pool.yaml first for PiHole to function correctly with load balancing.

# Additional Notes
Refer to the k3s documentation for more detailed information on managing your k3s cluster: https://github.com/k3s-io/docs
