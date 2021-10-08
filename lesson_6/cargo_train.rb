require_relative 'train'

class CargoTrain < Train
  attr_reader :type
  qty_instances
  def initialize(number)
    @type = 'cargo'
    super
  end
end