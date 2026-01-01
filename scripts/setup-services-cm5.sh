#!/bin/bash
# Usage
# DietPi Debian - https://dietpi.com/#download
# Debian        - https://www.debian.org/intro/why_debian

# Restart the Docker service and add your user to the docker group, so that you don't need to use the command with sudo .
sudo systemctl restart docker
sudo usermod -aG docker $USER
newgrp docker

docker run hello-world

# Install pihole - https://docs.pi-hole.net/docker/
# Install linuxserver/wireguard - https://docs.linuxserver.io/images/docker-wireguard/
# Run docker compose up -d to build and start Pi-hole (on older systems, the syntax here may be docker-compose up -d)
wget https://raw.githubusercontent.com/mdsolarflare/tpi/refs/heads/main/docker/virtualized-services.yml
# Don't forget to update your password :^) in the file
docker compose up -d

