class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :location, :current_weather, :daily_weather, :hourly_weather
end
