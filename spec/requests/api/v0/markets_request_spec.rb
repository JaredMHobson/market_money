require 'rails_helper'

describe "Markets API" do
  # Get All Markets
  it "sends a list of markets" do
    create_list(:market, 3)

    get '/api/v0/markets'

    expect(response).to be_successful

    market_data = JSON.parse(response.body, symbolize_names: true)

    markets = market_data[:data]

    expect(markets.count).to eq(3)

    markets.each do |market|
      expect(market[:attributes]).to have_key(:id)
      expect(market[:attributes][:id]).to be_a Integer

      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to be_a String

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to be_a String

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to be_a String

      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to be_a String

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to be_a String

      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to be_a String

      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes][:lat]).to be_a String

      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to be_a String

      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:attributes][:vendor_count]).to be_a Integer
    end
  end

    it "returns a single market info" do
      id = create(:market).id
      get "/api/v0/markets/#{id}"
  
      expect(response).to be_successful
  
      market_data = JSON.parse(response.body, symbolize_names: true)
  
      market = market_data[:data]
    
        expect(market[:attributes]).to have_key(:id)
        expect(market[:attributes][:id]).to be_a Integer
  
        expect(market[:attributes]).to have_key(:name)
        expect(market[:attributes][:name]).to be_a String
  
        expect(market[:attributes]).to have_key(:street)
        expect(market[:attributes][:street]).to be_a String
  
        expect(market[:attributes]).to have_key(:city)
        expect(market[:attributes][:city]).to be_a String
  
        expect(market[:attributes]).to have_key(:county)
        expect(market[:attributes][:county]).to be_a String
  
        expect(market[:attributes]).to have_key(:state)
        expect(market[:attributes][:state]).to be_a String
  
        expect(market[:attributes]).to have_key(:zip)
        expect(market[:attributes][:zip]).to be_a String
  
        expect(market[:attributes]).to have_key(:lat)
        expect(market[:attributes][:lat]).to be_a String
  
        expect(market[:attributes]).to have_key(:lon)
        expect(market[:attributes][:lon]).to be_a String
  
        expect(market[:attributes]).to have_key(:vendor_count)
        expect(market[:attributes][:vendor_count]).to be_a Integer
  end
end
