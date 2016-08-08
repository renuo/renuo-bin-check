require 'spec_helper'
require './lib/renuo_bin_check/dsl_config'

RSpec.describe DSLConfig do
  it 'gets the right infos out of a new check' do
    dsl_config = DSLConfig.new('rspec') do
      files 'lib/**/*.rb'
      command 'rubocop'
      reversed_exit false
    end

    expect(dsl_config.configs).to eq({name: 'rspec', files: 'lib/**/*.rb', command: 'rubocop', reversed_exit: false})
  end

  it 'creates new children if there are nested checks' do
    dsl_config = DSLConfig.new('ruby_files') do
      files 'lib/**/*.rb'
      rubocop do
        command 'rubocop'
        reversed_exit false
      end
      error_message 'an error occured'
      p_finder do
        command 'find p'
        reversed_exit true
      end
    end

    expect(dsl_config.configs).to eq({name: 'ruby_files', files: 'lib/**/*.rb', error_message: 'an error occured'})
    expect(dsl_config.children.first.configs).to eq({name: 'rubocop', command: 'rubocop', reversed_exit: false})
    expect(dsl_config.children[1].configs).to eq({name: 'p_finder', command: 'find p', reversed_exit: true})
  end

  it 'method_missing calls super if no block is given' do
    expect { DSLConfig.new('ruby_files'){ blubb } }.to raise_error(NameError)
  end
end
