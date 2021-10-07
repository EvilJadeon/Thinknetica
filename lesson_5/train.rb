class Train
  attr_accessor :wagons, :current_station
  attr_reader :speed, :number

  def initialize(number)
    @number = number
    @type = self.type
    @speed = 0
    @wagons = []
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
      puts "Wagon has been deleted from #{@type} train #{@name}"
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
    @route.stations[@route.stations.index(@current_station) + 1]
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1]
  end
end