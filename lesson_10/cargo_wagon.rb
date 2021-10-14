# frozen_string_literal: true

require_relative 'wagon'
require_relative 'validation'
# inheritance from class Wagon
class CargoWagon < Wagon
  include Validation

  attr_reader :type, :volume, :occupied_volume, :count

  validate :count, :type, Integer

  @@count = 0

  def initialize(volume)
    @volume = volume
    @occupied_volume = 0
    @type = 'cargo'
    validate!
    @@count += 1
    @count = @@count
    super
  end

  def take_volume(volume)
    raise 'Entering volume is more than free volume!' if volume > @volume

    @occupied_volume += volume
  end

  def free_volume
    @volume - @occupied_volume
  end
end
