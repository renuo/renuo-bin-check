class DSLConfig
  attr_reader :configs, :children, :parent
  def initialize(name, parent = nil, &configs)
    @parent = parent
    @children = []
    @configs = { name: name }
    instance_eval(&configs)
  end

  def method_missing(name, *_params, &configs)
    if block_given?
      @children << DSLConfig.new(name.to_s, self, &configs)
    else
      super
    end
  end

  def respond_to_missing?
    #:nocov:
    true
    #:nocov:
  end

  def files(files)
    @configs[:files] = files
  end

  def command(command)
    @configs[:command] = command
  end

  def reversed_exit(reversed_exit)
    @configs[:reversed_exit] = reversed_exit
  end

  def error_message(error_message)
    @configs[:error_message] = error_message
  end

  def success_message(success_message)
    @configs[:success_message] = success_message
  end

  def children?
    !@children.empty?
  end
end
