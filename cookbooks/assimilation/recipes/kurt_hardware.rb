# vim: set nospell:

# Install packages for video acceleration.
# https://wiki.debian.org/HardwareVideoAcceleration
package %w(
  i965-va-driver
  vainfo
) do
  action :upgrade
end

# Install packages for video acceleration for Chromium.
# https://wiki.debian.org/Chromium
package %w(
  i965-va-driver-shaders
  libva-drm2
  libva-x11-2
) do
  action :upgrade
end

# intel_gpu_top will show the video engine being
# used if hardware video acceleration is working.
# So long as it is above 0%, it is working.
package %w(
  intel-gpu-tools
) do
  action :upgrade
end
