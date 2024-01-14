require "rails_helper"

RSpec.describe ForecastFacade, type: :facade do
  describe ".forecast_info" do
    let(:location) { "cincinnati,oh" }
    let(:coordinates) { {lat: 39.1031, lon: 84.5120} }
    let(:forecast) { {temperature: 75, conditions: "Sunny"} }

    before do
      allow(MapquestService).to receive(:get_coordinates).with(location).and_return(coordinates)
      allow(WeatherService).to receive(:get_forecast).with(coordinates).and_return(forecast)
    end

    it "returns a Forecast object" do
      forecast = ForecastFacade.forecast_info(location)
      expect(forecast).to be_a(Forecast)
      expect(forecast.location).to eq(location)
      expect(forecast.forecast_data).to eq(forecast)
    end
  end
end
