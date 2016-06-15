module RenuoBinCheck
  class Result
    attr_reader :standard_output, :error_output, :exit_code
    def initialize(standard_output, error_output, exit_code)
      @standard_output = standard_output
      @error_output = error_output
      @exit_code = exit_code
    end
  end
end
