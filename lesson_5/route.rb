class Route

  attr_reader :stations, :name

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_stations = []
  end

  def add_station(station)
    @intermediate_stations << station
  end

  def delete_station(station)
    @intermediate_stations.delete(station)
  end

  def stations
    @stations = [@first_station, @intermediate_stations, @last_station].flatten!
  end

  def show_stations
    @stations = [@first_station, @intermediate_stations, @last_station].flatten!
    puts "#{@stations}"
  end

  def add_train(train)
    @stations[0].add_train(train)
  end
end
