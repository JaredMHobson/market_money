class AtmService
  def get_nearest_atms(location)
    get_url("nearbySearch/.json?lat=#{location[:lat]}&lon=#{location[:lon]}categorySet=7397")[:results]
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.tomtom.com/search/2/") do |faraday|
      faraday.params["key"] = Rails.application.credentials.tomtom[:key]
    end
  end
end

