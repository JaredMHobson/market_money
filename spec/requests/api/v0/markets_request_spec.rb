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

    # Tests will pass if you do market[:attributes][:id] like this
    # markets.each do |market|
      # expect(market).to have_key(:id)
      # expect(market[:attributes][:id]).to be_a Integer
    # end

    markets.each do |market|
      expect(market).to have_key(:id)
      expect(market[:id]).to be_a Integer

      expect(market).to have_key(:name)
      expect(market[:name]).to be_a String

      expect(market).to have_key(:street)
      expect(market[:street]).to be_a String

      expect(market).to have_key(:city)
      expect(market[:city]).to be_a String

      expect(market).to have_key(:county)
      expect(market[:county]).to be_a String

      expect(market).to have_key(:state)
      expect(market[:state]).to be_a String

      expect(market).to have_key(:zip)
      expect(market[:zip]).to be_a String

      expect(market).to have_key(:lat)
      expect(market[:lat]).to be_a String

      expect(market).to have_key(:lon)
      expect(market[:lon]).to be_a String

      expect(market).to have_key(:vendor_count)
      expect(market[:vendor_count]).to be_a Integer
    end
  end
end
