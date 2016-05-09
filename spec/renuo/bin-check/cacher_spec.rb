require 'spec_helper'
require './lib/renuo/bin-check/cacher'

RSpec.describe RenuoBinCheck::Cacher do
  let(:cacher) { RenuoBinCheck::Cacher.new }
  let(:result) { attributes_for(:result) }

  context 'results are cashed' do
    it 'returns result' do
      expect(cacher.result(['./spec/spec-files/file1', './spec/spec-files/file2'],
                           'script-name')).to have_attributes(result)
    end
  end

  context 'cashes do not exist' do
    it 'returns nil' do
      expect(cacher.result(['./spec/spec-files/file2', './spec/spec-files/file1'], 'script2-name')).to be_falsey
    end
  end
end
