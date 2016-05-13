require 'spec_helper'
require './lib/renuo/bin-check/initializer'

RSpec.describe RenuoBinCheck::Initializer do
  let(:bin_check) { RenuoBinCheck::Initializer.new }

  it 'creates a MasterThread when it is initialized' do
    expect(bin_check.master_thread.class).to eq(RenuoBinCheck::MasterThread)
  end

  it 'creates ScriptConfig and adds it to runner' do
    bin_check.check do |config|
      config.command 'blubb'
      config.files %w(file1 file2)
    end
    expect(bin_check.master_thread.threads.last.class).to eq(Thread)
  end

  it 'makes runner handle the threads' do
    expect(bin_check.master_thread).to receive(:finalize)
    bin_check.run
  end
end
