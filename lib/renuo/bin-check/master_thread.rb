require 'thwait'
module RenuoBinCheck
  class MasterThread
    attr_reader :threads

    def initialize
      @threads = []
      @results = []
    end

    def add_thread(script_config)
      threads << Thread.new do
        servant = ServantThread.new(script_config)
        Thread.current[:result] = servant.run
      end
    end

    def finalize
      waiter = ThreadsWait.new(threads)
      until waiter.empty?
        thread = waiter.next_wait
        @results << thread[:result]
        exit 1 if @results.last.exit_code == 1
      end
      exit 0
    end
  end
end
