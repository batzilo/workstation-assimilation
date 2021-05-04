# vim: set nospell:

execute 'Backup the original sshd_config file' do
  command 'cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original'
  not_if { ::File.exist?('/etc/ssh/sshd_config.original') }
end

template '/etc/ssh/sshd_config' do
  source 'sshd_config.erb'
  mode 644
end

execute 'Restart the sshd service' do
  command 'systemctl restart sshd'
end
