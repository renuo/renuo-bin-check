class BinCheck
  def self.method_missing(name, *params, &block)
    @current_name = name
    @new_script_hash[@current_name] = {}
    instance_eval &block
  end

  def self.run(&block)
    @new_script_hash = {}
    instance_eval &block
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
