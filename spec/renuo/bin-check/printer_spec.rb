require 'spec_helper'
require './lib/renuo/bin-check/printer'

RSpec.describe RenuoBinCheck::Printer do
  let(:printer) { RenuoBinCheck::Printer.new }
  let(:result) { build(:failed_result) }
  let(:results) { [build(:result), build(:result)] }

  it 'prints the given output' do
    expect { printer.print_output(results) }.to output("I passed\nThis is the second line\n" \
                                                        "I passed\nThis is the second line\n").to_stdout
  end

  it 'prints the given error-output' do
    expect { printer.print_error_output(result) }.to output("I failed\nThis is the second line\n").to_stderr
  end
end
