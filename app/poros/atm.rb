class Atm
  attr_reader :lon,
              :lat,
              :dist,
              :name,
              :address,
              :id

  def initialize(attributes)
    @id = nil
    @lon = attributes[:lon]
    @lat = attributes[:lat]
    @dist = attributes[:dist]
    @name = attributes[:name]
    @address = attributes[:address]
  end

end