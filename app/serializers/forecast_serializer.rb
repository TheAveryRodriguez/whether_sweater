class ForecastSerializer
  def self.forecast_data(current, days, hours)
    {
      data: {
        id: "null",
        type: "forecast",
        attributes: {
          current_weather: {
            last_updated: current.last_updated,
            temperature: current.temperature,
            feels_like: current.feels_like,
            humidity: current.humidity,
            uvi: current.uvi,
            visibility: current.visibility,
            condition: current.condition,
            icon: current.icon
          },
          daily_weather: days.map do |day|
            {
              date: day.date,
              sunrise: day.sunrise,
              sunset: day.sunset,
              max_temp: day.max_temp,
              min_temp: day.min_temp,
              condition: day.condition,
              icon: day.icon
            }
          end,
          hourly_weather: hours.map do |hour|
            {
              time: hour.time,
              temperature: hour.temperature,
              condition: hour.condition,
              icon: hour.icon
            }
          end
        }
      }
    }
  end
end
