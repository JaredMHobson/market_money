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

  # Get one Market
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

  # Search
  describe 'search functionality' do
    before :each do
      @market1 = Market.create!(state: "Colorado", city: "Denver", name: "Blah", street: "123 Main St", county: "Denver", zip: "80303", lat: "10", lon: "11")
      @market2 = Market.create!(state: "Colorado", city: "Jamestown", name: "Blah2", street: "222 Street Name", county: "Denver", zip: "80303", lat: "10", lon: "11")
      @market3 = Market.create!(state: "Nevada", city: "Las Vegas", name: "Blah3", street: "222 Street Name", county: "Denver", zip: "80303", lat: "10", lon: "11")
      @headers = {"CONTENT_TYPE" => "application/json"}
    end
    
    it 'can return results from state, city, and  name' do
      get '/api/v0/markets/search?city=Denver&name=Blah&state=Colorado', headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      search_data = JSON.parse(response.body, symbolize_names: true)
  
      markets = search_data[:data]
        # only @market1 expected
        expect(markets.first[:attributes][:name]).to eq(@market1.name)
        expect(markets.first[:attributes][:city]).to eq(@market1.city)
        expect(markets.first[:attributes][:state]).to eq(@market1.state)
    end

    it 'can return results from state' do
      get '/api/v0/markets/search?state=Colorado', headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      search_data = JSON.parse(response.body, symbolize_names: true)
  
      markets = search_data[:data]
        # markets 1 and 2
        expect(markets).to_not include(@market3)
        expect(markets.first[:attributes][:name]).to eq(@market1.name)
        expect(markets.first[:attributes][:city]).to eq(@market1.city)
        expect(markets.first[:attributes][:state]).to eq(@market1.state)
        expect(markets.second[:attributes][:name]).to eq(@market2.name)
        expect(markets.second[:attributes][:city]).to eq(@market2.city)
        expect(markets.second[:attributes][:state]).to eq(@market2.state)
    end

    it 'can return results from state and city' do
      get '/api/v0/markets/search?city=Denver&state=Colorado', headers: @headers

      expect(response).to be_successful
  
      search_data = JSON.parse(response.body, symbolize_names: true)
  
      markets = search_data[:data]
      # markets 1
        expect(markets).to_not include(@market3)
        expect(markets.first[:attributes][:name]).to eq(@market1.name)
        expect(markets.first[:attributes][:city]).to eq(@market1.city)
        expect(markets.first[:attributes][:state]).to eq(@market1.state)
    end

    it 'can return results from state and name' do
      get '/api/v0/markets/search?state=Colorado&name=Blah', headers: @headers

      expect(response).to be_successful
  
      search_data = JSON.parse(response.body, symbolize_names: true)
  
      markets = search_data[:data]
      # market 1
        expect(markets).to_not include(@market3, @market2)
        expect(markets.first[:attributes][:name]).to eq(@market1.name)
        expect(markets.first[:attributes][:city]).to eq(@market1.city)
        expect(markets.first[:attributes][:state]).to eq(@market1.state)
    end

    it 'can return results from name' do
      get '/api/v0/markets/search?state=Colorado&name=Blah', headers: @headers

      expect(response).to be_successful
  
      search_data = JSON.parse(response.body, symbolize_names: true)
  
      markets = search_data[:data]
      # market 1
        expect(markets).to_not include(@market3, @market2)
        expect(markets.first[:attributes][:name]).to eq(@market1.name)
        expect(markets.first[:attributes][:city]).to eq(@market1.city)
        expect(markets.first[:attributes][:state]).to eq(@market1.state)
    end

    it 'can search case insensitive and partials' do
      get '/api/v0/markets/search?state=Col&name=ah2&city=Jame', headers: @headers

      expect(response).to be_successful
  
      search_data = JSON.parse(response.body, symbolize_names: true)
  
      markets = search_data[:data]
      # market 2
        expect(markets).to_not include(@market3, @market1)
        expect(markets.first[:attributes][:name]).to eq(@market2.name)
        expect(markets.first[:attributes][:city]).to eq(@market2.city)
        expect(markets.first[:attributes][:state]).to eq(@market2.state)
    end
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

    xit 'does not return results by city' do
      get '/api/v0/markets/search?city=Denver', headers: @headers

      expect(response).to_not be_successful
      expect(response.status).to eq 422
  
      search_data = JSON.parse(response.body, symbolize_names: true)
  
      markets = search_data[:data]
      expect(markets).to eq nil
    end

    xit 'does not return results by city and name' do
      get '/api/v0/markets/search?city=Denver', headers: @headers

      expect(response).to_not be_successful
      expect(response.status).to eq 422
  
      search_data = JSON.parse(response.body, symbolize_names: true)
  
      markets = search_data[:data]
      expect(markets).to eq nil
    end
  end
end
