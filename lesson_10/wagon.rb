# frozen_string_literal: true

require_relative 'manufacturer'
# class declaration
class Wagon
  attr_reader :type

  include Manufacturer
  def initialize(_qty_places_or_volume)
    @type = type
  end
end
