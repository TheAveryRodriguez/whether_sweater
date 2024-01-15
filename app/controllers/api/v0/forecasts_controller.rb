class Api::V0::ForecastsController < ApplicationController
  def index
    @location = MapquestFacade.get_location(Forecast.location_present(params[:location]))
    @current = ForecastFacade.current_forecast(@location)
    @daily = ForecastFacade.daily_forecast(@location)
    @hourly = ForecastFacade.hourly_forecast(@location)

    render json: ForecastSerializer.forecast_data(@current, @daily, @hourly)
  rescue => e
    render json: ErrorSerializer.format_errors(e.message), status: 404
  end
end
