source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'awesome_print'
gem 'binding_of_caller'
gem 'pry'
gem 'byebug'
gem 'pry-byebug'
gem 'factory_girl'
gem 'rspec'
gem 'simplecov', require: false
gem 'reek', require: false
gem 'rubocop', require: false

eval_gemfile('Gemfile.local.rb') if File.exist?('Gemfile.local.rb')
