# vim: set nospell:

# Install packages for video acceleration for Chromium.
# https://wiki.debian.org/Chromium
package %w(
  i965-va-driver-shaders
  libva-drm2
  libva-x11-2
) do
  action :upgrade
end
