require 'spec_helper'
require './lib/renuo/bin-check/output_printer'

RSpec.describe RenuoBinCheck::OutputPrinter do
  let(:printer) { RenuoBinCheck::OutputPrinter.new }
  let(:results) { [build(:failed_result), build(:result)] }

  it 'prints the given output' do
    expect { printer.print_output(results) }.to output("I have been running\nNow I'm tired\n").to_stdout
  end

  it 'prints the given error-output' do
    expect { printer.print_error_output(results) }.to output("I couldn't run :'(\nplease motivate me to\n").to_stderr
  end
end
