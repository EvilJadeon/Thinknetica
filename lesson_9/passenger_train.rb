# frozen_string_literal: true

require_relative 'train'
# class declaration and inheritance
class PassengerTrain < Train
  attr_reader :type

  instances
  def initialize(number)
    @type = 'pass'
    super
  end
end
