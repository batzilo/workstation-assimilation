# The Zion recipe.
# Install everything that is useful for zion.vsoul.net.

# Install all CLI tools.
include_recipe 'assimilation::cli'

# Install the nginx HTTP server.
include_recipe 'assimilation::nginx'
