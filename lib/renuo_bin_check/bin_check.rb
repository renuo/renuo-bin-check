class BinCheck
  def self.method_missing(name, *_params, &configs)
    if block_given?
      @current_name = name
      @new_script_hash[@current_name] = {}
      instance_eval(&configs)
    else
      super
    end
  end

  def respond_to_missing?
    #:nocov:
    true
    #:nocov:
  end

  def self.run(&check)
    @new_script_hash = {}
    instance_eval(&check)
    initialize_checks
  end

  #:reek:NestedIterators
  def self.initialize_checks
    initializer = RenuoBinCheck::Initializer.new
    @new_script_hash.each do |name, configs|
      initializer.check do |config|
        config.name name
        configs.each do |key, value|
          config.send key, value
        end
      end
    end
    initializer.run
  end

  def self.files(files)
    @new_script_hash[@current_name][:files] = files
  end

  def self.command(command)
    @new_script_hash[@current_name][:command] = command
  end

  def self.reversed_exit(reversed_exit)
    @new_script_hash[@current_name][:reversed_exit] = reversed_exit
  end

  def self.error_message(error_message)
    @new_script_hash[@current_name][:error_message] = error_message
  end

  def self.success_message(success_message)
    @new_script_hash[@current_name][:success_message] = success_message
  end

  class << self
    attr_reader :new_script_hash
  end
end
