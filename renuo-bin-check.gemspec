# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'renuo_bin_check/version'

Gem::Specification.new do |spec|
  spec.name = 'renuo-bin-check'
  spec.version = RenuoBinCheck::VERSION
  spec.authors = ['Zora Fuchs']
  spec.email = ['zora.fuchs@renuo.ch']

  spec.summary = 'renuo-bin-check automates running programms to check code quality of a ruby application.'
  spec.description = 'With this gem you can automatically check your code quality (e.g. before every commit). You can configure it to run rubocop, reek, rspec and even custom scripts. For faster runtime it makes use of cashing and parallel execution.'
  spec.homepage = 'https://github.com/renuo/renuo-bin-check'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.add_development_dependency 'awesome_print',                '~> 1.7'
  spec.add_development_dependency 'bundler',                      '~> 1.12'
  spec.add_development_dependency 'byebug',                       '~> 9.0'
  spec.add_development_dependency 'codeclimate-test-reporter',    '~> 0.5'
  spec.add_development_dependency 'factory_girl',                 '~> 4.7'
  spec.add_development_dependency 'pry',                          '~> 0.10'
  spec.add_development_dependency 'pry-byebug',                   '~> 3.3'
  spec.add_development_dependency 'rubocop',                      '~> 0.40'
  spec.add_development_dependency 'rake',                         '~> 10.0'
  spec.add_development_dependency 'reek',                         '~> 4.0'
  spec.add_development_dependency 'rspec',                        '~> 3.4'
  spec.add_development_dependency 'simplecov',                    '~> 0.11'
end
