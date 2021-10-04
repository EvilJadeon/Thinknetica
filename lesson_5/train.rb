class Train
  attr_reader :speed
  attr_reader :number

  def initialize(number, type)
    @number = number.to_s
    @type = type
    @speed = 0
    @current_station_index = nil
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
    add_train
  end

  def train_forward
    @current_station_index += 1 if next_station
  end

  def train_back
    @current_station_index -= 1 if previous_station
  end

  def current_station
    @stations[@current_station_index]
  end

  def next_station
    @stations[@current_station_index + 1]
  end

  def previous_station
    @stations[@current_station_index - 1] if @current_station_index > 0
  end
end