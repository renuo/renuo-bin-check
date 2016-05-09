require_relative 'code_climate'
require 'simplecov'
require 'factory_girl'
require 'fileutils'
SimpleCov.start do
  add_group 'App', './lib/renuo/bin-check/app'
end
SimpleCov.minimum_coverage 100

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 5

  config.order = :random

  Kernel.srand config.seed

  config.before(:all) do
    FileUtils.mkdir_p 'tmp/bin-check/script_name/f75c3cee2826ea881cb41b70b2d333b1'
    File.write 'tmp/bin-check/script_name/f75c3cee2826ea881cb41b70b2d333b1/output',
               "I passed\nThis is the second line\n"
    File.write 'tmp/bin-check/script_name/f75c3cee2826ea881cb41b70b2d333b1/error_output',
               "I failed\nThis is the second line\n"
    File.write 'tmp/bin-check/script_name/f75c3cee2826ea881cb41b70b2d333b1/exit_code', 0
  end

  config.after(:all) do
    FileUtils.remove_dir('./tmp/bin-check/script_name')
    FileUtils.remove_dir('./tmp/bin-check/spec')
  end
end
