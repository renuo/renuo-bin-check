module RenuoBinCheck
  class ServantThread
    attr_accessor :script
    def initialize(script_config)
      @script = script_config
    end
  end
end
