require 'renuo_bin_check/dsl_config'

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

  def self.run(&check)
    @configs = []
    instance_eval(&check)
    initialize_checks
  end

  def self.initialize_checks
    @initializer = RenuoBinCheck::Initializer.new
    @configs.each do |config|
      if config.has_children?
        config.children.each do |child|
          add_check(child.configs + child.parent.configs)
        end
      else
        add_check(config.configs)
      end
    end
    @initializer.run
  end

  # :reek:NestedIterators initializer.check is not an iterator
  def self.add_check(configs)
    @initializer.check do |config|
      configs.each do |key, value|
        config.send key, value
      end
    end
  end

  class << self
    attr_reader :configs
  end
end
