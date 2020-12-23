# Manually setup apt sources
include_recipe 'assimilation::apt'

# Install packages
include_recipe 'assimilation::packages'

# Install docker
include_recipe 'assimilation::docker'
