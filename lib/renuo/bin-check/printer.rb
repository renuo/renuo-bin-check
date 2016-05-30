module RenuoBinCheck
  class Printer
    # :reek:UtilityFunction
    def print_output(results)
      results.each { |result| $stdout.puts result.output }
    end

    # :reek:UtilityFunction
    def print_error_output(result)
      error_output = result.error_output
      error_output = result.output if error_output == ''
      $stderr.puts error_output
    end
  end
end
