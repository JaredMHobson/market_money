require 'rails_helper'

RSpec.describe Market, type: :model do
  describe '#relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe '#validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:county) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lon) }
  end

  describe '#vendor_count' do
    it 'returns a count of the number of vendors that it has' do
      market1 = create(:market)
      market2 = create(:market)

      create_list(:market_vendor, 3, market: market1)
      create_list(:market_vendor, 1, market: market2)

      expect(market1.vendor_count).to eq(3)
      expect(market2.vendor_count).to eq(1)
    end
  end

  describe '#search' do
    before :each do
      @market = Market.create!(state: "Colorado", city: "Denver", name: "Blah", street: "123 Main St", county: "Denver", zip: "80303", lat: "10", lon: "11")
    end

    it 'can return results from state, city, and  name' do
      search_params = {
                        state: "Colorado",
                        city: "Denver",
                        name: "Blah"
                      }

      expect(Market.search(search_params)).to eq([@market])
    end

    it 'can return results from state' do
      search_params = {state: "Colorado"}

      expect(Market.search(search_params)).to eq([@market])
    end

    it 'can return results from state and city' do
      search_params = {
                      state: "Colorado",
                      city: "Denver"
                      }

      expect(Market.search(search_params)).to eq([@market])
    end

    it 'can return results from state and name' do
      search_params = {
                        state: "Colorado",
                        name: "Blah"
                      }

      expect(Market.search(search_params)).to eq([@market])
    end

    it 'can return results from name' do
      search_params = {name: "Blah"}

      expect(Market.search(search_params)).to eq([@market])
    end

    it 'can search case insensitive and partials' do
      search_params = {
                      state: "col",
                      city: "Denv",
                      name: "Bl"
                        }

        expect(Market.search(search_params)).to eq([@market])
    end

    it 'does not return results by city' do
      search_params = {city: "Denver"}

      expect(Market.search(search_params)).to eq nil
    end

    it 'does not return results by city and name' do
      search_params = {
                      city: "Denver",
                      name: "Blah"
                      }

      expect(Market.search(search_params)).to eq nil
    end
  end
end
