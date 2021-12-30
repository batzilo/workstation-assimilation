# vim: set nospell:

package %w(
  nginx
) do
  action :upgrade
end

template '/etc/nginx/sites-available/zion.vsoul.net.conf' do
  source 'etc_nginx_sites-available_zion.vsoul.net.conf.erb'
  mode 644
  not_if { ::File.exist?('/etc/nginx/sites-available/zion.vsoul.net.conf') }
end

execute 'Disable the default nginx site' do
  command 'rm /etc/nginx/sites-enabled/default'
  only_if { ::File.exist?('/etc/nginx/sites-enabled/default') }
end

execute 'Enable the zion.vsoul.net nginx site' do
  command 'ln -s /etc/nginx/sites-{available,enabled}/zion.vsoul.net.conf'
  not_if { ::File.exist?('/etc/nginx/sites-available/zion.vsoul.net.conf') }
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
