# vim: set nospell:

# #
# # Basics
# #
# log 'message' do
#   message 'Installing \'Basic\' packages'
#   level :warn
# end

package %w(
  adduser
  apt
  apt-listchanges
  apt-transport-https
  apt-utils
  bash
  bash-completion
  easy-rsa
  galculator
  gnupg
  gnupg-agent
  gnupg2
  htop
  ipcalc
  less
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
  recordmydesktop
  rsync
  screen
  scrot
  sed
  sipcalc
  strace
  tree
  xbacklight
  xcompmgr
  xinit
  xorg
  xscreensaver
  xscreensaver-data
  xterm
  zathura
  zathura-pdf-poppler
)

# #
# # Hardware
# #
# log 'message' do
#   message 'Installing \'Hardware\' packages'
#   level :warn
# end

package %w(
  dmidecode
  hwinfo
  pciutils
)

# #
# # Disks & Filesystem
# #
# log 'message' do
#   message 'Installing \'Disks & Filesystems\' packages'
#   level :warn
# end

package %w(
  dmsetup
  dosfstools
  e2fslibs:amd64
  e2fsprogs
  exfat-fuse
  exfat-utils
  fuse
  gdisk
  hdparm
  ntfs-3g
  parted
  sshfs
)

# #
# # Graphics, Sound, Image, and Video
# #
# log 'message' do
#   message 'Installing \'Graphics, Sound, Image, and Video\' packages'
#   level :warn
# end

package %w(
  alsa-utils
  arandr
  exiv2
  feh
  ffmpeg
  ffmpegthumbnailer
  gimp
  gimp-data
  pavucontrol
  pulseaudio
  pulseaudio-module-bluetooth
  pulseaudio-utils
  vlc
)

# #
# # Fonts
# #
# log 'message' do
#   message 'Installing \'Fonts\' packages'
#   level :warn
# end

package %w(
  fontconfig
  fontconfig-config
  fonts-dejavu
  fonts-dejavu-core
  fonts-dejavu-extra
  fonts-droid-fallback
  fonts-freefont-ttf
  fonts-lato
  fonts-liberation
  fonts-lmodern
  fonts-mathjax
  fonts-noto-mono
  fonts-texgyre
)

# #
# # Xmonad
# #
# log 'message' do
#   message 'Installing \'Xmonad\' packages'
#   level :warn
# end

package %w(
  suckless-tools
  xmobar
  xmonad
)

# #
# # Mate
# #
# log 'message' do
#   message 'Installing \'Mate\' packages'
#   level :warn
# end

package %w(
  mate
)

# #
# # Networking
# #
# log 'message' do
#   message 'Installing \'Networking\' packages'
#   level :warn
# end

package %w(
  bridge-utils
  dnsmasq-base
  dnsutils
  ethtool
  filezilla
  filezilla-common
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
  transmission-common
  transmission-gtk
  wireless-regdb
  wireless-tools
  wireshark
  wireshark-common
  wireshark-gtk
  wpasupplicant
)

# FIXME: Add user to 'wireshark' group
# for example `adduser $TARGET_USER wireshark`

# #
# # Bluetooth
# #
# log 'message' do
#   message 'Installing \'Bluetooth\' packages'
#   level :warn
# end
#
# package %w(
#   blueman
#   bluetooth
#   bluez
#   bluez-obexd
#   bluez-tools
# )

# #
# # Files
# #
# log 'message' do
#   message 'Installing \'Files\' packages'
#   level :warn
# end

package %w(
  bzip2
  dos2unix
  file
  gzip
  tar
  unrar
  unzip
  zip
  zlib1g-dev:amd64
  zlib1g:amd64
)

# #
# # Web and Internet
# #
# log 'message' do
#   message 'Installing \'Web and Internet\' packages'
#   level :warn
# end

package %w(
  chromium
  curl
  wget
)
# Not currently used:
# browser-plugin-freshplayer-pepperflash
# firefox-esr
# pepperflashplugin-nonfree

# After installing chromium, I need to "Sign in Chromium"
# for all of my chromium settings to be synced.
# Under chrome://settings/syncSetup, I have selected "Sync everything"

# Chromium does not support sharing screen in Google Meet.
# This is the intended default configuration due to privacy concerns.
#
# To enable screen sharing I must recompile the deb package:
# 1) # apt-get source chromium
# 2) # cd chromium-73.0.3683.75/
# 3) # vim debian/rules
# 4) Change `enable_hangout_services_extension` from `=false` to `=true`
# 5) # apt-get build-dep chromium
# 6) # dpkg-buildpackage -us -uc -nc
# 7) Find the new .deb package in .. and install it
#
# Note: recompilation takes ~3hours.
# Maybe it makes more sense to just use Chrome.
#
# Information extracted from:
# * https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=886358
# * https://stackoverflow.com/questions/25308566/incremental-rebuild-debian-ubuntu-package

#
# Firefox 52.9.0 esr along with vimperator 3.16.0
#
remote_file "#{Chef::Config[:file_cache_path]}/firefox-52.9.0esr.tar.bz2" do
  source 'https://ftp.mozilla.org/pub/firefox/releases/52.9.0esr/linux-x86_64/en-US/firefox-52.9.0esr.tar.bz2'
  mode 644
  # Thu Aug 20 13:41:40 EEST 2020
  # $ sha256sum firefox-52.9.0esr.tar.bz2
  checksum '14df5f5f852dff005c43f8d0a1a772a5112b590e6b3ecc00a81cba9357f45269'
  not_if { File.exists?('/opt/firefox-52.9.0esr/firefox') }
