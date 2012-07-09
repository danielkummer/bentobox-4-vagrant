require 'spork'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }


ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

  #Rubymine fix http://devblog.avdi.org/2011/04/17/rubymine-spork-rspec-cucumber/
  if ENV["RUBYMINE_HOME"]
    $:.unshift(File.expand_path("rb/testing/patch/common", ENV["RUBYMINE_HOME"]))
    $:.unshift(File.expand_path("rb/testing/patch/bdd", ENV["RUBYMINE_HOME"]))
  end

  # This file is copied to spec/ when you run 'rails generate rspec:install'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'

  Spork.trap_class_method(Rails::Mongoid, :load_models)
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)


  RSpec.configure do |config|
    config.include Mongoid::Matchers

    config.include Devise::TestHelpers, :type => :controller
    config.include Devise::TestHelpers, :type => :helper
    config.extend ControllerMacros, :type => :controller
    config.extend ControllerMacros, :type => :helper

    # Clean up the database
    require 'database_cleaner'
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.orm = "mongoid"
    end
    config.before(:each) do
      DatabaseCleaner.start
    end
    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.mock_with :rspec
    config.infer_base_class_for_anonymous_controllers = false

  end

end


Spork.each_run do
  # This code will be run each time you run your specs.
  Dir["#{File.dirname(__FILE__)}/fabricators/**/*.rb"].each { |e| require e }

  if ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end
end




