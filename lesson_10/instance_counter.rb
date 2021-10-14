# frozen_string_literal: true

# module declaration
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # module_declaration
  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  # module declaration
  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end
