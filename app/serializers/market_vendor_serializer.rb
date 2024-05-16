class MarketVendorSerializer
  include JSONAPI::Serializer
  attributes :market, :vendor

  belongs_to :market
  belongs_to :vendor
end
