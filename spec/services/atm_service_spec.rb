require 'rails_helper'

RSpec.describe "Atm Service" do
  it "#conn" do
    service = AtmService.new
    connection = service.conn

    expect(connection).to be_an_instance_of Faraday::Connection
    expect(connection.params["key"]).to eq(Rails.application.credentials.tomtom[:key])
  end

  it "#get_url", :vcr do
    service = AtmService.new

    url = "nearbySearch/.json?lat=35.07904&lon=-106.60068&categorySet=7397"
    parsed_json = service.get_url(url)

    expect(parsed_json).to be_a Hash
    expect(parsed_json[:results]).to be_a Array
  end

  it "#get_nearest_atms", :vcr do
    location = { lon: -121.97483, lat: 36.98844 }
    service = AtmService.new

    expect(service.get_nearest_atms(location)).to be_a Array
  end
end
