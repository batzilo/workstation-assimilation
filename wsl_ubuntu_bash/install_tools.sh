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

echo "Installing basic CLI tools and packages ..."
sudo apt install -y \
  adduser \
  apt \
  apt-listchanges \
  apt-utils \
  bash \
  bash-completion \
  bat \
  ca-certificates \
  easy-rsa \
  fd-find \
  fzf \
  gnupg \
  gnupg2 \
  gnupg-agent \
  htop \
  ipcalc \
  less \
  libreadline-dev \
  libssl-dev \
  lsb-base \
  lsb-release \
  lsof \
  ltrace \
  mutt \
  ncurses-term \
  openssh-client \
  openssh-server \
  openssl \
  poppler-data \
  poppler-utils \
  readline-common \
  rsync \
  screen \
  sed \
  sipcalc \
  software-properties-common \
  strace \
  tmux \
  tree \
  util-linux \
  zoxide

echo "Installing packages related to hardware ..."
sudo apt install -y \
  ddccontrol \
  dmidecode \
  hwinfo \
  hwloc \
  inxi \
  lshw \
  pciutils \
  x86info

echo "Installing packages for disks and filesystems ..."
sudo apt install -y \
  dmsetup \
  dosfstools \
  e2fsprogs \
  exfat-fuse \
  fuse3 \
  gdisk \
  hdparm \
  ntfs-3g \
  parted \
  sshfs

echo "Installing packages related to networking ..."
sudo apt install -y \
  bridge-utils \
  curl \
  dnsmasq-base \
  dnsutils \
  ethtool \
  hostname \
  ifupdown \
  iproute2 \
  iptables \
  iputils-arping \
  iputils-ping \
  netcat-openbsd \
  netcat-traditional \
  nethogs \
  net-tools \
  ngrep \
  nmap \
  openvpn \
  socat \
  tcpdump \
  tcpflow \
  traceroute \
  wget

echo "Installing packages related to files ..."
sudo apt install -y \
  bzip2 \
  dos2unix \
  file \
  gzip \
  libbz2-dev \
  ranger \
  tar \
  unrar \
  unzip \
  zip \
  zlib1g

echo "Installing packages related to coding ..."
sudo apt install -y \
  autoconf \
  automake \
  autotools-dev \
  build-essential \
  clang \
  clang-format \
  clang-tidy \
  cmake \
  cpp \
  diffutils \
  g++ \
  gcc \
  ghc \
  ghc-doc \
  git \
  git-delta \
  grep \
  jq \
  libomp-dev \
  make \
  patch \
  ripgrep \
  vim

echo "Installing packages related to Python ..."
sudo apt install -y \
  build-essential \
  libbz2-dev \
  libffi-dev \
  liblzma-dev \
  libncursesw5-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  libxml2-dev \
  libxmlsec1-dev \
  llvm \
  make \
  python3 \
  python3-flake8 \
  python3-ipdb \
  python3-ipython \
  python3-pip \
  python3-venv \
  tk-dev \
  wget \
  xz-utils \
  zlib1g-dev

echo "Installing packages related to Java ..."
sudo apt install -y \
  default-jdk-headless \
  default-jre-headless \
  java-common \
  maven

echo "Installing packages related to graphing ..."
sudo apt install -y \
  gnuplot \
  graphviz

echo "Done."
