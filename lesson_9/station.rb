# frozen_string_literal: true

require_relative 'instance_counter'
# class declaration
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
  rescue StandardError
    false
  end

  def station_block(&block)
    @trains.each(&block)
  end

  def add_train(train)
    @trains << train
  end

  def return_train_type(type)
    @trains.select { |train| train.type == type }
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def length
    @name.length
  end

  private

  def validate!
    raise 'Station name cannot be empty!' if name.nil?
    raise 'Station name should be at least 2 characters!' if name.length < 2
  end
end
