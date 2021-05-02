# The default recipe.
# Install everything.

# Install all CLI tools.
include_recipe 'assimilation::cli'

# Install the GUI stuff.
include_recipe 'assimilation::gui'
