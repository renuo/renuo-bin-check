require 'spec_helper'
require './lib/renuo/bin-check/master_thread'

RSpec.describe RenuoBinCheck::MasterThread do
  let(:script) { build :script }
  let(:master) { RenuoBinCheck::MasterThread.new }
  it 'should add a serventThread when add_thread is called' do
    master.add_thread(script)
    expect(master.threads.size).to eq(1)
    expect(master.threads.first.class).to eq(Thread)
  end

  it 'initializes the instance variable threads as empty array' do
    expect(master.threads.empty?).to be_truthy
  end

  context 'one script fails' do
    it 'exits with exit code 1' do
      master.add_thread(build(:passing_script))
      master.add_thread(build(:failing_script))
      begin
        master.finalize
      rescue SystemExit => se
        expect(se.status).to eq(1)
      end
    end
  end

  context 'all scripts pass' do
    it 'exits with exit code 0' do
      master.add_thread(build(:passing_script))
      master.add_thread(build(:passing_script))
      begin
        master.finalize
      rescue SystemExit => se
        expect(se.status).to eq(0)
      end
    end
  end
end
