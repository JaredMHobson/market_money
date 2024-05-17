class AtmFacade
  attr_reader :market

  def initialize(market)
    @market = market
  end

  def nearby_atms
    service = AtmService.new
    atm_data = service.get_nearest_atms(get_market_location)
    
    atm_data.each do |data|
      Atm.new(format_atm_data(data))
    end
  end

  private

  def get_market_location
    { lat: @market.lat, lon: @market.lon }
  end

  def format_atm_data(data)
    { name: data[:poi][:name], 
    address: data[:address][:freeformAddress],
    lat: data[:position][:lat],
    lon: data[:position][:lon],
    distance: data[:dist]
    }
  end
end