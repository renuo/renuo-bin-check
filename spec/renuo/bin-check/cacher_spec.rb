require 'spec_helper'
require './lib/renuo/bin-check/cacher'

RSpec.describe RenuoBinCheck::Cacher do
  let(:result_attributes) { attributes_for(:result) }
  let(:result) { build(:result) }
  let(:cacher) { build(:cacher) }

  context 'results are cashed' do
    before(:each) do
      FileUtils.mkdir_p 'tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019'
      File.write 'tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019/output',
                 "I passed\nThis is the second line\n"
      File.write 'tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019/error_output',
                 "I failed\nThis is the second line\n"
      File.write 'tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019/exit_code', 0
    end

    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }

    it 'returns result' do
      expect(cacher.result).to have_attributes(result_attributes)
    end

    it 'recognizes different file names' do
      cacher = build(:copy_found_cacher)
      expect(cacher.exists?).to be_falsey
    end
  end

  context 'cashes do not exist' do
    let(:cacher) { build(:not_found_cacher) }
    it 'returns new hash' do
      expect(cacher.exists?).to be_falsey
    end
  end

  context 'save results' do
    after(:each) { FileUtils.remove_dir('./tmp/bin-check') }

    it 'saves result to files' do
      cacher.cache(result)
      expect(File.read('./tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019/error_output'))
        .to eq(result.error_output)
      expect(File.read('./tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019/output'))
        .to eq(result.output)
      expect(File.read('./tmp/bin-check/script_name/df57ab93c06ded11a01f2de950307019/exit_code').to_i)
        .to eq(result.exit_code)
    end
  end
end
