require 'rails_helper'

RSpec.describe Market, type: :model do
  describe '#relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
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
