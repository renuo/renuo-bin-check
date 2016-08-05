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
    @new_script_hash
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
end
