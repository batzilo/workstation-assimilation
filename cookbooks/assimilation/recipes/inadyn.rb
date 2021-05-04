# vim: set nospell:

# Install an open source Dynamic DNS client.
# https://github.com/troglobit/inadyn
package %w(
  inadyn
) do
  action :upgrade
end

template '/etc/inadyn.conf' do
  source 'etc_inadyn.erb'
  mode 644
  not_if { File.exists?('/etc/inadyn.conf') }
end

template '/etc/default/inadyn' do
  source 'etc_default_inadyn.erb'
  mode 644
end

execute 'Restart the inadyn service' do
  command 'systemctl restart inadyn'
end
