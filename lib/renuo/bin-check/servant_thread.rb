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
      Open3.popen3(@script_config.script_command) do |_stdin, stdout, stderr, wait_thr|
        @result = Result.new(stdout.read, stderr.read, wait_thr.value.exitstatus)
      end
    end
  end
end
