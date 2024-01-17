class ForecastFacade
  def self.current_forecast(location)
    json = WeatherService.get_forecast(location)
    Current.new(json[:current])
  end

  def self.daily_forecast(location)
    json = WeatherService.get_forecast(location)
    json[:forecast][:forecastday].map do |data|
      Daily.new(data)
    end
  end

  def self.hourly_forecast(location)
    json = WeatherService.get_forecast(location)
    day = json[:forecast][:forecastday].map do |data|
      data[:hour].map do |h|
        Hourly.new(h)
      end
    end
    day.first
  end

  def self.travel_weather(location, hour)
    json = WeatherService.specific_forecast(location, hour)
    day = json[:forecast][:forecastday].map do |data|
      Hourly.new(data[:hour].first)
    end
    day.first
  end
end
