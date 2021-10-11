require_relative 'manufacturer.rb'

class Wagon
  attr_reader :type
  include Manufacturer
  def initialize(qty_places_or_volume)
    @type = type
  end
end