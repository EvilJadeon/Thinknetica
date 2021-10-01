class Train
  attr_reader :speed

  def initialize(number, type, count_of_wagons)
    @number = number.to_s
    @type = type
    @count_of_wagons = count_of_wagons
    @speed = 0
    @current_station_index = nil
  end

  def speed_up(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def return_wagons
    @count_of_wagons
  end

  def add_wagons
    if @speed == 0
      @count_of_wagons += 1
    end
  end

  def delete_wagons
    if @speed == 0
      @count_of_wagons -= 1
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
    if @current_station_index > 0
      @stations[@current_station_index - 1]
    end
  end
end