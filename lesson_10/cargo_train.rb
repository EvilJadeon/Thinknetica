# frozen_string_literal: true

# connection file train.rb
require_relative 'validation'
require_relative 'train'
# inretitance from class Train
class CargoTrain < Train
  include Validation
  attr_reader :type

  validate :number, :format, TRAIN_NUMBER
  validate :number, :presence

  instances
  def initialize(number)
    @type = 'cargo'
    super
    validate!
  end
end
