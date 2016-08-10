require 'thwait'

module RenuoBinCheck
  class MasterThread
    attr_reader :threads, :printer

    def initialize(printer)
      @threads = []
      @results = []
      @printer = printer
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
        result = waiter.next_wait[:result]
        @results << result
        exit_with_error(result) if result.exit_code.nonzero?
      end
      exit_with_success
    end

    private

    def exit_with_error(result)
      @printer.print_error_output(result)
      exit 1
    end

    def exit_with_success
      @printer.print_standard_output(@results)
      exit 0
    end
  end
end
