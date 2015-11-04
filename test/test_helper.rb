ActiveRecord::Migration.maintain_test_schema!
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(user)
      session[:user_id] = users(user).id
  end
    
  def logout
      session.delete :user_id
  end
  
  def setup
      #byebug if self.to_s.include? "DepotShippingTest"
      #byebug if self.to_s.include? "UserStoriesTest"
      
      #if defined? session
      #   puts "Session defined ! #{self.to_s}"
      #else
      #   puts "Session NOT defined ! #{self.to_s}"
      #end    
      #byebug 
      login_as :one if defined? session
      #login_as :one
  end

  # Add more helper methods to be used by all tests here...
end
