require "rails_helper"

RSpec.describe WeatherService do
  describe "Class Methods" do
    context ".location_format", :vcr do
      it "returns weather information after getting lat and lon" do
        attributes = {
          lat: "39.746",
          lng: "-104.99373"
        }

        location = Location.new(attributes)
        weather = WeatherService.get_forecast(location)

        expect(weather).to be_a(Hash)
        expect(weather[:current]).to be_an(Hash)
      end

      it "has the needed location Data" do
        attributes = {
          lat: "39.746",
          lng: "-104.99373"
        }

        location = Location.new(attributes)
        weather = WeatherService.get_forecast(location)

        expect(weather).to have_key(:current)
        expect(weather[:current]).to be_a(Hash)

        expect(weather).to have_key(:forecast)
        expect(weather[:forecast]).to be_a(Hash)

        expect(weather[:forecast]).to have_key(:forecastday)
        expect(weather[:forecast][:forecastday]).to be_a(Array)

        expect(weather[:forecast][:forecastday].first).to have_key(:day)
        expect(weather[:forecast][:forecastday].first[:day]).to be_a(Hash)

        expect(weather[:forecast][:forecastday].first).to have_key(:astro)
        expect(weather[:forecast][:forecastday].first[:astro]).to be_a(Hash)

        expect(weather[:forecast][:forecastday].first).to have_key(:hour)
        expect(weather[:forecast][:forecastday].first[:hour]).to be_a(Array)
      end
    end
  end
end
