class Api::V0::WeatherController < ApplicationController
  def forecast
    location = params[:location]
    coordinates = GeocodeApiService.new(location).get_coordinates
    forecast_data = WeatherApiService.new(coordinates).get_forecast
    render json: {forecast: forecast_data}
  end
end
