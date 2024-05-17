class AtmSerializer
  include JSONAPI::Serializer
  attributes :name, :address, :distance, :lon, :lat
end
