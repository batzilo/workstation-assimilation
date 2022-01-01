# The Zion recipe.
# Install everything that is useful for zion.vsoul.net.

# Install all CLI tools.
include_recipe 'assimilation::cli'

# Install the nginx HTTP server.
include_recipe 'assimilation::nginx'

# Set up the zion.vsoul.net website.
include_recipe 'assimilation::zion_vsoul_net'

# Set up the vsoul.net website.
include_recipe 'assimilation::vsoul_net'
