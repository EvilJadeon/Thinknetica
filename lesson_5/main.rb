require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'

class Main
  
  def initialize
    @stations = []
    @trains = []
    @route = []
  end

  attr_accessor :trains, :stations, :wagons, :route

  def interface
    puts 'Input a correct number to choose action:'
    puts '1 - Create station'
    puts '2 - Create train'
    puts '3 - Create route'
    puts '4 - Add station into route'
    puts '5 - Delete station in route'
    puts '6 - Add route to train'
    puts '7 - Add wagon into train'
    puts '8 - Delete wagon in train'
    puts '9 - Move train forward'
    puts '10 - Move train back'
    puts '11 - Show stations and trains at station'
    puts '12 - exit in program'
  
  
  def create_station
    print 'Input a station name:'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts "You created a station #{station_name.capitalize}"
  end

  def create_train
    print 'Enter a train number:'
    number = gets.chomp
    print 'Enter a train type (cargo/pass):'
    type = gets.chomp
    case type
    when 'cargo'
      @trains << CargoTrain.new(number, type)
      puts "Cargo train with number #{number} has been created!"
    when 'pass'
      @trains << PassengerTrain.new(number, type)
      puts "Passenger train with number #{number} has been created!"
    end 
  end

  def create_route
    puts 'Enter a first station:'
    first_station = gets.chomp
    puts 'Enter a last station:'
    last_station = gets.chomp
    @route << Route.new(first_station, last_station)
    puts "Route #{first_station.capitalize} - #{last_station.capitalize} has been created!"
  end

  def add_station_to_route
    puts 'Enter a first station name:'
    first_station = gets.chomp
    puts 'Enter a last station name:'
    last_station = gets.chomp
    puts 'Enter an intermediate station to add to route:'
    intermediate_station = gets.chomp
    route = @route.find {|i| i.stations.select {|j| j == first_station} && i.stations.select {|j| j == last_station}}
    route.add_station(intermediate_station)
    puts "In route #{first_station.capitalize} - #{last_station.capitalize} has been added #{intermediate_station.capitalize}"
    route.show_stations
  end

  def delete_station_from_route
    puts 'Enter a first station name:'
    first_station = gets.chomp
    puts 'Enter a last station name:'
    last_station = gets.chomp
    puts 'Enter a station name to delete:'
    delete = gets.chomp

    route = @route.find {|i| i.stations.select {|j| j == first_station} && i.stations.select {|j| j == last_station}}
    route.delete_station(delete)
    puts "Station #{delete} has been deleted in route #{first_station} - #{last_station}"
    route.show_stations
  end

  def add_route_to_train
    puts 'Enter a train number:'
    number = gets.chomp
    puts 'Enter a first station of route:'
    first_station = gets.chomp
    puts 'Enter a last station of route:'
    last_station = gets.chomp

    route = @route.find {|i| i.stations.select {|j| j == first_station} && i.stations.select {|j| j == last_station}}
    train = @trains.find {|i| i.number == number}
    train.add_route(route)

    puts "Route #{first_station} - #{last_station} has been added to train #{number}"
  end

  def add_wagon_to_train
    puts 'Enter a train number to add wagon:'
    number = gets.chomp
    train = @trains.find {|i| i.number == number}

    case train.type
    when 'pass'
      train.add_wagons(PassengerWagon.new('pass'))
      puts "Train #{number} has been added a wagon to"
    when 'cargo'
      train.add_wagons(CargoWagon.new('cargo'))
      puts "Train #{number} has been added a wagon to"
    end
  end

  def delete_wagon
    puts 'Enter a train number to delete wagon:'
    number = gets.chomp
    train = @trains.find {|i| i.number == number}

    train.wagons.pop
    puts "Train #{number} has been deleted one wagon at"
  end

  def move_forward
    puts 'Enter a train number to go forward:'
    number = gets.chomp
    train = @trains.find {|i| i.number == number}
    puts "Train #{number} is at #{train.current_station} now"
    puts "Train #{number} says:'Chu-Chu-Chu'!"
    train.train_forward
    puts "Train #{number} is at #{train.current_station} now"
  end

  def move_back
    puts 'Enter a train number to go back:'
    number = gets.chomp
    train = @trains.find {|i| i.number == number}
    puts "Train #{number} is at #{train.current_station} now"
    puts "Train #{number} says:'Chu-Chu-Chu'!"
    train.train_back
    puts "Train #{number} is at #{train.current_station} now"
  end

  def show_stations
    puts 'Enter a first station name of route:'
    first_station = gets.chomp
    puts 'Enter a last station name of route:'
    last_station = gets.chomp
    route = @route.find {|i| i.stations.select {|j| j == first_station} && i.stations.select {|j| j == last_station}}
    puts "This is list of stations for #{first_station} - #{last_station} route:"
    route.show_stations
    
    p trains
    #puts 'Enter a station name to show a list of trains:'
    #station_name = gets.chomp
    #station = @stations.find {|i| i.name == station_name}
    #station.trains.each_with_index do |train, index| 
     # puts "Train: #{train.number}, type: #{train.type}, wagons: #{train.wagons}"
    #end
  end

  loop do
    
    menu = gets.to_i

    case menu
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    when 4
      add_station_to_route
    when 5
      delete_station_from_route
    when 6
      add_route_to_train
    when 7
      add_wagon_to_train
    when 8
      delete_wagon
    when 9
      move_forward
    when 10
      move_back
    when 11
      show_stations
    when 12
      exit
    end
  end
  end
end

@main = Main.new
@main.interface
