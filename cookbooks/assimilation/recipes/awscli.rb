# vim: set nospell:

remote_file "#{Chef::Config[:file_cache_path]}/awscliv2.zip" do
  source 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
  mode 644
  not_if { ::File.exist?('/usr/local/bin/aws') }
end

execute 'Unzip awscliv2.zip file' do
  command 'unzip awscliv2.zip'
  cwd "#{Chef::Config[:file_cache_path]}"
  not_if { ::File.exist?('/usr/local/bin/aws') }
end

execute 'Install awscli v2' do
  command './aws/install'
  cwd "#{Chef::Config[:file_cache_path]}"
  not_if { ::File.exist?('/usr/local/bin/aws') }
end
