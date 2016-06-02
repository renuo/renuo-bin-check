require 'spec_helper'
require './lib/renuo/bin-check/master_thread'

RSpec.describe RenuoBinCheck::MasterThread do
  let(:script) { build :script }
  let(:printer) { RenuoBinCheck::Printer.new }
  let(:master) { RenuoBinCheck::MasterThread.new(printer) }

  it 'should add a serventThread when add_thread is called' do
    master.add_thread(script)
    expect(master.threads.size).to eq(1)
    expect(master.threads.first.class).to eq(Thread)
  end

  it 'initializes the instance variable threads as empty array' do
    expect(master.threads.empty?).to be_truthy
  end

  context 'one script fails' do
    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }
    it 'exits with exit code 1' do
      master.add_thread(build(:passing_script))
      master.add_thread(build(:failing_script))
      expect(master.printer).to receive(:print_error_output)
      begin
        master.finalize
      rescue SystemExit => se
        expect(se.status).to eq(1)
      end
    end
  end

  context 'all scripts pass' do
    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }
    it 'exits with exit code 0' do
      master.add_thread(build(:passing_script))
      master.add_thread(build(:passing_script))
      expect(master.printer).to receive(:print_standard_output)
      begin
        master.finalize
      rescue SystemExit => se
        expect(se.status).to eq(0)
      end
    end
  end
end
