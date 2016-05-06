module RenuoBinCheck
  class Initializer
    attr_reader :runner

    def initialize
      @runner = MasterThread.new
    end

    def check
      config = ScriptConfig.new
      yield(config)
      @runner.add_thread(config)
    end

    def run
      @runner.finalize
    end
  end
end
