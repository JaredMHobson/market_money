class Atm
  attr_reader :lon,
              :lat,
              :distance,
              :name,
              :address,
              :id

  def initialize(attributes)
    @id = nil
    @lon = attributes[:lon]
    @lat = attributes[:lat]
    @distance = attributes[:distance]
    @name = attributes[:name]
    @address = attributes[:address]
  end
end
