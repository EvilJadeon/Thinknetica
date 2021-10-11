require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'

class Route
  attr_reader :stations, :name
  include InstanceCounter

  instances

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_stations = []
    register_instance
  end

  def add_station(station)
    @intermediate_stations << station
  end

  def delete_station(station)
    @intermediate_stations.delete(station)
  end

  def stations
    @stations = [@first_station, @intermediate_stations, @last_station].flatten!
  end

  def show_stations
    @stations = [@first_station, @intermediate_stations, @last_station].flatten!
    puts "#{@stations}"

  rescue Exception => e
    puts e.message
  end
end
