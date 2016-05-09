module RenuoBinCheck
  class Printer
    # :reek:UtilityFunction
    def print_output(results)
      results.each { |result| $stdout.puts result.output }
    end

    # :reek:UtilityFunction
    def print_error_output(result)
      $stderr.puts result.error_output
    end
  end
end
