require 'open3'
module RenuoBinCheck
  class ServantThread
    attr_accessor :script
    def initialize(script_config)
      @script = script_config
      @cacher = Cacher.new(@script.script_name, @script.script_files)
    end

    def run
      @cacher.cache(run_command) unless @cacher.exists?
      @cacher.result
    end

    private

    def run_command
      Open3.popen3(@script.script_command) do |_stdin, stdout, stderr, wait_thr|
        @result = CommandResult.new(stdout.read, stderr.read, wait_thr.value.exitstatus)
      end
    end
  end
end
