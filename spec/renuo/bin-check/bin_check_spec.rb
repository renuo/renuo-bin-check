require 'spec_helper'
require './lib/renuo_bin_check/bin_check'

RSpec.describe BinCheck do
  it 'gets the right infos out of a new check' do
    expect(
      BinCheck.run do
        rubocop do
          files 'lib/**/*.rb'
          command 'rubocop'
          reversed_exit false
        end

        todo_finder do
          files 'lib/**/*.*'
          command 'blubb-blubb'
          reversed_exit true
        end
      end
    ).to eq(rubocop: {files: 'lib/**/*.rb', command: 'rubocop', reversed_exit: false}, todo_finder: {files: 'lib/**/*.*', command: 'blubb-blubb', reversed_exit: true})
  end
end
