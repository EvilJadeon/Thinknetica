require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :type, :qty_of_places
  @@number = 0
  def initialize(qty_of_places)
    @qty_of_places = qty_of_places
    @occupied_places = 0
    @type = 'pass'
    @@number += 1
    super
  end

  def number
    @@number
  end

  def take_places
    @occupied_places += 1
  end

  def occupied_places
    @occupied_places
  end

  def free_places
    @qty_of_places - @occupied_places
  end
end