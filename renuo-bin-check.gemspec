# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'renuo_bin_check/version'

Gem::Specification.new do |spec|
  spec.name = 'renuo-bin-check'
  spec.version = RenuoBinCheck::VERSION
  spec.authors = ['Zora Fuchs']
  spec.email = ['zora.fuchs@renuo.ch']

  spec.summary = 'The Renuo bin-check automates running programms to check code quality of a ruby application. For faster runtime it makes use of cashing and parallel execution.'
  spec.description = 'The Renuo bin-check automates running programms to check code quality of a ruby application. For faster runtime it makes use of cashing and parallel execution.'
  spec.homepage = 'https://github.com/renuo/renuo-bin-check'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.add_development_dependency 'rubocop',                      '>= 0.39.0'
  spec.add_development_dependency 'reek',                         '>= 4.0.2'
  spec.add_development_dependency 'rspec',                        '>= 3.4.0'
  spec.add_development_dependency 'pry',                          '>= 0.10.3'
  spec.add_development_dependency 'byebug',                       '>= 8.2.5'
  spec.add_development_dependency 'pry-byebug',                   '>= 3.3.0'
  spec.add_development_dependency 'simplecov',                    '>= 0.11.2'
  spec.add_development_dependency 'awesome_print',                '>= 1.6.1'
  spec.add_development_dependency 'factory_girl',                 '>= 4.7.0'
  spec.add_development_dependency 'codeclimate-test-reporter',    '>= 0.5.0'
end
