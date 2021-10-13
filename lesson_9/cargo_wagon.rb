# frozen_string_literal: true

require_relative 'wagon'
# inheritance from class Wagon
class CargoWagon < Wagon
  attr_reader :type, :volume, :occupied_volume, :count

  @@count = 0

  def initialize(volume)
    @volume = volume
    @occupied_volume = 0
    @type = 'cargo'
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
