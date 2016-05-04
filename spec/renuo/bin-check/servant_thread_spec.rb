require 'spec_helper'
require './lib/renuo/bin-check/servant_thread'

RSpec.describe RenuoBinCheck::ServantThread do
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
    let(:result_attributes) { attributes_for :result }

    it 'starts the command defined in ScriptConfig and returns a Result' do
      expect(servant.run).to have_attributes(result_attributes)
    end
  end
end
