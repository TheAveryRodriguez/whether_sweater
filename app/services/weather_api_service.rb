# app/services/weather_service.rb

class WeatherApiService
  def initialize(coordinates)
    @coordinates = coordinates
  end

  def get_forecast
    response = Faraday.get("https://api.weatherprovider.com/forecast?key=#{YOUR_WEATHER_API_KEY}&lat=#{@coordinates[0]}&lon=#{@coordinates[1]}")

    if response.success?
      data = JSON.parse(response.body)
    else
      {error: "Failed to retrieve weather data"}
    end
  end
end
