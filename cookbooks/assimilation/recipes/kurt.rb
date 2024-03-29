# The Kurt recipe.
# Install everything that is useful for kurt.vsoul.net.

# Install all CLI tools.
include_recipe 'assimilation::cli'

# Install the GUI stuff.
include_recipe 'assimilation::gui'

# Install the Kurt-specific stuff.
include_recipe 'assimilation::kurt_backlight_udev'
include_recipe 'assimilation::kurt_hardware'
