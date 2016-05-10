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
      Open3.popen3(@script.script_command) do |_stdin, stdout, stderr, wait_thr|
        @result = CommandResult.new(stdout.read, stderr.read, wait_thr.value.exitstatus)
      end
    end
  end
end
