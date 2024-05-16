require 'rails_helper'

describe "Vendors API" do
  # Create a new Vendor
  it "can create a new vendor" do
    vendor_params = ({
                    name: 'Cool Vendor Name',
                    description: 'We sell cool things',
                    contact_name: 'Coolio',
                    contact_phone: '(123) 456 7890.',
                    credit_accepted: false
                  })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)

    expect(response.status).to eq(201)

    created_vendor = Vendor.last

    expect(response).to be_successful
    expect(created_vendor.name).to eq(vendor_params[:name])
    expect(created_vendor.description).to eq(vendor_params[:description])
    expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
    expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
    expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
  end

  # Delete a Vendor
  it "can destroy a vendor and its MarketVendors" do
    vendor = create(:vendor)
    market_vendor = create(:market_vendor, vendor: vendor)

    expect(Vendor.count).to eq(1)

    delete "/api/v0/vendors/#{vendor.id}"

    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(Vendor.count).to eq(0)
    expect{Vendor.find(vendor.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect{MarketVendor.find(market_vendor.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  describe 'Sad Paths' do
    it 'when sending a DELETE vendor request, will send a 404 status and descriptive error message if an invalid vendor ID is passed' do
      delete '/api/v0/vendors/1'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=1")
    end

    it 'when sending a CREATE vendor request, will send a 400 status and descriptive error message if any attributes are left out when creating a vendor' do
      vendor_params = ({
        name: 'Cool Vendor Name',
        contact_phone: '(123) 456 7890.',
        credit_accepted: false
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)

      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("400")
      expect(data[:errors].first[:title]).to eq("Validation failed: Description can't be blank, Contact name can't be blank")
    end

    it "returns a 404 if an invalid id is given" do
      get "/api/v0/vendors/1"
  
      expect(response).to have_http_status(404)
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response[:errors]).to be_a Array
      expect(error_response[:errors].first[:status]).to eq("404")
      expect(error_response[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=1")
    end
  end

  # get one vendor
  it "returns a single vendor info" do
    id = create(:vendor).id
    get "/api/v0/vendors/#{id}"

    expect(response).to be_successful

    vendor_data = JSON.parse(response.body, symbolize_names: true)

    vendor = vendor_data[:data]

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
