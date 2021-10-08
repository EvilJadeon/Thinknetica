require_relative 'train.rb'

class PassengerTrain < Train
  attr_reader :type
  qty_instances
  def initialize(number)
    @type = 'pass'
    super
  end
end