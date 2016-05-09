require 'spec_helper'
require './lib/renuo/bin-check/cacher'

RSpec.describe RenuoBinCheck::Cacher do
  let(:result_attributes) { attributes_for(:result) }
  let(:result) { build(:result) }
  let(:cacher) { build(:cacher) }

  context 'results are cashed' do
    it 'returns result' do
      expect(cacher.result).to have_attributes(result_attributes)
    end
  end

  context 'cashes do not exist' do
    let(:cacher) { build(:not_found_cacher) }
    it 'returns new hash' do
      expect(cacher.result).to eq('f75c3cee2826ea881cb41b70b2d333b1')
    end
  end

  it 'saves result to files' do
    cacher.cache('f75c5cee2826ea881cb81b70b2d333b7', result)
    expect(File.read('./tmp/bin-check/script_name/f75c5cee2826ea881cb81b70b2d333b7/error_output'))
      .to eq(result.error_output)
    expect(File.read('./tmp/bin-check/script_name/f75c5cee2826ea881cb81b70b2d333b7/output'))
      .to eq(result.output)
    expect(File.read('./tmp/bin-check/script_name/f75c5cee2826ea881cb81b70b2d333b7/exit_code').to_i)
      .to eq(result.exit_code)
  end
end
