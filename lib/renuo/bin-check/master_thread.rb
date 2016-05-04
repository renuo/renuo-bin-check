module RenuoBinCheck
  class MasterThread
    attr_reader :threads
    def initialize
      @threads = []
    end

    def add_thread(script_config)
      threads << ServantThread.new(script_config)
    end
  end
end
