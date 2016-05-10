require 'spec_helper'
require './lib/renuo/bin-check/script_config'

RSpec.describe RenuoBinCheck::ScriptConfig do
  it 'sets command' do
    script = RenuoBinCheck::ScriptConfig.new
    script.command 'super cool command'
    expect(script.script_command).to eq('super cool command')
  end

  it 'sets files' do
    script = RenuoBinCheck::ScriptConfig.new
    script.files(['first file', 'second file'])
    expect(script.script_files).to eq(['first file', 'second file'])
  end

  it 'sets name and returns it' do
    script = RenuoBinCheck::ScriptConfig.new
    script.name('nice_script')
    expect(script.script_name).to eq('nice_script')
  end

  context 'params not set' do
    it 'returns name that is hashed script_command' do
      script = RenuoBinCheck::ScriptConfig.new
      script.command 'super cool command'
      expect(script.script_name).to eq('b4ba9254f12d6385060ae4a2c32084e2')
    end
  end
end
