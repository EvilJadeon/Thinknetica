# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'accessors'
# class declaration
class Route
  include InstanceCounter
  extend Accessors

  attr_accessor_with_history :stations, :first_station, :last_station

  instances

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    raise 'No station found' unless @stations.include?(station)
    raise 'The first station cannot be deleted' if station == @stations[0]
    raise 'The last station cannot be deleted' if station == @stations[-1]

    @stations.delete(station)
  rescue StandartError => e
    puts e.message
  end

  def show_stations
    puts @stations.to_s
  rescue StandardError => e
    puts e.message
  end
end
