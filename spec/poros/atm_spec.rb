require 'rails_helper'

RSpec.describe "Atm" do
  it "exists" do
    atm_attributs = { lon: -121.97483, lat: 36.98844, dist: 34.93292, name: "Blah", address: "123 Main St Denver CO" }
    atm = Atm.new(atm_attributs)
  end

  it "has lon, lat, dist, name, and address attributes" do
    atm_attributs = { lon: -121.97483, lat: 36.98844, dist: 34.93292, name: "Blah", address: "123 Main St Denver CO" }
    atm = Atm.new(atm_attributs)

    expect(atm.lon).to eq(-121.97483)
    expect(atm.lat).to eq(36.98844)
    expect(atm.dist).to eq(34.93292)
    expect(atm.name).to eq("Blah")
    expect(atm.address).to eq("123 Main St Denver CO")
  end
end