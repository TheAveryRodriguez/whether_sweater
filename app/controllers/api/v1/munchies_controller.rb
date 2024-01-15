class Api::V1::MunchiesController < ApplicationController
  def index
    @location = MapquestFacade.get_location(Forecast.location_present(params[:destination]))
    @current = ForecastFacade.current_forecast(@location)
    @restaurant = YelpFacade.get_restaurant(params[:destination], params[:food])

    render json: MunchiesSerializer.munchies_data(@current, @restaurant, params[:destination])
  end
end
