# The CLI recipe.
# Install everything that is useful from the command line.

# Manually setup apt sources.
include_recipe 'assimilation::apt'

# Install CLI tools.
include_recipe 'assimilation::tools'

# Install awscli.
include_recipe 'assimilation::awscli'

# Install Chef.
include_recipe 'assimilation::chef'

# Install docker.
include_recipe 'assimilation::docker'
