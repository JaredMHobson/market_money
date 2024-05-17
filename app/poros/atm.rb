class Atm
  attr_reader :lon,
              :lat,
              :dist,
              :name,
              :address

  def initialize(attributes)
    @lon = attributes[:lon]
    @lat = attributes[:lat]
    @dist = attributes[:dist]
    @name = attributes[:name]
    @address = attributes[:address]
  end

end