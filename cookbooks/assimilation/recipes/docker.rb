# vim: set nospell:

execute 'docker_gpg_key' do
  command 'curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -'
  not_if { ::File.exist?('/usr/bin/docker') }
end

execute 'docker_apt_repository' do
  command 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable"'
  not_if { ::File.exist?('/usr/bin/docker') }
end

execute 'docker_apt_update' do
  command 'apt update'
end

package %w(
  docker-ce
  docker-ce-cli
  containerd.io
) do
  action :upgrade
end

%w[batzilo].each do |user|
  # Add user to docker group
  group "docker_add_#{user}" do
    append true
    group_name 'docker'
    members user
    action :manage
    only_if "getent passwd #{user}"
  end
end
