require "rails_helper"

RSpec.describe WeatherService do
  describe "Class Methods" do
    context ".location_format", :vcr do
      it "returns weather information after getting lat and lon" do
        attributes = {
          lat: "35.090328",
          lng: "-92.441559"
        }

        location = Location.new(attributes)
        weather = WeatherService.get_forecast(location)

        expect(weather).to be_a(Hash)
        expect(weather[:current]).to be_an(Hash)
      end

      it "has the needed location Data" do
        attributes = {
          lat: "35.090328",
          lng: "-92.441559"
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

    context ".specific_forecast", :vcr do
      it "returns weather information for location and an hour" do
        attributes = {
          lat: "35.090328",
          lng: "-92.441559"
        }

        location = Location.new(attributes)
        weather = WeatherService.specific_forecast(location, 16)

        expect(weather).to be_a(Hash)
        expect(weather[:forecast]).to be_a(Hash)
        expect(weather[:forecast][:forecastday]).to be_an(Array)
        expect(weather[:forecast][:forecastday].first[:hour]).to be_an(Array)
      end

      it "has the needed Hour Data" do
        attributes = {
          lat: "35.090328",
          lng: "-92.441559"
        }

        location = Location.new(attributes)
        arrival_weather = WeatherService.specific_forecast(location, 16)
        hour_data = arrival_weather[:forecast][:forecastday].first[:hour]

        expect(hour_data).to be_a(Array)
        expect(hour_data.count).to eq(1)

        expect(hour_data.first).to have_key(:time)
        expect(hour_data.first[:time]).to be_a(String)

        expect(hour_data.first).to have_key(:temp_f)
        expect(hour_data.first[:temp_f]).to be_a(Float)

        expect(hour_data.first).to have_key(:condition)
        expect(hour_data.first[:condition]).to be_a(Hash)

        expect(hour_data.first[:condition]).to have_key(:text)
        expect(hour_data.first[:condition][:text]).to be_a(String)
      end
    end
  end
end
