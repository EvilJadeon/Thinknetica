# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :box

    def validate(name, type, *args)
      self.box ||= []
      self.box.push({ name: name, type: type, args: args })
    end
  end

  module InstanceMethods
    def validate!
      self.class.box.each do |value|
        var = instance_variable_get("@#{value[:name]}")
        method_name = "validate_#{value[:type]}"
        send(method_name, var, value[:args])
      end
    end

    def validate_presence(name)
      raise 'Do not be empty!' if name.nil? && name.empty?
    end

    def validate_format(name, _format)
      raise 'Wrong format!' unless name =~ _format
    end

    def validate_type(name, type)
      raise 'Not belong to class!' unless name.instance_of?(type)
    end

    def valid?
      validate!
      true
    rescue RuntimeError, ArgumentError
      false
    end
  end
end
