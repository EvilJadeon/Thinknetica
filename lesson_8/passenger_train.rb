require_relative 'train.rb'

class PassengerTrain < Train
  attr_reader :type
  instances
  def initialize(number)
    @type = 'pass'
    super
  end
end