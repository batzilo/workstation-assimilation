# vim: set nospell:

# Intall the Debian keyboard configuration file.
template '/etc/default/keyboard' do
  source 'etc_default_keyboard.erb'
  mode 644
end
