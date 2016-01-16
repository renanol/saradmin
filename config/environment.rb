# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Formatações de Data
Date::DATE_FORMATS[:br] = "%d/%m/%Y"