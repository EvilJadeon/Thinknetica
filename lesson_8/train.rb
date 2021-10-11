require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'

class Train
  attr_accessor :wagons, :current_station
  attr_reader :speed, :number, :route

  include Manufacturer
  include InstanceCounter

  TRAIN_NUMBER = /\A[a-zа-я0-9]{3}(-|)[a-zа-я0-9]{2}\z/i

  @@trains = []

  def self.find(number)
    @@trains.find {|train| train.number == number}
  end

  def initialize(number)
    @number = number.to_s
    @speed = 0
    @wagons = []
    validate!
    @@trains.push(self)
    register_instance
  end
  
  def valide?
    validate!
    true
  rescue
    false
  end

  def train_block
    @wagons.each {|wagon| yield wagon}
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
    @wagons << wagon if wagon.type == @type && @speed == 0
  end

  def delete_wagons
    if @speed == 0
      @wagons.pop
      puts "Wagon has been deleted from #{@type} train № #{@number}"
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
    if @current_station != @route.stations[-1]
      @route.stations[@route.stations.index(@current_station) + 1]
    end
  end

  def previous_station
    if @current_station != @route.stations[0]
      @route.stations[@route.stations.index(@current_station) - 1]
    end
  end

  private
  def validate!
    raise 'A train number cannot be empty!' if number.empty?
    raise 'Incorrect number format!' if number !~ TRAIN_NUMBER
  end
end