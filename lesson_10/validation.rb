# frozen_string_literal: true

# module declaration
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # module declaration
  module ClassMethods
    attr_reader :validations

    def validate(attrb, validation_type, param = nil)
      raise "Attribute's name is not symbol" unless attrb.is_a?(Symbol)
      raise "Validation's name is not symbol" unless validation_type.is_a?(Symbol)

      @validations ||= []
      @validations << { attrb: attrb, validation_type: validation_type, param: param }
    end
  end

  # module declaration
  module InstanceMethods
    def validate!
      errors = []
      self.class.validations.each do |validation|
        case validation[:validation_type]
        when :presence
          validate_presence(validation[:attrb], errors)
        when :format
          validate_format(validation[:attrb], validation[:param], errors)
        when :type
          validate_type(validation[:attrb], validation[:param], errors)
        end
      end
      raise errors.join(' ') unless errors.empty?
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate_presence(attrb, errors)
      return unless instance_variable_get("@#{attrb}").nil? || instance_variable_get("@#{attrb}") == ''

      errors << "#{attrb} is nil OR empty line!"
    end

    def validate_type(attrb, class_name, errors)
      return if instance_variable_get("@#{attrb}").is_a?(class_name)

      errors << "#{attrb}'s class: #{instance_variable_get("@#{attrb}").class}, expected class: #{class_name.name}"
    end

    def validate_format(attrb, format, errors)
      errors << "#{attrb}'s format wrong!" if instance_variable_get("@#{attrb}") !~ format
    end
  end
end
