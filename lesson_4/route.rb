class Route
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_stations = []
  end

  def add_station
    @intermediate_stations.add
  end

  def delete_station
    @intermediate_stations.delete
  end

  def show_stations
    puts "#{@first_station}, #{@intermediate_stations}, #{@last_station}"
  end
end
