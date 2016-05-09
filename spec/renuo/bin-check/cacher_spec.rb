require 'spec_helper'
require './lib/renuo/bin-check/cacher'

RSpec.describe RenuoBinCheck::Cacher do
  let(:cacher) { RenuoBinCheck::Cacher.new }
  let(:result_attributes) { attributes_for(:result) }
  let(:result) { build(:result) }

  context 'results are cashed' do
    it 'returns result' do
      expect(cacher.result(['./spec/spec-files/file1', './spec/spec-files/file2'],
                           'script-name')).to have_attributes(result_attributes)
    end
  end

  context 'cashes do not exist' do
    it 'returns new hash' do
      expect(cacher.result(['./spec/spec-files/file2', './spec/spec-files/file1'], 'script2-name'))
        .to eq('f75c3cee2826ea881cb41b70b2d333b1')
    end
  end

  it 'saves result to files' do
    cacher.cache(result, 'script-name', 'f75c5cee2826ea881cb81b70b2d333b7')
    expect(File.read('./tmp/bin-check/script-name/f75c5cee2826ea881cb81b70b2d333b7/error_output'))
      .to eq(result.error_output)
    expect(File.read('./tmp/bin-check/script-name/f75c5cee2826ea881cb81b70b2d333b7/error_output'))
      .to eq(result.error_output)
    expect(File.read('./tmp/bin-check/script-name/f75c5cee2826ea881cb81b70b2d333b7/error_output'))
      .to eq(result.error_output)
  end
end
