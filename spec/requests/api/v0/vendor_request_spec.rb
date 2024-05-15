require 'rails_helper'

describe "Vendors API" do
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
    end
  end

  describe 'Sad Paths' do
    it 'will send a 404 status and descriptive error message if an invalid market ID is passed' do
      get "/api/v0/markets/1/vendors"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=1")
    end
  end
end
