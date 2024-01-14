class WeatherService
  def self.conn
    Faraday.new(url: "http//api.weatherapi.com/v1")
  end

  def self.get_forecast(coordinates)
    response = conn.get("/forecast.json?key=#{ENV["weather_api"]}&q=#{coordinates}&days=5")

    JSON.parse(response.body, symbolize_names: true)
  end
end
