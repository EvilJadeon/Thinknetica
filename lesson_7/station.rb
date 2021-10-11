require_relative 'instance_counter.rb'

class Station
  attr_reader :trains, :name
  include InstanceCounter

  @@stations = []
  instances

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations.push(self)
    register_instance
  end

  def valide?
    validate!
    true
  rescue
    false
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

  private
  def validate!
    raise 'Station name cannot be empty!' if name.empty?
    raise 'Station name should be at least 2 characters!' if name.length < 2
  end
end
