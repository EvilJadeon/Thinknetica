# frozen_string_literal: true

# class declaration
class Interface
  def initialize
    @stations = []
    @trains = []
    @route = []
  end

  attr_accessor :trains, :stations, :wagons, :route

  INPUT = {
    1 => :create_station, 2 => :create_train, 3 => :create_route,
    4 => :add_station_to_route, 5 => :delete_station_from_route,
    6 => :add_route_to_train, 7 => :add_wagon_to_train,
    8 => :delete_wagon, 9 => :move_forward, 10 => :move_back,
    11 => :show_stations, 12 => :show_trains, 13 => :show_train_wagons,
    14 => :use_capacity, 15 => :exit
  }.freeze

  def interface
    puts 'Input a correct number to choose action:'

    actions = {
      1 => 'Create station', 2 => 'Create train', 3 => 'Create route',
      4 => 'Add station into route', 5 => 'Delete station from route',
      6 => 'Add route to train', 7 => 'Add wagon to train', 8 => 'Delete wagon',
      9 => 'Move train forward', 10 => 'Move train back', 11 => 'Show stations',
      12 => 'Show list of trains at station', 13 => 'Show train wagons',
      14 => 'Use capacity of wagons', 15 => 'Exit'
    }

    actions.each { |key, value| puts "#{key} - #{value}" }

    loop do
      menu = gets.to_i
      send(INPUT[menu])
    end
  end

  protected # чтобы не давать лишнюю информацию внешним классам

  def create_station
    print 'Input a station name:'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts "You created a station #{station_name.capitalize}"
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_train
    print 'Enter a train number:'
    number = gets.chomp
    print 'Enter a train type (cargo/pass):'
    type = gets.chomp
    case type
    when 'cargo'
      @trains << CargoTrain.new(number)
      puts "Cargo train with № #{number} has been created!"
    when 'pass'
      @trains << PassengerTrain.new(number)
      puts "Passenger train with № #{number} has been created!"
    else
      puts 'Incorrect train type!'
      create_train
    end
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_route
    puts 'Enter a first station:'
    first_station = gets.chomp
    puts 'Enter a last station:'
    last_station = gets.chomp
    first = get_station(first_station)
    last = get_station(last_station)
    raise 'No station found' if last.nil? || first.nil?

    route = Route.new(first, last)
    @route << route
    puts "Route #{first.name.capitalize} - #{last.name.capitalize} has been created!"
  rescue StandardError => e
    puts e.message
    retry
  end

  def add_station_to_route
    raise 'No stations found!' if @stations.empty?
    raise 'No routes found!' if @route.empty?

    puts 'Enter a first station name:'
    first_station = gets.chomp
    puts 'Enter a last station name:'
    last_station = gets.chomp
    puts 'Enter an intermediate station to add to route:'
    intermediate_station = gets.chomp

    intermediate = get_station(intermediate_station)
    raise 'No station found' if intermediate.nil?

    route = get_route(first_station, last_station)
    raise 'No route found!' if route.nil?

    route.add_station(intermediate)
    puts "In route has been added #{intermediate.name.capitalize}"
  rescue StandardError => e
    puts e.message
    retry
  end

  def delete_station_from_route
    raise 'No stations found' if @stations.empty?
    raise 'No routes found' if @route.empty?

    puts 'Enter a first station name:'
    first_station = gets.chomp
    puts 'Enter a last station name:'
    last_station = gets.chomp
    puts 'Enter a station name to delete:'
    delete_station = gets.chomp

    delete = get_station(delete_station)
    raise 'No station found!' if delete.nil?

    route = get_route(first_station, last_station)
    raise 'No route found!' if route.nil?

    route.delete_station(delete)
    puts "Station #{delete.name.capitalize} has been deleted!"
  rescue StandardError => e
    puts e.message
  end

  def add_route_to_train
    puts 'Enter a train number:'
    number = gets.chomp

    train = get_train(number)
    raise 'No train found!' if train.nil?

    puts 'Enter a first station of route:'
    first_station = gets.chomp
    puts 'Enter a last station of route:'
    last_station = gets.chomp

    route = get_route(first_station, last_station)
    raise 'No route found!' if route.nil?

    train.add_route(route)
    puts "Route #{first_station.capitalize} - #{last_station.capitalize} has been added to train № #{number}"
  rescue StandardError => e
    puts e.message
  end

  def add_wagon_to_train
    puts 'Enter a train number to add wagon:'
    number = gets.chomp
    train = get_train(number)
    raise 'No train found!' if train.nil?

    case train.type
    when 'pass'
      puts 'Enter a count of places:'
      qty = gets.to_i
      wagon = PassengerWagon.new(qty)
      train.add_wagons(wagon)
      puts "Train № #{number} has been added a passenger wagon, places: #{qty}"
    when 'cargo'
      puts 'Enter a volume of wagon (m3):'
      volume = gets.to_i
      wagon = CargoWagon.new(volume)
      train.add_wagons(wagon)
      puts "Train № #{number} has been added a cargo wagon, volume #{volume} m3"
    end
  rescue StandardError => e
    puts e.message
  end

  def delete_wagon
    puts 'Enter a train number to delete wagon:'
    number = gets.chomp
    train = get_train(number)
    raise 'No train found!' if train.nil?
    raise "The train doesn't have a wagon!" if train.wagons.nil?

    train.delete_wagons
    puts "Train № #{number} has been deleted one wagon at"
  rescue StandardError => e
    puts e.message
  end

  def move_forward
    puts 'Enter a train number to go forward:'
    number = gets.chomp
    train = get_train(number)
    raise 'No train found' if train.nil?
    raise "The train doesn't have a route!" if train.route.nil?

    puts "Train #{number} is at #{train.current_station.name} now"
    puts "Train #{number} says:'Chu-Chu-Chu'!"
    train.train_forward
    puts "Train #{number} is at #{train.current_station.name} now"
  rescue StandardError => e
    puts e.message
  end

  def move_back
    puts 'Enter a train number to go back:'
    number = gets.chomp
    train = get_train(number)
    raise 'No train found' if train.nil?
    raise "The train doesn't have a route!" if train.route.nil?

    puts "Train #{number} is at #{train.current_station.name.capitalize} now"
    puts "Train #{number} says:'Chu-Chu-Chu'!"
    train.train_back
    puts "Train #{number} is at #{train.current_station.name.capitalize} now"
  rescue StandardError => e
    puts e.message
  end

  def show_stations
    puts 'Stations list:'
    puts
    puts(@stations.select { |i| puts i.name.capitalize })
    puts
    raise 'No stations exist!' if @stations.empty?
  rescue StandardError => e
    puts e.message
  end

  def show_trains
    puts 'Enter a station name:'
    station_name = gets.chomp
    station = get_station(station_name)
    raise 'No stations found!' if station.nil?

    station.station_block do |train|
      puts "Train № #{train.number}, type: #{train.type}, wagons: #{train.wagons.size}"
    end
  end

  def show_train_wagons
    puts 'Enter a train number to watch its wagons:'
    train_number = gets.chomp
    train = get_train(train_number)
    raise 'Train not found!' if train.nil?

    train.wagons_info
  rescue StandardError => e
    puts e.message
  end

  def use_capacity
    puts 'Enter a train number:'
    number = gets.chomp
    train = get_train(number)

    raise 'No train found!' if train.nil?
    raise 'The train does not have wagons!' if train.wagons.empty?

    puts 'Enter a wagon number:'
    wagon_number = gets.chomp.to_i
    wagon = train.wagons[wagon_number - 1]

    case wagon.type
    when 'pass'
      wagon.take_places
      puts 'Place has been taken!'
    when 'cargo'
      puts 'Enter a volume:'
      volume = gets.chomp.to_i
      wagon.take_volume(volume)
      puts 'Volume has been taken!'
    end
  rescue StandardError => e
    puts e.message
  end

  def get_station(name)
    @stations.find { |station| station.name == name }
  end

  def get_route(first_station, last_station)
    @route.find do |route|
      route.stations.first.name == first_station && route.stations.last.name == last_station
    end
  end

  def get_train(number)
    @trains.find { |train| train.number == number }
  end
end
