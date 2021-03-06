require 'spec_helper'
require './lib/renuo_bin_check/bin_check'

RSpec.describe BinCheck do
  it 'gets the right infos out of a new check' do
    expect(BinCheck).to receive(:initialize_checks).and_return(true)
    expect_any_instance_of(DefaultScripts).to receive(:rails_defaults).and_return([])

    BinCheck.run do
      rubocop do
        files 'lib/**/*.rb'
        command 'rubocop'
        reversed_exit false
      end

      t0d0_finder do
        files 'lib/**/*.*'
        command 'blubb-blubb'
        reversed_exit true
      end
    end

    expect(BinCheck.configs.first.configs)
      .to eq(name: 'rubocop', files: 'lib/**/*.rb', command: 'rubocop', reversed_exit: false)
    expect(BinCheck.configs[1].configs)
      .to eq(name: 't0d0_finder', files: 'lib/**/*.*', command: 'blubb-blubb', reversed_exit: true)
  end

  it 'understands common configs' do
    expect(BinCheck).to receive(:initialize_checks).and_return(true)
    expect_any_instance_of(DefaultScripts).to receive(:rails_defaults).and_return([])

    BinCheck.run do
      ruby_files do
        files 'lib/**/*.rb'
        rubocop do
          command 'rubocop'
          reversed_exit false
        end
        p_finder do
          command 'blubb-blubb'
          reversed_exit true
        end
      end
    end
    expect(BinCheck.configs.first.configs.merge(BinCheck.configs.first.children.first.configs))
      .to eq(name: 'rubocop', files: 'lib/**/*.rb', command: 'rubocop', reversed_exit: false)
    expect(BinCheck.configs.first.configs.merge(BinCheck.configs.first.children[1].configs))
      .to eq(name: 'p_finder', files: 'lib/**/*.rb', command: 'blubb-blubb', reversed_exit: true)
  end

  it 'excluds unwanted default checks' do
    expect(BinCheck).to receive(:initialize_checks).and_return(true)

    BinCheck.run do
      exclude :config_log
    end

    BinCheck.configs.each do |config|
      expect(config.configs).not_to include(name: 'config_log')
    end
  end

  it 'calls super if no block is given' do
    expect { BinCheck.blubb }.to raise_error(NoMethodError)
  end
end
