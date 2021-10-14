# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'
# class declaration
class Train
  extend Accessors
  include Manufacturer
  include InstanceCounter
  include Validation

  TRAIN_NUMBER = /\A[a-zа-я0-9]{3}(-|)[a-zа-я0-9]{2}\z/i.freeze

  instances
  attr_accessor_with_history :wagons, :current_station, :speed, :number, :route, :type
  validate :number, :format, TRAIN_NUMBER
  validate :number, :presence

  @@trains = []

  def initialize(number)
    @number = number.to_s
    @speed = 0
    @wagons = []
    validate!
    register_instance
    @@trains.push(self)
  end

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def train_block(&block)
    @wagons.each(&block)
  end

  def speed_up(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def return_wagons
    @wagons
  end

  def add_wagons(wagon)
    @wagons << wagon if wagon.type == @type && @speed.zero?
  end

  def delete_wagons
    @wagons.pop if @speed.zero?
  end

  def wagons_info
    train_block do |wagon|
      case wagon.type
      when 'pass'
        puts
        puts "Wagon № #{wagon.count}"
        puts "Type: #{wagon.type}"
        puts "Free places: #{wagon.free_places}"
        puts "Occupied places: #{wagon.occupied_places}"
      when 'cargo'
        puts
        puts "Wagon № #{wagon.count}"
        puts "Type: #{wagon.type}"
        puts "Free volume: #{wagon.free_volume}"
        puts "Occupied volume: #{wagon.occupied_volume}"
      end
    end
  end

  def add_route(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.add_train(self)
  end

  def train_forward
    @current_station.delete_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def train_back
    @current_station.delete_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if @current_station != @route.stations[-1]
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] if @current_station != @route.stations[0]
  end
end
