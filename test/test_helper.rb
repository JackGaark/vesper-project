ENV['RAILS_ENV'] ||= 'test'
ENV['FB_ID'] ||= 'test-facebook-id'
ENV['FB_SECRET'] ||= 'test-facebook-secret'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
