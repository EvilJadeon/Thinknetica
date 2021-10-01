class Route
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

  def show_stations
    puts "#{@first_station}, #{@intermediate_stations.each {|station| puts station}}, #{@last_station}"
  end

  def stations
    @stations = [@first_station, @intermediate_stations, @last_station].flatten!
  end
end
