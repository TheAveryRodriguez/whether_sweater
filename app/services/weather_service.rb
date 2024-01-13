class WeatherService
  def self.conn
    Faraday.new(url: "http//api.weatherapi.com/v1")
  end

  def self.get_forecast(lat, long)
    response = conn.get("/forecast.json?key=#{ENV["weather_api"]}&q=#{lat},#{long}&days=5")

    JSON.parse(response.body, symbolize_names: true)
  end
end
