#
# The solo.rb file is used to specify the configuration details for chef-solo.
#

# Make the path to cookbooks relative to the solo.rb file
cookbook_path File.join(File.expand_path(File.dirname(__FILE__)), 'cookbooks')
