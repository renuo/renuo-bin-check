require 'open3'
require 'renuo_bin_check/result'

module RenuoBinCheck
  class ServantThread
    attr_reader :script_config
    def initialize(script_config)
      @script_config = script_config
      script_files = @script_config.script_files
      @cacher = Cacher.new(@script_config.script_name, script_files) if script_files
      @result = nil
    end

    def run
      @script_config.script_files ? run_with_cache : run_command
    end

    private

    def run_with_cache
      @cacher.cache(run_command) unless @cacher.exists?
      @cacher.result
    end

    def run_command
      standard_output, error_output, process = Open3.capture3(@script_config.script_command)
      @result = Result.new(standard_output, error_output, process.exitstatus)
      override_output
      @script_config.reversed_exit? ? reverse_result : @result
    end

    def override_output
      standard_output = @script_config.script_standard_output ||= @result.standard_output
      error_output = @script_config.script_error_output ||= @result.error_output
      @result = Result.new(standard_output + @script_config.appended_standard_output,
                           error_output + @script_config.appended_error_output,
                           @result.exit_code)
    end

    def reverse_result
      Result.new(@result.error_output, @result.standard_output, @result.exit_code.zero? ? 1 : 0)
    end
  end
end
