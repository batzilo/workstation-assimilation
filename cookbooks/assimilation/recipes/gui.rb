# vim: set nospell:

#
# X basics
#
package %w(
  recordmydesktop
  redshift
  rxvt-unicode
  scrot
  xbacklight
  xcompmgr
  xinit
  xorg
  xscreensaver
  xscreensaver-data
  xterm
  zathura
  zathura-pdf-poppler
) do
  action :upgrade
end

#
# Sound, Image, and Video
#
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
) do
  action :upgrade
end

#
# Fonts
#
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
) do
  action :upgrade
end

#
# Xmonad
#
package %w(
  suckless-tools
  xmobar
  xmonad
) do
  action :upgrade
end

#
# Mate
#
package %w(
  mate
) do
  action :upgrade
end

#
# Networking GUI
#
package %w(
  filezilla
  filezilla-common
  transmission-common
  transmission-gtk
  wireshark
  wireshark-common
  wireshark-gtk
) do
  action :upgrade
end
# FIXME: Add user to 'wireshark' group
# for example `adduser $TARGET_USER wireshark`

#
# Files GUI
#
package %w(
  thunar
) do
  action :upgrade
end

#
# Web and Internet
#
package %w(
  chromium
) do
  action :upgrade
end
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

#
# IM
#
# package %w(
#   skypeforlinux
#   slack-desktop
# ) do
#   action :upgrade
# end

#
# Slack
#
# remote_file "#{Chef::Config[:file_cache_path]}/slack.deb" do
#   source 'https://downloads.slack-edge.com/linux_releases/slack-desktop-4.8.0-amd64.deb'
#   mode 644
#   # Thu Aug 20 12:47:16 EEST 2020
#   # $ sha256sum slack-desktop-4.8.0-amd64.deb
#   checksum '60febe824334cbc33e4c63e7ac133a53efc325447405fc8a3ffa426ecbbf1861'
#   not_if { File.exists?('/usr/bin/slack') }
# end
#
# dpkg_package 'Install Slack from .deb package' do
#   source "#{Chef::Config[:file_cache_path]}/slack.deb"
#   action :install
#   not_if { File.exists?('/usr/bin/slack') }
# end
#
# Maybe opt for `slack-desktop` Debian package ?
# Consider using slack-desktop=4.0.0 to avoid the Alt+Shift bug
# https://github.com/electron/electron/issues/11106
# https://github.com/electron/electron/issues/22213

#
# Windows Utilities
#
package %w(
  freerdp2-x11
  rdesktop
) do
  action :upgrade
end

# TODO:
# * install viber
