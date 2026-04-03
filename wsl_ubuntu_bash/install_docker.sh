#!/usr/bin/env bash

# Fail fast and safely.
# -e: exit immediately if a command exits with a non-zero status.
# -u: treat unset variables as an error and exit immediately.
# -o pipefail: fail if any command in a pipeline fails.
set -euo pipefail

if ! command -v apt >/dev/null 2>&1; then
  echo "Error: apt not found. This script is for Ubuntu systems." >&2
  exit 1
fi

echo "Updating package index ..."
sudo apt update

if command -v docker >/dev/null 2>&1; then
  echo "Docker already installed." >&2
else
  echo "Installing docker ..."
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

if groups $(whoami) | grep "docker" >/dev/null 2>&1; then
  echo "Adding user to the docker group ..."
  sudo groupadd -f docker
  sudo adduser $(whoami) docker
else
  echo "User $(whoami) already in the docker group."
fi

echo "Done."
