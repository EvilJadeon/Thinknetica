# frozen_string_literal: true

require_relative 'validation'
require_relative 'train'
# class declaration and inheritance
class PassengerTrain < Train
  include Validation
  attr_reader :type

  validate :number, :format, TRAIN_NUMBER
  validate :number, :presence

  instances
  def initialize(number)
    @type = 'pass'
    super
    validate!
  end
end
