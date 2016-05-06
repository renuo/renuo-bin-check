require 'spec_helper'
require './lib/renuo/bin-check/initializer'

RSpec.describe RenuoBinCheck::Initializer do
  let(:bin_check) { RenuoBinCheck::Initializer.new }
  it 'creates a MasterThread if it is initialized' do
    expect(bin_check.runner.class).to eq(RenuoBinCheck::MasterThread)
  end

  it 'creates ScriptConfig and adds it to runner' do
    bin_check.check do |config|
      config.command 'blubb'
      config.files %w(file1 file2)
    end
    expect(bin_check.runner.threads).to_not be_empty
  end

  it 'makes runner handle the threads' do
    expect(bin_check.runner).to receive(:finalize)
    bin_check.run
  end
end
