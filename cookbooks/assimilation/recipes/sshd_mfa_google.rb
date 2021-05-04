# vim: set nospell:

package %w(
  libpam-google-authenticator
) do
  action :upgrade
end

# execute 'Disable password authentication' do
#   command 'sed -i s/^@include common-auth$/#@include common-auth/ /etc/pam.d/sshd'
# end

ruby_block 'Disable password authentication' do
  block do
    line = '@include common-auth'
    file = Chef::Util::FileEdit.new('/etc/pam.d/sshd')
    file.search_file_replace(/^#{line}$/, "# vsoul\n##{line}")
    file.write_file
  end
end

# execute 'Enable the Google Authenticator PAM module' do
#   command 'echo "auth required pam_google_authenticator.so" >> /etc/pam.d/sshd'
#   not_if 'grep -q "auth required pam_google_authenticator.so" /etc/pam.d/sshd'
# end

ruby_block 'Enable the Google Authenticator PAM module' do
  block do
    line = 'auth required pam_google_authenticator.so'
    file = Chef::Util::FileEdit.new('/etc/pam.d/sshd')
    file.insert_line_if_no_match(/#{line}/, "\n# vsoul\n#{line}")
    file.write_file
  end
end

execute 'Restart the sshd service' do
  command 'systemctl restart sshd'
end
