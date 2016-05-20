require 'spec_helper'
require './lib/renuo/bin-check/initializer'

RSpec.describe RenuoBinCheck::Initializer do
  let(:bin_check) { RenuoBinCheck::Initializer.new }

  context 'without caching' do
    it 'returns exit-code 0 and expected output' do
      bin_check.check do |config|
        config.command './spec/spec-files/test_script_exit0'
      end
      expect do
        begin
          bin_check.run
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("I passed\nThis is the second line\n").to_stdout
    end

    it 'returns exit-code 0 and expected output' do
      bin_check.check do |config|
        config.command 'echo hello'
      end
      expect do
        begin
          bin_check.run
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output.to_stdout
    end

    it 'returns exit-code 1 and expected error-output' do
      bin_check.check do |config|
        config.command './spec/spec-files/test_script_exit1'
      end
      expect do
        begin
          bin_check.run
        rescue SystemExit => se
          expect(se.status).to eq(1)
        end
      end.to output("I failed\nThis is the second line\n").to_stderr
    end

    it 'runns scripts parallel' do
      start_time = Time.now
      bin_check.check { |config| config.command './spec/spec-files/test_script_sleep1' }
      bin_check.check { |config| config.command './spec/spec-files/test_script_sleep2' }
      begin
        bin_check.run
      rescue SystemExit => se
        expect(se.status).to eq(0)
      end
      end_time = Time.now
      expect(end_time - start_time).to be_within(0.4).of(2)
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

    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }

    it 'returns cached output and exit-code' do
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

  context 'saving to exit0 folder' do
    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }

    it 'saves output and exit-code to files in folder named by given name' do
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
      end.to output("I passed\nThis is the second line\n").to_stdout

      expect(File.read('./tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/error_output'))
        .to eq("I failed\nThis is the second line\n")
      expect(File.read('./tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/output'))
        .to eq("I passed\nThis is the second line\n")
      expect(File.read('./tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/exit_code').to_i).to eq(0)
    end
  end

  context 'saving to 65a98809d7447e9857b9acf1fbc89dcc folder' do
    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }

    it 'saves output and exit-code to files in folder named by hashed command' do
      bin_check.check do |config|
        config.command './spec/spec-files/test_script_exit0'
        config.files %w(./spec/spec-files/file1 ./spec/spec-files/file2)
      end
      expect do
        begin
          bin_check.run
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("I passed\nThis is the second line\n").to_stdout

      expect(File.read('./tmp/bin-check/65a98809d7447e9857b9acf1fbc89dcc/'\
                        'df57ab93c06ded11a01f2de950307019/error_output'))
        .to eq("I failed\nThis is the second line\n")
      expect(File.read('./tmp/bin-check/65a98809d7447e9857b9acf1fbc89dcc/df57ab93c06ded11a01f2de950307019/output'))
        .to eq("I passed\nThis is the second line\n")
      expect(File.read('./tmp/bin-check/65a98809d7447e9857b9acf1fbc89dcc/df57ab93c06ded11a01f2de950307019/exit_code')
               .to_i).to eq(0)
    end
  end
end
