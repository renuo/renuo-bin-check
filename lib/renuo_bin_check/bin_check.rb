require 'renuo_bin_check/dsl_config'
require 'renuo_bin_check/default_scripts/default_scripts'

class BinCheck
  def self.method_missing(name, *_params, &configs)
    if block_given?
      @configs << DSLConfig.new(name.to_s, &configs)
    else
      super
    end
  end

  def respond_to_missing?
    #:nocov:
    true
    #:nocov:
  end

  def self.run(default = :rails_defaults, &check)
    @configs = DefaultScripts.new.send(default)
    instance_eval(&check)
    initialize_checks
  end

  def self.initialize_checks
    @initializer = RenuoBinCheck::Initializer.new
    @configs.each do |config|
      if config.children?
        add_children(config)
      else
        add_check(config.configs)
      end
    end
    @initializer.run
  end

  def self.add_children(config)
    config.children.each do |child|
      add_check(child.parent.configs.merge(child.configs))
    end
  end

  # :reek:NestedIterators initializer.check is not an iterator
  def self.add_check(configs)
    @initializer.check do |config|
      configs.each do |key, value|
        config.send key, value
      end
    end
  end

  def self.exclude(check_name)
    @configs.delete_if { |config| config.configs[:name] == check_name.to_s }
  end

  class << self
    attr_reader :configs
  end
end
