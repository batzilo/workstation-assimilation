# vim: set nospell:

package %w(
  nginx
) do
  action :upgrade
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
