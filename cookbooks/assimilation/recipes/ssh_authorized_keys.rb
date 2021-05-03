# vim: set nospell:

execute 'Create the /home/batzilo/.ssh directory' do
  command 'mkdir -p /home/batzilo/.ssh'
end

template '/home/batzilo/.ssh/authorized_keys' do
  source 'ssh_authorized_keys.erb'
  mode 644
end
