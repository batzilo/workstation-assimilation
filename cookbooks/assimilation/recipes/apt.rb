# vim: set nospell:

template '/etc/apt/sources.list' do
  source 'apt_sources_list.erb'
  mode 644
end

# # Include the apt::default recipe (so that `apt-get update` is added to the collection)
# include_recipe 'apt'
#
# # Load the `apt-get update` resource from the collection and run it
# resources(execute: 'apt-get update').run_action(:run)
execute 'Run apt update' do
  command 'apt update'
end
