require 'rails_helper'

RSpec.describe "Vendors API" do
  # Get one vendor
  it "returns a single vendor info" do
    vendor = create(:vendor)
    get "/api/v0/vendors/#{vendor.id}"

    expect(response).to be_successful

    vendor_data = JSON.parse(response.body, symbolize_names: true)

    vendor = vendor_data[:data]
      expect(vendor_attributes).to have_key(:id)
      expect(vendor_attributes[:id]).to be_a Integer

      expect(vendor_attributes).to have_key(:name)
      expect(vendor_attributes[:name]).to be_a String

      expect(vendor_attributes).to have_key(:description)
      expect(vendor_attributes[:description]).to be_a String

      expect(vendor_attributes).to have_key(:contact_name)
      expect(vendor_attributes[:contact_name]).to be_a String

      expect(vendor_attributes).to have_key(:contact_phone)
      expect(vendor_attributes[:contact_phone]).to be_a String

      expect(vendor_attributes).to have_key(:credit_accepted)
      expect(vendor_attributes[:credit_accepted]).to be_in([true, false])
    end
  end

  it "returns a 404 if an invalid id is given" do

  end
end