require 'spec_helper'
require './lib/renuo/bin-check/initializer'

RSpec.describe RenuoBinCheck::Initializer do
  let(:bin_check) { RenuoBinCheck::Initializer.new }

  it 'creates a MasterThread when it is initialized' do
    expect(bin_check.runner.class).to eq(RenuoBinCheck::MasterThread)
  end

  it 'creates ScriptConfig and adds it to runner' do
    bin_check.check do |config|
      config.command 'blubb'
      config.files %w(file1 file2)
    end
    expect(bin_check.runner.threads.last.class).to eq(Thread)
  end

  it 'makes runner handle the threads' do
    expect(bin_check.runner).to receive(:finalize)
    bin_check.run
  end

  context 'passing script' do
    it 'runns the whole application as expected' do
      bin_check.check do |config|
        config.command './spec/spec-files/test_script_exit0'
        config.files %w(file1 file2)
      end

      begin
        expect { bin_check.run }.to output("I have been running\nNow I'm tired\n").to_stdout
      rescue SystemExit => se
        expect(se.status).to eq(0)
      end
    end
  end

  context 'failing script' do
    it 'runns the whole application as expected' do
      bin_check.check do |config|
        config.command './spec/spec-files/test_script_exit1'
        config.files %w(file1 file2)
      end

      begin
        expect { bin_check.run }.to output("I couldn't run :'(\nplease motivate me to\n").to_stderr
      rescue SystemExit => se
        expect(se.status).to eq(1)
      end
    end
  end
end
