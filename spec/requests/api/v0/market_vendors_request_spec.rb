require 'rails_helper'

describe "Market Vendors API" do
  # Get All Vendors for a market
  it "sends a list of vendors that belong to a market" do
    market1 = create(:market)
    market2 = create(:market)
    vendor1 = create(:vendor)
    vendor1 = create(:vendor)
    vendor2 = create(:vendor)
    vendor3 = create(:vendor)
    vendor4 = create(:vendor)

    create(:market_vendor, market: market1, vendor: vendor1)
    create(:market_vendor, market: market2, vendor: vendor2)
    create(:market_vendor, market: market1, vendor: vendor3)
    create(:market_vendor, market: market1, vendor: vendor4)

    get "/api/v0/markets/#{market1.id}/vendors"

    expect(response).to be_successful

    vendors_data = JSON.parse(response.body, symbolize_names: true)

    vendors = vendors_data[:data]

    expect(vendors.count).to eq(3)

    vendors.each do |vendor|
      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to be_a String

      expect(vendor).to have_key(:type)
      expect(vendor[:type]).to eq('vendor')

      expect(vendor).to have_key(:attributes)
      expect(vendor[:attributes]).to be_a Hash

      expect(vendor[:attributes]).to have_key(:name)
      expect(vendor[:attributes][:name]).to be_a String

      expect(vendor[:attributes]).to have_key(:description)
      expect(vendor[:attributes][:description]).to be_a String

      expect(vendor[:attributes]).to have_key(:contact_name)
      expect(vendor[:attributes][:contact_name]).to be_a String

      expect(vendor[:attributes]).to have_key(:contact_phone)
      expect(vendor[:attributes][:contact_phone]).to be_a String

      expect(vendor[:attributes]).to have_key(:credit_accepted)
      expect(vendor[:attributes][:credit_accepted]).to be_in([true, false])

      expect(vendor[:id]).to_not eq(vendor2.id.to_s)
    end
  end

    # Delete a MarketVendor
    it "can destroy a MarketVendor" do
      market1 = create(:market)
      market2 = create(:market)
      vendor1 = create(:vendor)
      vendor2 = create(:vendor)
      market_vendor1 = create(:market_vendor, market: market1, vendor: vendor2)
      market_vendor2 = create(:market_vendor, market: market2, vendor: vendor1)

      expect(MarketVendor.count).to eq(2)

      headers = {"CONTENT_TYPE" => "application/json"}

      delete "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_id: market1.id, vendor_id: vendor2.id)

      expect(response).to be_successful
      expect(response.status).to eq(204)
      expect(response.body).to be_empty
      expect(MarketVendor.count).to eq(1)
      expect{MarketVendor.find(market_vendor1.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(MarketVendor.find(market_vendor2.id)).to eq(market_vendor2)

      get "/api/v0/markets/#{market1.id}/vendors"

      vendors_data = JSON.parse(response.body, symbolize_names: true)

      vendors = vendors_data[:data]

      expect(vendors).to be_empty
    end

  # Create a new MarketVendor
  it "can create a new MarketVendor" do
    market = create(:market)
    vendor = create(:vendor)

    mv_params = ({
                    market_id: market.id,
                    vendor_id: vendor.id
                  })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(mv_params)

    expect(response.status).to eq(201)

    created_mv = MarketVendor.last

    expect(response).to be_successful
    expect(created_mv.market_id).to eq(mv_params[:market_id])
    expect(created_mv.vendor_id).to eq(mv_params[:vendor_id])
    expect(market.vendors).to include(vendor)
    expect(vendor.markets).to include(market)
  end

  describe 'Sad Paths' do
    it 'when sending a GET all vendors for a market request, will send a 404 status and descriptive error message if an invalid market ID is passed' do
      get "/api/v0/markets/1/vendors"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=1")
    end

    it 'when sending a GET all vendors for a market request, will send a 404 status and descriptive error message if an invalid market ID is passed' do
      headers = {"CONTENT_TYPE" => "application/json"}

      delete "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_id: 1, vendor_id: 1)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=1")

      market_id = create(:market).id

      headers = {"CONTENT_TYPE" => "application/json"}

      delete "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_id: market_id, vendor_id: 1)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=1")
    end

    it 'when sending a POST new MarketVendor for a MarketVendor request, will send a 404 status and descriptive error message if an invalid market or vendor ID is passed' do
      market = create(:market)
      vendor = create(:vendor)

      mv_params = ({
                      market_id: 1,
                      vendor_id: vendor.id
                    })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(mv_params)

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=1")

      mv_params = ({
                      market_id: market.id,
                      vendor_id: 1
                    })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(mv_params)

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=1")
    end

    it 'when sending a POST new MarketVendor for a MarketVendor request, will send a 400 status and descriptive error message if a vendor id and/or a market id' do
      vendor = create(:vendor)

      mv_params = ({
                      vendor_id: vendor.id
                    })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(mv_params)

      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("400")
      expect(data[:errors].first[:title]).to eq("A market_id and vendor_id are required")
    end

    it 'when sending a POST new MarketVendor for a MarketVendor request, will send a 422 status and descriptive error message if that market/vendor combo already exists' do
      market = create(:market)
      vendor = create(:vendor)
      create(:market_vendor, market: market, vendor: vendor)

      mv_params = ({
                      market_id: market.id,
                      vendor_id: vendor.id
                    })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("422")
      expect(data[:errors].first[:title]).to eq("Duplicate MarketVendor record")
    end
  end
end
