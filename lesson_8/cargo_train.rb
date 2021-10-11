require_relative 'train'

class CargoTrain < Train
  attr_reader :type
  instances
  def initialize(number)
    @type = 'cargo'
    super
  end
end