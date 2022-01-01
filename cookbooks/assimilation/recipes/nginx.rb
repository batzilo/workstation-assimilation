# vim: set nospell:

package %w(
  nginx
) do
  action :upgrade
end

# Add users to the www-data group.
%w[batzilo].each do |user|
  # Add user to www-data group
  group "www-data_add_#{user}" do
    append true
    group_name 'www-data'
    members user
    action :manage
    only_if "getent passwd #{user}"
  end
end

execute 'Disable the default nginx site' do
  command 'rm /etc/nginx/sites-enabled/default'
  only_if { ::File.exist?('/etc/nginx/sites-enabled/default') }
end

# Install the Python 3 dependencies for the `python3-certbot-nginx` package.
package %w(
  python3-acme
  python3-certbot
  python3-mock
  python3-openssl
  python3-pkg-resources
  python3-pyparsing
  python3-zope.interface
) do
  action :upgrade
end

# Install the `python3-certbot-nginx` package.
package %w(
  python3-certbot-nginx
) do
  action :upgrade
end

# You can now run `# certbot --nginx` to obtain SSL certificates.
