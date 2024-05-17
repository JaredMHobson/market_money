require 'rails_helper'

RSpec.describe "Atm Facade" do
  it "exists" do
    market = create(:market)
    facade = AtmFacade.new(market)

    expect(facade).to be_an_instance_of AtmFacade
  end

  it "has a market attribute" do
    market = create(:market)
    facade = AtmFacade.new(market)

    expect(facade.market).to be_an_instance_of Market
  end

  it "#nearby_atms" do
    market = create(:market)
    facade = AtmFacade.new(market)
    atms = facade.nearby_atms

    expect(atm_locations).to be_a Array
    atms.each do |atm|
      expect(atm[:lon]).to be_a Float
      expect(atm[:lat]).to be_a Float
      expect(atm[:dist]).to be_a Float
      expect(atm[:name]).to be_a String
      expect(atm[:address]).to be_a String
    end
  end
end