class Train < Route
  def initialize(number, type, count_of_wagons)
    @number = number
    @type = type
    @count_of_wagons = count_of_wagons
    @speed = 0
  end

  def speed_up
    @speed +=
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

  def add_del_wagons
    @count_of_wagons += 1 @count_of_wagons -=1 if @speed = 0
  end

  def add_route(show_stations)
    super
  end

  def get_route
    if add_route == true
      @current_station_index = 0
    end
  end

  def train_forward
    @current_station_index += 1
  end

  def train_back
    @current_station_index -= 1
  end

  def return_stations
    return show_stations
  end
end