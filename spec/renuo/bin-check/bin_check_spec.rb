require 'spec_helper'
require './lib/renuo_bin_check/bin_check'

RSpec.describe BinCheck do
  it 'gets the right infos out of a new check' do
    expect(BinCheck).to receive(:initialize_checks).and_return(true)

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

    expect(BinCheck.new_script_hash)
      .to eq(rubocop: { files: 'lib/**/*.rb', command: 'rubocop', reversed_exit: false },
             t0d0_finder: { files: 'lib/**/*.*', command: 'blubb-blubb', reversed_exit: true })
  end

  it 'calls super if no block is given' do
    expect { BinCheck.blubb }.to raise_error(NoMethodError)
  end
end
