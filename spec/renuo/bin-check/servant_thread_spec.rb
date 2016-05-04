require 'spec_helper'
require './lib/renuo/bin-check/servant_thread'

RSpec.describe RenuoBinCheck::ServantThread do
  let(:script) { build :script }
  it 'initializes the instance variable script with the given ScriptConfig' do
    servant = RenuoBinCheck::ServantThread.new(script)
    expect(servant.script).to eq(script)
  end
end
