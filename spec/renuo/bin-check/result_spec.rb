require 'spec_helper'
require './lib/renuo/bin-check/result'

RSpec.describe RenuoBinCheck::Result do
  let(:result) { RenuoBinCheck::Result.new('heyaa', 'noooo', 0) }

  it 'initializes output with given output' do
    expect(result.output).to eq('heyaa')
  end

  it 'initializes error_output with given error_output' do
    expect(result.error_output).to eq('noooo')
  end

  it 'initializes exit_code with given output' do
    expect(result.exit_code).to eq(0)
  end
end
