=begin
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end


class Station
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train
    @trains.add
  end

  def return_train
    return @trains
  end

  def return_train_type
    return @trains.type?
  end

  def delete_train
    @trains.delete
  end
end
