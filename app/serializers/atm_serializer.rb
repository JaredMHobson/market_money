class AtmSerializer
  include JSONAPI::Serializer
  attributes :name, :address, :dist, :lon, :lat
end
