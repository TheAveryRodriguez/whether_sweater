class Api::V0::ForecastsController < ApplicationController
  def show
    conn = Faraday.new(url: "") do |faraday|
      faraday.headers[] = Rails.application.credentials.mapquest[:key]
    end

    response = conn.get("")

    data = JSON.parse(response.body, symbolize_names: true)
  end
end
