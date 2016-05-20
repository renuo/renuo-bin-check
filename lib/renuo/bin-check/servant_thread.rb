require 'open3'
module RenuoBinCheck
  class ServantThread
    attr_reader :script_config
    def initialize(script_config)
      @script_config = script_config
      script_files = @script_config.script_files
      @cacher = Cacher.new(@script_config.script_name, script_files) if script_files
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
      @script_config.reversed_exit? ? run_reversed : run_normally
    end

    def run_normally
      output, error_output, process = Open3.capture3(@script_config.script_command)
      Result.new(output, error_output, process.exitstatus)
    end

    def run_reversed
      output, error_output, process = Open3.capture3(@script_config.script_command)
      Result.new(error_output, output, process.exitstatus == 0 ? 1 : 0)
    end
  end
end
