class MarketSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :street, :city, :county, :state, :zip, :lat, :lon, :vendor_count

  has_many :vendors
end
