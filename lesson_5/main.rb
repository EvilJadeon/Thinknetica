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
      puts "You created a station #{station_name}"
    end

    def create_train
      print 'Enter a train number:'
      number = gets.chomp
      print 'Enter a train type (cargo/pass):'
      type = gets.chomp
      case type
      when 'cargo'
        @trains << CargoTrain.new(number)
        puts "Cargo train with number #{number} created!"
      when 'pass'
        @trains << PassengerTrain.new(number)
        puts "Passenger train with number #{number} created!"
      end 
    end

    def create_route
      puts 'Enter a first station:'
      first_station = gets.chomp
      puts 'Enter a last station:'
      last_station = gets.chomp
      @route << Route.new(first_station, last_station)
      puts 'Route has been created!'
    end

    def add_station
      puts 'Enter an intermediate station name:'
      intermediate = gets.chomp
      Route.add_station(intermediate)
    end

    def delete_station
      puts 'Enter a station name to delete:'
      delete = gets.chomp
      Route.delete_station(delete)
    end

    def add_route_to_train
      puts 'Enter a train number:'
      number = gets.chomp
      if Train.number == number
        Train.add_route
      end
    end

    def add_wagon_to_train
      Train.add_wagons
    end

    def delete_wagon
      Train.delete_wagons
    end

    def move_forward
      Train.train_forward
    end

    def move_back
      Train.train_back
    end

    def show_stations
      Route.stations
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
        add_station
      when 5
        delete_station
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
