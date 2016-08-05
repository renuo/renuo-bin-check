class BinCheck
  def self.method_missing(name, *_params, &configs)
    if block_given?
      if caller[2][/`.*'/][1..-2] == "run"
        @new_current_name = nil
        @current_name = name
        @new_script_hash[@current_name] = {}
      else
        @new_current_name = name
        @new_script_hash[@current_name][@new_current_name] = {}
      end
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
    hash_safe = {}
    @new_script_hash.each do |key, value|
      should_be_deleted = false
      shared_values = {}
      temporary_hash_safe = {}
      if value.class == Hash
        value.each do |blubb, blibb|
          if blibb.class != Hash
            shared_values[blubb] = blibb
          else
            shared_values.each do |bubbel, bibbel|
              value.delete(bubbel) if value[bubbel]
              temporary_hash_safe[blubb] = blibb
              should_be_deleted = true
            end
          end
        end
      end
      if should_be_deleted
        @new_script_hash.delete(key)
        temporary_hash_safe.each do |blubb, blibb|
          shared_values.each do |bubbel, bibbel|
            blibb[bubbel] = bibbel
          end
        end
      end
      temporary_hash_safe.each do |blubb, blibb|
        hash_safe[blubb] = blibb
      end
    end
    hash_safe.each do |key, value|
      @new_script_hash[key] = value
    end
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
    if @new_current_name
      @new_script_hash[@current_name][@new_current_name][:files] = files
    else
      @new_script_hash[@current_name][:files] = files
    end
  end

  def self.command(command)
    if @new_current_name
      @new_script_hash[@current_name][@new_current_name][:command] = command
    else
      @new_script_hash[@current_name][:command] = command
    end
  end

  def self.reversed_exit(reversed_exit)
    if @new_current_name
      @new_script_hash[@current_name][@new_current_name][:reversed_exit] = reversed_exit
    else
      @new_script_hash[@current_name][:reversed_exit] = reversed_exit
    end
  end

  def self.error_message(error_message)
    if @new_current_name
      @new_script_hash[@current_name][@new_current_name][:error_message] = error_message
    else
      @new_script_hash[@current_name][:error_message] = error_message
    end
  end

  def self.success_message(success_message)
    if @new_current_name
      @new_script_hash[@current_name][@new_current_name][:success_message] = success_message
    else
      @new_script_hash[@current_name][:success_message] = success_message
    end
  end

  class << self
    attr_reader :new_script_hash
  end
end
