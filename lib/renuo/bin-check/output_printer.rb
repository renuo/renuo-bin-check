module RenuoBinCheck
  class OutputPrinter
    def print_output(results)
      print_result(results, 0) { |result| $stdout.puts result.output }
    end

    def print_error_output(results)
      print_result(results, 1) { |result| $stderr.puts result.error_output }
    end

    private

    # :reek:ControlParameter
    # :reek:UtilityFunction
    def print_result(results, error_code)
      results.each do |result|
        yield(result) if result.exit_code == error_code
      end
    end
  end
end
