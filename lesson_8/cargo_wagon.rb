require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :type, :volume
  @@number = 0
  def initialize(volume)
    @volume = volume
    @occupied_volume = 0
    @type = 'cargo'
    @@number += 1
    super
  end

  def number
    @@number
  end

  def take_volume(volume)
    @occupied_volume += volume
  end

  def occupied_volume
    @occupied_volume
  end

  def free_volume
    @volume - @occupied_volume
  end
end