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
  end
end
