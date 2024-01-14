class Forecast
  attr_reader :id, :location, :current_weather, :daily_weather, :hourly_weather

  def initialize(forecast, location)
    @id = nil
    @location = location
    @current_weather = current_weather(forecast[:current])
    @daily_weather = daily_weather(forecast[:daily])
    @hourly_weather = hourly_weather(forecast[:hourly])
  end

  private

  def current_weather(current)
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

  def daily_weather(daily)
    daily[0..4].map do |day|
      {
        date: Time.at(day[:forecast][:forecastday][:date]),
        sunrise: Time.at(day[:forecast][:forecastday][:astro][:sunrise]),
        sunset: Time.at(day[:forecast][:forecastday][:astro][:sunset]),
        max_temp: day[:forecast][:forecastday][:day][:maxtemp_f],
        min_temp: day[:forecast][:forecastday][:day][:mintemp_f],
        conditions: day[:forecast][:forecastday][:day][:condition][:text],
        icon: day[:forecast][:forecastday][:day][:condition][:icon]
      }
    end
  end

  def hourly_weather(hourly)
    hourly[0..7].map do |hour|
      {
        time: Time.at(hour[:forecast][:forecastday][:hour][:time]),
        temperature: hour[:forecast][:forecastday][:hour][:temp_f],
        conditions: hour[:forecast][:forecastday][:hour][:condition][:text],
        icon: hour[:forecast][:forecastday][:hour][:condition][:icon]
      }
    end
  end
end
