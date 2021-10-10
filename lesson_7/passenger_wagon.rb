require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :type
  def initialize
    @type = 'pass'
    super
  end
end