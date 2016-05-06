module RenuoBinCheck
  class CommandResult
    attr_reader :output, :error_output, :exit_code
    def initialize(output, error_output, exit_code)
      @output = output
      @error_output = error_output
      @exit_code = exit_code
    end
  end
end
