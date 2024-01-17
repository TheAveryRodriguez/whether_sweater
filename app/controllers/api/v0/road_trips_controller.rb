class Api::V0::RoadTripsController < ApplicationController
  def create
    if Roadtrip.valid_key?(params)
      @route_info = RoadtripFacade.get_roadtrip(params[:origin], params[:destination])

      @location_info = MapquestFacade.get_location(params[:destination])

      @weather = ForecastFacade.travel_weather(@location_info, @route_info.hour)

      render json: RoadtripSerializer.create_roadtrip(@route_info, @weather)
    end
  rescue ActiveRecord::StatementInvalid => e
    render json: ErrorSerializer.format_errors(e.message), status: 401
  end
end
