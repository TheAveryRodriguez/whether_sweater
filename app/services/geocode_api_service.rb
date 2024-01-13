class GeocodeApiService
  def initialize(location)
    @location = location
  end

  def get_coordinates
    response = Faraday.get("https://www.mapquestapi.com/geocoding/v1/address?key=#{YOUR_MAPQUEST_API_KEY}&location=#{@location}")

    if response.success?
      data = JSON.parse(response.body)
      locations = data.dig("results", 0, "locations")
      coordinates = locations&.first&.dig("latLng")
      [coordinates["lat"], coordinates["lng"]] if coordinates
    else
      {error: "Failed to retrieve coordinates"}
    end
  end
end
