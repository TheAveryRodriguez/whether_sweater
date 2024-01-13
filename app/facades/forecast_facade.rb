class ForecastFacade
  def self.get_forecast(location)
    coordinates = MapquestService.get_coordinates(location)
    forecast = WeatherService.get_forecast(coordinates)

    Forecast.new(forecast, location)
  end
end
