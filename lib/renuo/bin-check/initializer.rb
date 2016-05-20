module RenuoBinCheck
  class Initializer
    attr_reader :master_thread

    def initialize
      @master_thread = MasterThread.new(Printer.new)
    end

    def check
      config = ScriptConfig.new
      yield(config)
      @master_thread.add_thread(config)
    end

    def run
      @master_thread.finalize
    end
  end
end
