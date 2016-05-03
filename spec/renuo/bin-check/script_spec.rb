require 'spec_helper'
require './lib/renuo/bin-check/script'

RSpec.describe RenuoBinCheck::Script do
  it 'sets command' do
    script = RenuoBinCheck::Script.new
    script.command 'super cool command'
    expect(script.script_command).to eq('super cool command')
  end

  it 'sets files' do
    script = RenuoBinCheck::Script.new
    script.files(['first file', 'second file'])
  end
end
