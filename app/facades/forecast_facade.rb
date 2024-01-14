class ForecastFacade
  def self.forecast_info(location)
    coordinates = MapquestService.get_coordinates(location)
    forecast_data = WeatherService.get_forecast(coordinates)

    Forecast.new(forecast_data, location)
  end
end
