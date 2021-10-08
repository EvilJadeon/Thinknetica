require_relative 'instance_counter.rb'

class Station
  attr_reader :trains, :name
  
  include InstanceCounter

  @@stations = []

  qty_instances

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations.push(self)
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def return_train_type(type)
    @trains.select {|train| train.type == type}
  end

  def delete_train(train)
    @trains.delete(train)
  end
end
