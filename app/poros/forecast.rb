class Forecast
  attr_reader :id, :forecast_data, :location

  def initialize(forecast_data, location)
    @id = nil
    @forecast_data = forecast
    @location = location
    # @current_weather = current_weather(forecast[:current])
    # @daily_weather = daily_weather(forecast[:daily])
    # @hourly_weather = hourly_weather(forecast[:hourly])
  end

  def current_weather
    current = forecast[:current]
    {
      last_updated: Time.at(current[:last_updated]),
      temperature: current[:temp_f],
      feels_like: current[:feels_like_f],
      humidity: current[:humidity],
      uvi: current[:uv],
      visibility: current[:vis_miles],
      conditions: current[:condition][:text],
      icon: current[:weather][0][:icon]
    }
  end

  def daily_weather
    daily = forecast[:forecast][:forecastday]

    daily[0..4].map do |day|
      {
        date: Time.at(day[:date]),
        sunrise: Time.at(day[:astro][:sunrise]),
        sunset: Time.at(day[:astro][:sunset]),
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        conditions: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def hourly_weather
    hourly = forecast[:forecast][:forecastday][:hour]

    hourly[0..7].map do |hour|
      {
        time: Time.at(hour[:time]),
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end
