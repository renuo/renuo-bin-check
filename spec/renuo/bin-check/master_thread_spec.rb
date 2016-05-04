require 'spec_helper'
require './lib/renuo/bin-check/master_thread'

RSpec.describe RenuoBinCheck::MasterThread do
  let(:script) { build :script }
  it 'should add a thread when add_thread is called' do
    master = RenuoBinCheck::MasterThread.new
    master.add_thread(script)
    expect(master.threads.size).to eq(1)
  end

  it 'inizializes the instance variable threads as empty array' do
    master = RenuoBinCheck::MasterThread.new
    expect(master.threads.empty?).to be_truthy
  end
end
