# frozen_string_literal: true

# connection file train.rb
require_relative 'train'
# inretitance from class Train
class CargoTrain < Train
  attr_reader :type

  instances
  def initialize(number)
    @type = 'cargo'
    super
  end
end
