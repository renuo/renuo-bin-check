require 'spec_helper'
require './lib/renuo/bin-check/script_config'

RSpec.describe RenuoBinCheck::ScriptConfig do
  let(:script) { RenuoBinCheck::ScriptConfig.new }

  it 'sets command' do
    script.command 'super cool command'
    expect(script.script_command).to eq('super cool command')
  end

  it 'sets files' do
    script.files(['first file', 'second file'])
    expect(script.script_files).to eq(['first file', 'second file'])
  end

  it 'sets name and returns it' do
    script.name('nice_script')
    expect(script.script_name).to eq('nice_script')
  end

  it 'sets reversed_exit' do
    script.reversed_exit(true)
    expect(script.reversed_exit?).to be_truthy
  end

  context 'params not set' do
    it 'returns name that is hashed script_command' do
      script = RenuoBinCheck::ScriptConfig.new
      script.command 'super cool command'
      expect(script.script_name).to eq('b4ba9254f12d6385060ae4a2c32084e2')
    end

    it 'raises a RuntimeError' do
      script = RenuoBinCheck::ScriptConfig.new
      expect { script.script_command }.to raise_error(RuntimeError, 'There must be a command set for each script you' \
' want to run. Find further instruction on how to use this Gem here in the Readme: https://github.com/renuo/renuo-bin-'\
'check')
    end

    it 'returns empty string' do
      script = RenuoBinCheck::ScriptConfig.new
      script.command 'super cool command'
      expect(script.script_files).to be_falsey
    end
  end
end
