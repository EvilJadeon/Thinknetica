class Interface
  
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
    puts '11 - Show stations'
    puts '12 - exit in program'
    puts '13 - Show list of trains at station'

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
      when 13
        show_trains
      else
        puts 'Error!'
      end
    end
  end
  
  protected #чтобы не двать лишнюю информацию внешним классам

  def create_station
    print 'Input a station name:'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts "You created a station #{station_name.capitalize}"
    rescue Exception => e
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
  rescue Exception => e
    puts e.message
    retry
  end

  def create_route
    puts 'Enter a first station:'
    first_station = gets.chomp
    first = @stations.find {|i| i.name == first_station}
    raise 'No station found' if first.nil?
    puts 'Enter a last station:'
    last_station = gets.chomp
    last = @stations.find {|i| i.name == last_station}
    raise 'No station found' if last.nil?

    @route << Route.new(first, last)
    puts "Route #{first_station.capitalize} - #{last_station.capitalize} has been created!"
    rescue Exception => e
      puts e.message
      retry
  end

  def add_station_to_route
    raise 'No stations found' if @stations.empty?
    raise 'No routes found' if @route.empty?

    puts 'Enter a first station name:'
    first_station = gets.chomp
    first = @stations.find {|i| i.name == first_station}
    raise 'No station found' if first.nil?

    puts 'Enter a last station name:'
    last_station = gets.chomp
    last = @stations.find {|i| i.name == last_station}
    raise 'No station found' if last.nil?

    puts 'Enter an intermediate station to add to route:'
    intermediate_station = gets.chomp
    intermediate = @stations.find {|i| i.name == intermediate_station}
    raise 'No station found' if intermediate.nil?

    route = @route.find {|i| i.stations.select {|j| j == first_station} && i.stations.select {|j| j == last_station}}
    route.add_station(intermediate)
    puts "In route #{first_station.capitalize} - #{last_station.capitalize} has been added #{intermediate_station.capitalize}"
    route.show_stations

    rescue Exception => e
      puts e.message
      retry
  end

  def delete_station_from_route
    raise 'No stations found' if @stations.empty?
    raise 'No routes found' if @route.empty?

    puts 'Enter a first station name:'
    first_station = gets.chomp
    first = @stations.find {|i| i.name == first_station}
    raise 'No station found' if first.nil?

    puts 'Enter a last station name:'
    last_station = gets.chomp
    last = @stations.find {|i| i.name == last_station}
    raise 'No station found' if last.nil?

    puts 'Enter a station name to delete:'
    delete_station = gets.chomp
    route = @route.find {|i| i.stations.select {|j| j == first_station} && i.stations.select {|j| j == last_station}}
    raise 'No route found' if route.nil?
    delete = route.stations.find {|i| i.name == delete_station}
    raise 'No station found' if delete.nil?
    route.delete_station(delete)
    puts "Station #{delete_station.capitalize} has been deleted in route #{first_station.capitalize} - #{last_station.capitalize}"
    route.show_stations

    rescue Exception => e
      puts e.message
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

    unless route.nil? && train.nil?
      train.add_route(route)
      puts "Route #{first_station.capitalize} - #{last_station.capitalize} has been added to train № #{number}"
    else
      puts 'Error!'
    end
  end

  def add_wagon_to_train
    puts 'Enter a train number to add wagon:'
    number = gets.chomp
    train = @trains.find {|i| i.number == number}
    raise 'No train found!' if train.nil?

    case train.type
    when 'pass'
      puts 'Enter a count of places:'
      qty = gets.to_i
      puts 'Enter Y to take one place in wagon:'
      count = gets.chomp.downcase
      train.add_wagons(PassengerWagon.new(qty))
      wagon = train.wagons.find {|wagon| wagon.type == 'pass'}
      wagon.take_places
      puts 'You took one place in this wagon!'
      puts "Train № #{number} has been added a passenger wagon with #{qty} places"
    
    when 'cargo'
      puts 'Enter a volume of wagon (m3):'
      volume = gets.to_i
      puts 'Enter a volume (m3) that you have to take:'
      take = gets.to_i
      train.add_wagons(CargoWagon.new(volume))
      cargo = train.wagons.find {|cargo| cargo.type == 'cargo'}
      cargo.take_volume(take)
      puts "You took #{take} m3 volume in this wagon"
      puts "Train № #{number} has been added a cargo wagon, volume #{volume} m3"
    end

    rescue Exception => e
      puts e.message
  end

  def delete_wagon
    puts 'Enter a train number to delete wagon:'
    number = gets.chomp
    train = @trains.find {|i| i.number == number}
    raise 'No train found!' if train.nil?
    raise "The train doesn't have a wagon!" if train.wagons.nil?

    train.wagons.pop
    puts "Train № #{number} has been deleted one wagon at"

    rescue Exception => e
      puts e.message
  end

  def move_forward
    puts 'Enter a train number to go forward:'
    number = gets.chomp
    train = @trains.find {|i| i.number == number}

    raise 'No train found' if train.nil?
    raise "The train doesn't have a route!" if train.route.nil?

    puts "Train #{number} is at #{train.current_station.name} now"
    puts "Train #{number} says:'Chu-Chu-Chu'!"
    train.train_forward
    puts "Train #{number} is at #{train.current_station.name} now"

    rescue Exception => e
      puts e.message
  end

  def move_back
    puts 'Enter a train number to go back:'
    number = gets.chomp
    train = @trains.find {|i| i.number == number}

    raise 'No train found' if train.nil?
    raise "The train doesn't have a route!" if train.route.nil?

    puts "Train #{number} is at #{train.current_station.name.capitalize} now"
    puts "Train #{number} says:'Chu-Chu-Chu'!"
    train.train_back
    puts "Train #{number} is at #{train.current_station.name.capitalize} now"

    rescue Exception => e
      puts e.message
  end

  def show_stations
    puts 'Stations list:'
    puts
    puts @stations.select {|i|  puts i.name.capitalize}
    puts
    print '=' * 50
    raise 'No stations exist!' if @stations.empty?
    
    rescue Exception => e
      puts e.message
  end

  def show_trains
    puts 'Enter a station name:'
    station_name = gets.chomp
    station = @stations.find {|i| i.name == station_name}
    raise 'No stations found!' if station.nil?
    station.station_block do |train|
      puts "Train № #{train.number}, type: #{train.type}, wagons: #{train.wagons.size}"
    end

    puts '=' * 80
    puts

    puts 'Enter a train number to watch its wagons:'
    train_number = gets.chomp
    number = @trains.find {|i| i.number == train_number}
    raise 'This station does not have this train!' if number.nil?
    number.train_block do |wagon|
      if wagon.type == 'pass'
        puts "Wagon № #{wagon.number}, type: #{wagon.type}, free places: #{wagon.free_places}, occupied places: #{wagon.occupied_places}"
      elsif wagon.type == 'cargo'
        puts "Wagon № #{wagon.number}, type: #{wagon.type}, free volume: #{wagon.free_volume}, occupied volume: #{wagon.occupied_volume}"
      end
    end

    rescue Exception => e
      puts e.message
  end 
end
