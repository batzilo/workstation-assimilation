# vim: set nospell:

#
# Basics
#
package %w(
  adduser
  apt
  apt-listchanges
  apt-transport-https
  apt-utils
  bash
  bash-completion
  ca-certificates
  easy-rsa
  galculator
  gnupg
  gnupg-agent
  gnupg2
  htop
  ipcalc
  less
  libreadline-dev
  libssl-dev
  lsb-base
  lsb-release
  lsof
  ltrace
  mutt
  ncurses-term
  openssh-client
  openssh-server
  openssl
  poppler-data
  poppler-utils
  readline-common
  rsync
  screen
  sed
  sipcalc
  software-properties-common
  strace
  tree
  util-linux
) do
  action :upgrade
end

#
# Hardware
#
package %w(
  dmidecode
  firmware-linux-nonfree
  firmware-realtek
  hwinfo
  lshw
  pciutils
) do
  action :upgrade
end

#
# Disks & Filesystem
#
package %w(
  dmsetup
  dosfstools
  e2fslibs:amd64
  e2fsprogs
  exfat-fuse
  exfat-utils
  fuse3
  gdisk
  hdparm
  ntfs-3g
  parted
  sshfs
) do
  action :upgrade
end

#
# Networking CLI
#
package %w(
  bridge-utils
  curl
  dnsmasq-base
  dnsutils
  ethtool
  firmware-iwlwifi
  hostname
  ifupdown
  iproute2
  iptables
  iputils-arping
  iputils-ping
  iw
  net-tools
  netcat-openbsd
  netcat-traditional
  nethogs
  network-manager
  ngrep
  nmap
  openvpn
  socat
  tcpdump
  tcpflow
  traceroute
  wget
  wireless-regdb
  wireless-tools
  wpasupplicant
) do
  action :upgrade
end
# FIXME: Add user to 'wireshark' group
# for example `adduser $TARGET_USER wireshark`

# #
# # Bluetooth
# #
# package %w(
#   blueman
#   bluetooth
#   bluez
#   bluez-obexd
#   bluez-tools
# ) do
#   action :upgrade
# end

#
# Files
#
package %w(
  bzip2
  dos2unix
  file
  gzip
  libbz2-dev
  tar
  unrar
  unzip
  zip
  zlib1g-dev:amd64
  zlib1g:amd64
) do
  action :upgrade
end

#
# Coding
#
package %w(
  autoconf
  automake
  autotools-dev
  build-essential
  cpp
  diffutils
  g++
  gcc
  ghc
  ghc-doc
  git
  grep
  jq
  make
  patch
  python3
  python3-flake8
  python3-ipdb
  python3-ipython
  python3-pip
  vim
) do
  action :upgrade
end

#
# Tex
#
package %w(
  texlive-full
) do
  action :upgrade
end
# tex-common
# tex-gyre
# texlive-base
# texlive-binaries
# texlive-extra-utils
# texlive-font-utils
# texlive-fonts-recommended
# texlive-fonts-recommended-doc
# texlive-generic-extra
# texlive-generic-recommended
# texlive-latex-base
# texlive-latex-base-doc
# texlive-latex-extra
# texlive-latex-extra-doc
# texlive-latex-recommended
# texlive-latex-recommended-doc
# texlive-pictures
# texlive-pictures-doc
# texlive-pstricks
# texlive-pstricks-doc
# texlive-xetex

#
# VMs
#
# package %w(
#   virtualbox-6.0
#   vagrant
# ) do
#   action :upgrade
# end

#
# Java
#
# package %w(
#   ant
#   ant-optional
#   antlr
#   default-java-plugin
#   default-jdk
#   default-jdk-headless
#   default-jre
#   default-jre-headless
#   java-common
#   maven
#   openjdk-8-jdk-headless:amd64
#   openjdk-8-jdk:amd64
#   openjdk-8-jre-headless:amd64
#   openjdk-8-jre:amd64
# ) do
#   action :upgrade
# end

#
# Graphviz
#
package %w(
  graphviz
) do
  action :upgrade
end

# TODO:
# * install/configure/run Dropbox
# * configure sudo
