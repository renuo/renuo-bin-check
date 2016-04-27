# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'renuo/bin-check/version'

Gem::Specification.new do |spec|
  spec.name = 'renuo-bin-check'
  spec.version = Renuo::BinCheck::VERSION
  spec.authors = ['Zora Fuchs']
  spec.email = ['zora.fuchs@renuo.ch']

  spec.summary = 'The Renuo bin-check automates running programms to check code quality of a rails application'
  spec.description = 'The Renuo bin-check automates running programms to check code quality of a rails application'
  spec.homepage = 'https://github.com/renuo/renuo-bin-check'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.add_development_dependency 'rubocop',          '>= 0.39.0'
  spec.add_development_dependency 'reek',             '>= 4.0.1'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'factory_girl'
  # spec.add_development_dependency 'binding_of_caller'
end
