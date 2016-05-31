require 'spec_helper'
require './lib/renuo/bin-check/servant_thread'

RSpec.describe RenuoBinCheck::ServantThread do
  let(:cacher) { build :not_found_cacher }
  let(:result_attributes) { attributes_for :result }
  context 'initializing' do
    let(:script) { build :script }
    it 'initializes the instance variable script with the given ScriptConfig' do
      servant = RenuoBinCheck::ServantThread.new(script)
      expect(servant.script_config).to eq(script)
    end

    it 'initializes cacher with script_name' do
      expect(script).to receive(:script_name).and_return('nice name')
      RenuoBinCheck::ServantThread.new(script)
    end
  end

  context 'running successfully' do
    let(:script) { build :passing_script }
    let(:servant) { RenuoBinCheck::ServantThread.new(script) }

    after(:each) { FileUtils.remove_dir('./tmp/bin-check/exit0') }

    it 'starts the command defined in ScriptConfig and returns a Result' do
      expect(servant.run).to have_attributes(result_attributes)
    end
  end

  context 'without file' do
    let(:script) { build :without_files_script }
    let(:servant) { RenuoBinCheck::ServantThread.new(script) }

    it 'starts the command defined in ScriptConfig and returns a Result' do
      expect(servant.run).to have_attributes(result_attributes)
    end
  end

  context 'with reversed_exit' do
    let(:script) { build :reversed_exit_script }
    let(:servant) { RenuoBinCheck::ServantThread.new(script) }
    let(:result_attributes) { attributes_for :reversed_exit_result }

    after(:each) { FileUtils.remove_dir('./tmp/bin-check/exit0') }

    it 'starts the command defined in ScriptConfig and returns a Result' do
      expect(servant.run).to have_attributes(result_attributes)
    end
  end

  context 'finding cache' do
    let(:script) { build :cached_script }
    let(:servant) { RenuoBinCheck::ServantThread.new(script) }

    before(:each) do
      FileUtils.mkdir_p 'tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019'
      File.write 'tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019/output',
                 "I passed\nThis is the second line\n"
      File.write 'tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019/error_output',
                 "I failed\nThis is the second line\n"
      File.write 'tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019/exit_code', 0
    end

    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }

    it 'gets result from cache' do
      expect(servant.run).to have_attributes(result_attributes)
    end
  end

  context 'overridden output and error_output' do
    let(:script) { build :with_overridden_output_script }
    let(:servant) { RenuoBinCheck::ServantThread.new(script) }

    let(:result_attributes) { attributes_for :overridden_output_result }

    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }

    it 'uses overridden output' do
      expect(servant.run).to have_attributes(result_attributes)
    end
  end

  context 'appended output and error_output' do
    let(:script) { build :with_appended_output_script }
    let(:servant) { RenuoBinCheck::ServantThread.new(script) }

    let(:result_attributes) { attributes_for :appended_output_result }

    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }

    it 'uses overridden output' do
      expect(servant.run).to have_attributes(result_attributes)
    end
  end
end
