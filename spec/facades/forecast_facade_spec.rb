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

    it "calls MapquestService.get_coordinates with the correct parameters" do
      ForecastFacade.forecast_info(location)
      expect(MapquestService).to have_received(:get_coordinates).with(location)
    end

    it "calls WeatherService.get_forecast with the correct parameters" do
      ForecastFacade.forecast_info(location)
      expect(WeatherService).to have_received(:get_forecast).with(coordinates)
    end

    it "returns a Forecast object" do
      result = ForecastFacade.forecast_info(location)
      expect(result).to be_a(Forecast)
      expect(result.location).to eq(location)
      expect(result.data).to eq(forecast)
    end
  end
end
