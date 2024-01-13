class API::V0::ForecastController < ApplicationController
  def show
    @forecast = ForecastFacade.forecast_info(params[:location])
  end
end
