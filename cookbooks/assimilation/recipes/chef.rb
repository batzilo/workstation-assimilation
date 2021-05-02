# vim: set nospell:

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
