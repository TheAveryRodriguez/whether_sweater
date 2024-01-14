class MapquestService
  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/address")
  end

  def self.get_coordinates(location)
    response = conn.get("/key=#{consumer_key}&location=#{location}")

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.consumer_key
    Rails.application.credentials.mapquest_api.consumer_key
  end
end
