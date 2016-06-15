module RenuoBinCheck
  class Printer
    # :reek:UtilityFunction
    def print_standard_output(results)
      results.each { |result| $stdout.puts result.standard_output }
    end

    # :reek:UtilityFunction
    def print_error_output(result)
      error_output = result.error_output
      error_output = result.standard_output if error_output == ''
      $stderr.puts error_output
    end
  end
end
