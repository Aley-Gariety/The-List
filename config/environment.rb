# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ThelistIo::Application.initialize!

#Production
ENV['RAILS_ENV'] ||= 'production'
