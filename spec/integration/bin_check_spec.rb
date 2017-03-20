require 'spec_helper'
require './lib/renuo_bin_check/bin_check'

RSpec.describe BinCheck do
  context 'without caching' do
    it 'returns exit-code 0 and expected output' do
      expect do
        begin
          BinCheck.run :no_defaults do
            exit0_script do
              command './spec/spec-files/test_script_exit0'
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("I passed\nThis is the second line\n").to_stdout
    end

    it 'returns exit-code 0 and expected output' do
      expect do
        begin
          BinCheck.run :no_defaults do
            hello_script do
              command 'echo hello'
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("hello\n").to_stdout
    end

    it 'returns exit-code 0 and expected overridden output' do
      expect do
        begin
          BinCheck.run :no_defaults do
            hello_script do
              command 'echo hello'
              success_message 'I passed :)'
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("I passed :)\n").to_stdout
    end

    it 'returns exit-code 0 and expected appended output' do
      expect do
        begin
          BinCheck.run :no_defaults do
            hello_script do
              command 'echo hello'
              success_message '+I passed :)'
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("hello\nI passed :)\n").to_stdout
    end

    it 'returns exit-code 1 and expected error-output' do
      expect do
        begin
          BinCheck.run :no_defaults do
            exit1_script do
              command './spec/spec-files/test_script_exit1'
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(1)
        end
      end.to output("I failed\nThis is the second line\n").to_stderr
    end

    it 'returns exit-code 1 and expected non-error-output' do
      expect do
        begin
          BinCheck.run :no_defaults do
            exit1_script do
              command './spec/spec-files/test_script_exit1_no_error_output'
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(1)
        end
      end.to output("I failed\nThis is the second line\n").to_stderr
    end

    it 'returns exit-code 1 and expected overridden error-output' do
      expect do
        begin
          BinCheck.run :no_defaults do
            exit1_script do
              command './spec/spec-files/test_script_exit1'
              error_message 'it failed...'
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(1)
        end
      end.to output("it failed...\n").to_stderr
    end

    it 'returns exit-code 1 and expected appended error-output' do
      expect do
        begin
          BinCheck.run :no_defaults do
            exit1_script do
              command './spec/spec-files/test_script_exit1'
              error_message '+it failed...'
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(1)
        end
      end.to output("I failed\nThis is the second line\nit failed...\n").to_stderr
    end

    it 'uses the common configuration right' do
      expect do
        begin
          BinCheck.run :no_defaults do
            cute_scripts do
              success_message '+common configuration'
              hello_script do
                command 'echo hello'
              end
              bye_script do
                command 'sleep 1 && echo bye'
              end
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("hello\ncommon configuration\nbye\ncommon configuration\n").to_stdout
    end

    it 'runns scripts parallel' do
      start_time = Time.now
      begin
        BinCheck.run :no_defaults do
          sleep1 do
            command './spec/spec-files/test_script_sleep1'
          end
          sleep2 do
            command './spec/spec-files/test_script_sleep2'
          end
        end
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
      File.write 'tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/standard_output',
                 "I'm cached\npassed\n"
      File.write 'tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/error_output',
                 "I'm cached\npassed\n"
      File.write 'tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/exit_code', 0
    end

    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }

    it 'returns cached output and exit-code' do
      expect do
        begin
          BinCheck.run :no_defaults do
            exit0 do
              command './spec/spec-files/test_script_exit0'
              files %w(./spec/spec-files/file1 ./spec/spec-files/file2)
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("I'm cached\npassed\n").to_stdout
    end
  end

  context 'saving to exit0 folder' do
    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }

    it 'saves output and exit-code to files in folder named by given name' do
      expect do
        begin
          BinCheck.run :no_defaults do
            exit0 do
              command './spec/spec-files/test_script_exit0'
              files %w(./spec/spec-files/file1 ./spec/spec-files/file2)
            end
          end
        rescue SystemExit => se
          expect(se.status).to eq(0)
        end
      end.to output("I passed\nThis is the second line\n").to_stdout

      expect(File.read('./tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/error_output'))
        .to eq("I failed\nThis is the second line\n")
      expect(File.read('./tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/standard_output'))
        .to eq("I passed\nThis is the second line\n")
      expect(File.read('./tmp/bin-check/exit0/df57ab93c06ded11a01f2de950307019/exit_code').to_i).to eq(0)
    end
  end
end
