require 'open3'
module RenuoBinCheck
  class ServantThread
    attr_accessor :script
    def initialize(script_config)
      @script = script_config
    end

    def run
      Open3.popen3(@script.script_command) do |_stdin, stdout, stderr, wait_thr|
        CommandResult.new(stdout.read, stderr.read, wait_thr.value.exitstatus)
      end
    end
  end
end
