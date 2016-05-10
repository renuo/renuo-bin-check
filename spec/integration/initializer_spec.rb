require 'spec_helper'
require './lib/renuo/bin-check/initializer'

RSpec.describe RenuoBinCheck::Initializer do
  let(:bin_check) { RenuoBinCheck::Initializer.new }

  context 'passing script' do
    after(:each) { FileUtils.remove_dir('./tmp/bin-check/exit0') }

    it 'runns the whole application as expected' do
      bin_check.check do |config|
        config.command './spec/spec-files/test_script_exit0'
        config.name 'exit0'
        config.files %w(file1 file2)
      end
      expect do
        begin
          bin_check.run
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("I passed\nThis is the second line\n").to_stdout
    end
  end

  context 'failing script' do
    after(:each) { FileUtils.remove_dir('./tmp/bin-check/exit1') }

    it 'runns the whole application as expected' do
      bin_check.check do |config|
        config.command './spec/spec-files/test_script_exit1'
        config.files %w(file1 file2)
        config.name 'exit1'
      end
      expect do
        begin
          bin_check.run
        rescue SystemExit => se
          expect(se.status).to eq(1)
        end
      end.to output("I failed\nThis is the second line\n").to_stderr
    end
  end

  context 'cached script' do
    before(:each) do
      FileUtils.mkdir_p 'tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019'
      File.write 'tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/output',
                 "I'm cached\npassed\n"
      File.write 'tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/error_output',
                 "I'm cached\npassed\n"
      File.write 'tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/exit_code', 0
    end

    after(:each) { FileUtils.remove_dir('./tmp/bin-check/exit0') }

    it 'runns the whole application as expected' do
      bin_check.check do |config|
        config.command './spec/spec-files/test_script_exit0'
        config.files %w(./spec/spec-files/file1 ./spec/spec-files/file2)
        config.name 'exit0'
      end
      expect do
        begin
          bin_check.run
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("I'm cached\npassed\n").to_stdout
    end
  end
end
