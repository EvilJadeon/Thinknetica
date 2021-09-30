class Train
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

  def return_speed
    return @speed
  end

  def stop
    @speed = 0
  end

  def return_wagons
    @count_of_wagons
  end

  def add_del_wagons(add)
    if @speed == 0
      if add == 'add'
        @count_of_wagons += 1
      elsif add == 'del'
        @count_of_wagons -= 1
      end
    end
  end

  def add_route(route)
    add_train
  end

  def train_forward
    @current_station_index += 1 if @current_station_index < @stations.size - 1
  end

  def train_back
    @current_station_index -= 1 if @current_station_index > 0
  end

  def return_current_station
    return @stations[@current_station_index]
  end

  def return_next_station
    return @stations[@current_station_index + 1]
  end

  def return_prev_station
    return @stations[@current_station_index - 1]
  end
end