end

execute 'Extract the firefox compressed tarball' do
  command 'tar -xjf firefox-52.9.0esr.tar.bz2'
  cwd "#{Chef::Config[:file_cache_path]}"
  not_if { File.exists?('/opt/firefox-52.9.0esr/firefox') }
end

execute 'Create the firefox directory in /opt' do
  command 'mkdir -p /opt/firefox-52.9.0esr/'
  not_if { File.exists?('/opt/firefox-52.9.0esr/firefox') }
end

execute 'Move the firefox directory to /opt' do
  command 'cp -R firefox/* /opt/firefox-52.9.0esr/'
  cwd "#{Chef::Config[:file_cache_path]}"
  not_if { File.exists?('/opt/firefox-52.9.0esr/firefox') }
end

#
# At this point:
# * firefox is at /opt/firefox-52.9.0esr/firefox
# * I must disable firefox updates
# * I must use the signed .xpi file to install vimperator
#

# #
# # Coding
# #
# log 'message' do
#   message 'Installing \'Coding\' packages'
#   level :warn
# end

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
  python
  python-flake8
  python3
  python3-flake8
  python3-ipdb
  python3-ipython
  vim
)

#
# Chef
#
remote_file "#{Chef::Config[:file_cache_path]}/chef_16.4.41-1_amd64.deb" do
  source 'https://packages.chef.io/files/stable/chef/16.4.41/debian/10/chef_16.4.41-1_amd64.deb'
  mode 644
  # Fri 21 Aug 2020 09:44:39 PM EEST
  # $ sha256sum chef_16.4.41-1_amd64.deb
  checksum 'db49c6acfc16efb43dd11b6ffca591c10112852f6e18f4bfd49366d1c9c896b9'
  not_if { File.exists?('/usr/bin/chef-solo') }
end

execute 'Install the chef infra client deb package' do
  command 'dpkg -i chef_16.4.41-1_amd64.deb'
  cwd "#{Chef::Config[:file_cache_path]}"
  not_if { File.exists?('/usr/bin/chef-solo') }
end

remote_file "#{Chef::Config[:file_cache_path]}/chefdk_4.10.0-1_amd64.deb" do
  source 'https://packages.chef.io/files/stable/chefdk/4.10.0/debian/10/chefdk_4.10.0-1_amd64.deb'
  mode 644
  # Fri 21 Aug 2020 09:44:39 PM EEST
  # $ sha256sum chefdk_4.10.0-1_amd64.deb
  checksum '33528c95302999b07057135205dfcf59474bfcc33896dd4eae80a54581d25928'
  not_if { File.exists?('/usr/bin/berks') }
end

execute 'Install the chef infra client deb package' do
  command 'dpkg -i chefdk_4.10.0-1_amd64.deb'
  cwd "#{Chef::Config[:file_cache_path]}"
  not_if { File.exists?('/usr/bin/berks') }
end

# #
# # IM
# #
# log 'message' do
#   message 'Installing \'IM\' packages'
#   level :warn
# end
#
# package %w(
#   skypeforlinux
#   slack-desktop
# )

#
# Slack
#
remote_file "#{Chef::Config[:file_cache_path]}/slack.deb" do
  source 'https://downloads.slack-edge.com/linux_releases/slack-desktop-4.8.0-amd64.deb'
  mode 644
  # Thu Aug 20 12:47:16 EEST 2020
  # $ sha256sum slack-desktop-4.8.0-amd64.deb
  checksum '60febe824334cbc33e4c63e7ac133a53efc325447405fc8a3ffa426ecbbf1861'
  not_if { File.exists?('/usr/bin/slack') }
end

dpkg_package 'Install Slack from .deb package' do
  source "#{Chef::Config[:file_cache_path]}/slack.deb"
  action :install
  not_if { File.exists?('/usr/bin/slack') }
end

# Maybe opt for `slack-desktop` Debian package ?
# Consider using slack-desktop=4.0.0 to avoid the Alt+Shift bug
# https://github.com/electron/electron/issues/11106
# https://github.com/electron/electron/issues/22213

# #
# # Tex
# #
# log 'message' do
#   message 'Installing \'Tex\' packages'
#   level :warn
# end

package %w(
  texlive-full
)
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

# #
# # VMs
# #
# log 'message' do
#   message 'Installing \'VMs\' packages'
#   level :warn
# end
#
# package %w(
#   virtualbox-6.0
#   vagrant
# )

# #
# # Java
# #
# log 'message' do
#   message 'Installing \'Java\' packages'
#   level :warn
# end
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
# )

# #
# # Windows Utilities
# #
# log 'message' do
#   message 'Installing \'Windows Utilities\' packages'
#   level :warn
# end

package %w(
  freerdp-x11
  rdesktop
)

# TODO:
# * install/configure/run Dropbox
# * install Docker
# * configure sudo
# * install virtualbox
# * install viber

#
# Graphviz
#
package %w(
  graphviz
)
