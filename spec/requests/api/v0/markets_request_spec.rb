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
      expect(market).to have_key(:id)
      expect(market[:id]).to be_a String

      expect(market).to have_key(:type)
      expect(market[:type]).to eq('market')

      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_a Hash

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

    # Get one market
    it "returns a single market info" do
      id = create(:market).id
      get "/api/v0/markets/#{id}"

      expect(response).to be_successful

      market_data = JSON.parse(response.body, symbolize_names: true)

      market = market_data[:data]

      expect(market).to have_key(:id)
      expect(market[:id]).to be_a String

      expect(market).to have_key(:type)
      expect(market[:type]).to eq('market')

      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_a Hash

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

  describe 'Sad Paths' do
    it 'will send a 404 status and descriptive error message if an invalid market ID is passed' do
      get "/api/v0/markets/1"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=1")
    end
  end
end
