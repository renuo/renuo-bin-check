require 'spec_helper'
require './lib/renuo/bin-check/servant_thread'

RSpec.describe RenuoBinCheck::ServantThread do
  let(:cacher) { build :not_found_cacher }
  let(:result_attributes) { attributes_for :result }
  context 'initializing' do
    let(:script) { build :script }
    it 'initializes the instance variable script with the given ScriptConfig' do
      servant = RenuoBinCheck::ServantThread.new(script)
      expect(servant.script).to eq(script)
    end
  end

  context 'running successfully' do
    let(:script) { build :script, script_command: './spec/spec-files/test_script_exit0' }
    let(:servant) { RenuoBinCheck::ServantThread.new(script) }

    it 'starts the command defined in ScriptConfig and returns a Result' do
      expect(servant.run).to have_attributes(result_attributes)
    end
  end

  context 'finding cache' do
    let(:script) do
      build :script, script_command: 'script_name',
                     script_files: ['./spec/spec-files/file1', './spec/spec-files/file2']
    end
    let(:servant) { RenuoBinCheck::ServantThread.new(script) }

    it 'gets result from cache' do
      expect(servant.run).to have_attributes(result_attributes)
    end
  end
end
