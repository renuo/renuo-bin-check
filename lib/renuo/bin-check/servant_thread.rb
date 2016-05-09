require 'open3'
module RenuoBinCheck
  class ServantThread
    attr_accessor :script
    def initialize(script_config)
      @script = script_config
      @cacher = Cacher.new(@script.script_command, @script.script_files)
    end

    def run
      if cache.class == String
        hash = @result
        Open3.popen3(@script.script_command) do |_stdin, stdout, stderr, wait_thr|
          @result = CommandResult.new(stdout.read, stderr.read, wait_thr.value.exitstatus)
        end
        @cacher.cache(hash, @result)
      end
      @result
    end

    def cache
      @result = @cacher.result
    end
  end
end
