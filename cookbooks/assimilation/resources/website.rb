# vim: set nospell:

provides :website

property :domain_name, String
property :domain_names, String

action :create do
  # Create the directory that will hold the static files.
  execute "Create the /var/www/#{new_resource.domain_name} directory" do
    command "mkdir -p /var/www/#{new_resource.domain_name}"
  end

  # Set the directory owner.
  execute "Set the owner of the /var/www/#{new_resource.domain_name} directory" do
    command "chown -R www-data:www-data /var/www/#{new_resource.domain_name}"
  end

  # Set the permissions on directories.
  execute "Set the permissions on all directories under /var/www/#{new_resource.domain_name} directory" do
    command "find /var/www/#{new_resource.domain_name} -type d -exec chmod 770 {} \\;"
  end

  # Set the permissions on files.
  execute "Set the permissions on all files under /var/www/#{new_resource.domain_name} directory" do
    command "find /var/www/#{new_resource.domain_name} -type f -exec chmod 660 {} \\;"
  end

  # Create the nginx site conf file.
  template "/etc/nginx/sites-available/#{new_resource.domain_name}.conf" do
    source 'etc_nginx_sites-available_foo.conf.erb'
    mode 644
    variables(
      :port => 80,
      :domain_names => new_resource.domain_names,
      :root_dir => "/var/www/#{new_resource.domain_name}",
    )
    # Do not overwrite the file if it's already there, because it may have
    # extra information about SSL from let's encrypt.
    not_if { ::File.exist?("/etc/nginx/sites-available/#{new_resource.domain_name}.conf") }
  end

  # Enable the nginx site.
  # Use the bash resource to utilize the `{foo,bar}` expansion feature.
  bash "Enable the #{new_resource.domain_name} nginx site" do
    code "ln -s /etc/nginx/sites-{available,enabled}/#{new_resource.domain_name}.conf"
    # Do not try create the symlink if it's already there.
    not_if { ::File.exist?("/etc/nginx/sites-enabled/#{new_resource.domain_name}.conf") }
  end
end
