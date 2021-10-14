# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'
# class declaration
class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor_with_history :trains
  strong_attr_accessor :name, String
  validate :name, :presence
  validate :name, :type, String

  instances

  @@stations = []

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
end
