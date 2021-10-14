# frozen_string_literal: true

require_relative 'wagon'
require_relative 'validation'
# class declaration and inheritance
class PassengerWagon < Wagon
  include Validation

  attr_reader :type, :qty_of_places, :occupied_places, :count
  validate :count, :type, Integer

  @@count = 0

  def initialize(qty_of_places)
    @qty_of_places = qty_of_places
    @occupied_places = 0
    @type = 'pass'
    validate!
    @@count += 1
    @count = @@count
    super
  end

  def take_places
    @occupied_places += 1
  end

  def free_places
    @qty_of_places - @occupied_places
  end
end
