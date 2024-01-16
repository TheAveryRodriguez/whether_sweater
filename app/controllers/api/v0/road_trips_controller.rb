class Api::V0::RoadTripsController < ApplicationController
  def create
    @roadtrip_info = RoadtripFacade.get_roadtrip(params[:origin], params[:destination])

    @location_info = MapquestFacade.get_location(params[:destination])

    @weather = ForecastFacade.travel_weather(@location_info, @roadtrip_info.hour)

    render json: RoadtripSerializer.create_roadtrip(@roadtrip_info, @weather)
  end
end
