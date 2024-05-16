require 'rails_helper'

RSpec.describe "Vendors API" do
  # Get one vendor
  it "returns a single vendor info" do
    id = create(:vendor).id
    get "/api/v0/vendors/#{id}"

    expect(response).to be_successful

    vendor_data = JSON.parse(response.body, symbolize_names: true)

    vendor = vendor_data[:data]

      expect(vendor[:attributes]).to have_key(:id)
      expect(vendor[:attributes][:id]).to be_a String

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

  it "returns a 404 if an invalid id is given" do
    get "/api/v0/vendors/123123132123"

    expect(response).to have_http_status(404)
    error_response = JSON.parse(response.body, sympboliez_names: true)

    expect(error_response[:errors]).to be_a Array
    expect(error_response[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=123123132123")
  end
end