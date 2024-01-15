class MapquestService
  def self.get_coordinates(location)
    get_url("address?location=#{location}")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/") do |faraday|
      faraday.headers["key"] = Rails.application.credentials.mapquest_api.consumer_key
    end
  end
end
