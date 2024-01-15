require "rails_helper"

RSpec.describe "Index", type: :request do
  describe "GET /api/v0/forecast", :vcr do
    context "When a valid location is used" do
      it "should return the details the weather", :vcr do
        get "/api/v0/forecast?location=conway,ar"

        expect(response).to be_successful

        response_data = JSON.parse(response.body, symbolize_names: true)

        expect(response_data[:data]).to have_key(:id)
        expect(response_data[:data][:id]).to be_a(String)

        expect(response_data[:data]).to have_key(:type)
        expect(response_data[:data][:type]).to be_a(String)
        expect(response_data[:data][:type]).to eq("forecast")

        current = response_data[:data][:attributes][:current_weather]

        expect(response_data[:data][:attributes]).to have_key(:current_weather)
        expect(response_data[:data][:attributes][:current_weather]).to be_a(Hash)
        expect(current).to have_key(:last_updated)
        expect(current[:last_updated]).to be_a(String)
        expect(current).to have_key(:temperature)
        expect(current[:temperature]).to be_a(Float)
        expect(current).to have_key(:feels_like)
        expect(current[:feels_like]).to be_a(Float)
        expect(current).to have_key(:humidity)
        expect(current[:humidity]).to be_a(Integer)
        expect(current).to have_key(:uvi)
        expect(current[:uvi]).to be_a(Float)
        expect(current).to have_key(:visibility)
        expect(current[:visibility]).to be_a(Float)
        expect(current).to have_key(:condition)
        expect(current[:condition]).to be_a(String)
        expect(current).to have_key(:icon)
        expect(current[:icon]).to be_a(String)

        expect(current).to_not have_key(:pressure_mb)
        expect(current).to_not have_key(:precip_in)
        expect(current).to_not have_key(:gust_mph)
        expect(current).to_not have_key(:wind_degree)
        expect(current).to_not have_key(:feelslike_c)
        expect(current).to_not have_key(:temp_c)

        expect(response_data[:data][:attributes][:daily_weather].count).to eq(5)
        expect(response_data[:data][:attributes]).to have_key(:daily_weather)
        expect(response_data[:data][:attributes][:daily_weather]).to be_a(Array)
        response_data[:data][:attributes][:daily_weather].each do |day|
          expect(day).to have_key(:date)
          expect(day[:date]).to be_a(String)
          expect(day).to have_key(:sunrise)
          expect(day[:sunrise]).to be_a(String)
          expect(day).to have_key(:sunset)
          expect(day[:sunset]).to be_a(String)
          expect(day).to have_key(:max_temp)
          expect(day[:max_temp]).to be_a(Float)
          expect(day).to have_key(:min_temp)
          expect(day[:min_temp]).to be_a(Float)
          expect(day).to have_key(:condition)
          expect(day[:condition]).to be_a(String)
          expect(day).to have_key(:icon)
          expect(day[:icon]).to be_a(String)

          expect(day).to_not have_key(:totalprecip_in)
          expect(day).to_not have_key(:avghumidity)
          expect(day).to_not have_key(:daily_chance_of_snow)
          expect(day).to_not have_key(:avgvis_miles)
          expect(day).to_not have_key(:moon_phase)
          expect(day).to_not have_key(:moonrise)
        end

        expect(response_data[:data][:attributes][:hourly_weather].count).to eq(24)
        expect(response_data[:data][:attributes]).to have_key(:hourly_weather)
        expect(response_data[:data][:attributes][:hourly_weather]).to be_a(Array)
        response_data[:data][:attributes][:hourly_weather].each do |hour|
          expect(hour).to have_key(:time)
          expect(hour[:time]).to be_a(String)
          expect(hour).to have_key(:temperature)
          expect(hour[:temperature]).to be_a(Float)
          expect(hour).to have_key(:condition)
          expect(hour[:condition]).to be_a(String)
          expect(hour).to have_key(:icon)
          expect(hour[:icon]).to be_a(String)

          expect(hour).to_not have_key(:time_epoch)
          expect(hour).to_not have_key(:wind_degree)
          expect(hour).to_not have_key(:heatindex_f)
          expect(hour).to_not have_key(:dewpoint_f)
          expect(hour).to_not have_key(:cloud)
          expect(hour).to_not have_key(:is_day)
        end
      end
    end

    context "When a valid location is used" do
      it "should return the details the weather", :vcr do
        get "/api/v0/forecast?location="

        response_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)

        expect(response_data).to have_key(:errors)
        expect(response_data[:errors].first).to have_key(:detail)

        expect(response_data[:errors].first[:detail]).to eq("Location can not be empty")
      end
    end
  end
end
