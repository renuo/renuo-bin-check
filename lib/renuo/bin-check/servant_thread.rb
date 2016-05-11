require 'open3'
module RenuoBinCheck
  class ServantThread
    attr_accessor :script
    def initialize(script_config)
      @script = script_config
      script_files = @script.script_files
      @cacher = Cacher.new(@script.script_name, script_files) if script_files
    end

    def run
      @script.script_files ? run_with_cache : run_command
    end

    private

    def run_with_cache
      @cacher.cache(run_command) unless @cacher.exists?
      @cacher.result
    end

    def run_command
      @script.reversed_exit? ? run_reversed : run_normally
    end

    def run_normally
      Open3.popen3(@script.script_command) do |_stdin, stdout, stderr, wait_thr|
        CommandResult.new(stdout.read, stderr.read, wait_thr.value.exitstatus)
      end
    end

    def run_reversed
      Open3.popen3(@script.script_command) do |_stdin, stdout, stderr, wait_thr|
        CommandResult.new(stderr.read, stdout.read, wait_thr.value.exitstatus == 0 ? 1 : 0)
      end
    end
  end
end
