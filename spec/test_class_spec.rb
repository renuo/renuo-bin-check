require 'spec_helper'
require './lib/renuo/bin-check/app/test_class'

RSpec.describe 'simple test' do
  it 'should return true' do
    test_class = TestClass.new
    expect(test_class.true_method).to be_truthy
  end
end
