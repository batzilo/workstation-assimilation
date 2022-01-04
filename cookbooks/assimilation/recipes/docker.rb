# vim: set nospell:

execute 'docker_gpg_key' do
  command 'curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -'
  not_if { ::File.exist?('/usr/bin/docker') }
end

execute 'docker_apt_repository' do
  command 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable"'
  not_if { ::File.exist?('/usr/bin/docker') }
end

execute 'docker_apt_update' do
  command 'apt update'
end

# Install Docker.
package %w(
  docker-ce
  docker-ce-cli
  containerd.io
) do
  action :upgrade
end

# Add users to the docker group.
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

# Install docker compose.
%w[batzilo].each do |user|
  # Create the `~/.docker` directory.
  execute 'mkdir -p ~/.docker/cli-plugins/' do
    command "mkdir -p /home/#{user}/.docker/cli-plugins/"
    user user
    not_if { ::File.exist?("/home/#{user}/.docker/cli-plugins/docker-compose") }
  end

  # Download the `docker compose` binary from GitHub.
  execute 'Download the docker compose binary from GitHub' do
    command "curl -SL https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-linux-x86_64 -o /home/#{user}/.docker/cli-plugins/docker-compose"
    user user
    not_if { ::File.exist?("/home/#{user}/.docker/cli-plugins/docker-compose") }
  end

  # Make the `docker compose` binary executable.
  execute 'Apply executable permissions to the docker compose binary' do
    command "chmod +x /home/#{user}/.docker/cli-plugins/docker-compose"
    user user
  end

  # Check if `docker compose` was installed successfully.
  execute 'Check the docker compose version' do
    command 'docker compose version'
    returns 0
    user user
    environment ({
      'HOME' => "/home/#{user}",
      'USER' => user,
    })
  end
end
