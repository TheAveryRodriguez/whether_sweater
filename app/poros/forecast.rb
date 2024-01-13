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
      datetime: Time.at(current[:dt]),
      sunrise: Time.at(current[:sunrise]),
      sunset: Time.at(current[:sunset]),
      temperature: current[:temp],
      feels_like: current[:feels_like],
      humidity: current[:humidity],
      uvi: current[:uvi],
      visibility: current[:visibility],
      conditions: current[:weather][0][:description],
      icon: current[:weather][0][:icon]
    }
  end

  def daily_weather(daily)
    daily[0..4].map do |day|
      {
        date: Time.at(day[:dt]),
        sunrise: Time.at(day[:sunrise]),
        sunset: Time.at(day[:sunset]),
        max_temp: day[:temp][:max],
        min_temp: day[:temp][:min],
        conditions: day[:weather][0][:description],
        icon: day[:weather][0][:icon]
      }
    end
  end

  def hourly_weather(hourly)
    hourly[0..7].map do |hour|
      {
        time: Time.at(hour[:dt]),
        temperature: hour[:temp],
        conditions: hour[:weather][0][:description],
        icon: hour[:weather][0][:icon]
      }
    end
  end
end
