source 'https://rubygems.org'

ruby '1.9.3' # for heroku
gem 'rails', '3.2.6'
gem 'haml-rails'
gem 'jquery-rails'
gem 'mongoid', '~> 3.0.0.rc'

gem 'fog'
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'devise'
gem 'simple_form'

#gem 'devise_ldap_authenticatable'


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'chosen-rails'
  gem 'twitter-bootstrap-rails'
end

group :development, :test do
  gem 'spork'
  gem 'capistrano'
  gem 'rspec-rails'
  gem 'mongoid-rspec'
  gem 'fabrication'
  gem 'ffaker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'growl'
end

gem 'database_cleaner', :group => :test
gem 'simplecov', :require => false, :group => :test
