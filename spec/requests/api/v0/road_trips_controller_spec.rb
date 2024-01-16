require "rails_helper"

RSpec.describe "Create", type: :request do
  describe "POST /api/v0/road_trip", :vcr do
    context "When a location is used" do
      it "should return info for the roadtrip if location is valid", :vcr do
        headers_user = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload_user = {
          email: "email@email.com",
          password: "password123",
          password_confirmation: "password123"
        }
        body_user = JSON.generate(payload_user)

        post "/api/v0/users", headers: headers_user, params: body_user

        headers_rt = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload_rt = {
          origin: "Conway,AR",
          destination: "Dallas,TX",
          api_key: User.last.api_key
        }
        body_rt = JSON.generate(payload_rt)

        post "/api/v0/road_trip", headers: headers_rt, params: body_rt

        expect(response).to be_successful

        response_data = JSON.parse(response.body, symbolize_names: true)

        expect(response_data[:data]).to have_key(:id)
        expect(response_data[:data][:id]).to be_a(String)
        expect(response_data[:data][:id]).to eq("null")

        expect(response_data[:data]).to have_key(:type)
        expect(response_data[:data][:type]).to be_a(String)
        expect(response_data[:data][:type]).to eq("road_trip")

        expect(response_data[:data]).to have_key(:attributes)
        expect(response_data[:data][:attributes]).to be_a(Hash)

        expect(response_data[:data][:attributes]).to have_key(:start_city)
        expect(response_data[:data][:attributes][:start_city]).to be_a(String)

        expect(response_data[:data][:attributes]).to have_key(:end_city)
        expect(response_data[:data][:attributes][:end_city]).to be_a(String)

        expect(response_data[:data][:attributes]).to have_key(:travel_time)
        expect(response_data[:data][:attributes][:travel_time]).to be_a(String)

        expect(response_data[:data][:attributes]).to have_key(:weather_at_eta)
        expect(response_data[:data][:attributes][:weather_at_eta]).to be_a(Hash)

        expect(response_data[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
        expect(response_data[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)

        expect(response_data[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(response_data[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)

        expect(response_data[:data][:attributes][:weather_at_eta]).to have_key(:condition)
        expect(response_data[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
      end

      it "should return appropriate info for the roadtrip if location is invalid", :vcr do
        headers_user = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload_user = {
          email: "email@email.com",
          password: "password123",
          password_confirmation: "password123"
        }
        body_user = JSON.generate(payload_user)

        post "/api/v0/users", headers: headers_user, params: body_user

        headers_rt = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload_rt = {
          origin: "Conway,AR",
          destination: "Moscow,RU",
          api_key: User.last.api_key
        }
        body_rt = JSON.generate(payload_rt)

        post "/api/v0/road_trip", headers: headers_rt, params: body_rt

        expect(response).to be_successful

        response_data = JSON.parse(response.body, symbolize_names: true)

        expect(response_data[:data]).to have_key(:id)
        expect(response_data[:data][:id]).to be_a(String)
        expect(response_data[:data][:id]).to eq("null")

        expect(response_data[:data]).to have_key(:type)
        expect(response_data[:data][:type]).to be_a(String)
        expect(response_data[:data][:type]).to eq("road_trip")

        expect(response_data[:data]).to have_key(:attributes)
        expect(response_data[:data][:attributes]).to be_a(Hash)

        expect(response_data[:data][:attributes]).to have_key(:start_city)
        expect(response_data[:data][:attributes][:start_city]).to be_a(String)

        expect(response_data[:data][:attributes]).to have_key(:end_city)
        expect(response_data[:data][:attributes][:end_city]).to be_a(String)

        expect(response_data[:data][:attributes]).to have_key(:travel_time)
        expect(response_data[:data][:attributes][:travel_time]).to be_a(String)
        expect(response_data[:data][:attributes][:travel_time]).to eq("Impossible")

        expect(response_data[:data][:attributes]).to have_key(:weather_at_eta)
        expect(response_data[:data][:attributes][:weather_at_eta]).to be_a(String)
        expect(response_data[:data][:attributes][:weather_at_eta]).to eq("")
      end
    end

    context "the api_key does not is invaild" do
      it "should give appropriate response if key is invalid", :vcr do
        headers_user = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload_user = {
          email: "email@email.com",
          password: "password123",
          password_confirmation: "password123"
        }
        body_user = JSON.generate(payload_user)

        post "/api/v0/users", headers: headers_user, params: body_user

        headers_rt = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload_rt = {
          origin: "Conway,AR",
          destination: "Dallas,TX",
          api_key: "keyisnotvalid"
        }
        body_rt = JSON.generate(payload_rt)

        post "/api/v0/road_trip", headers: headers_rt, params: body_rt

        response_data = JSON.parse(response.body, symbolize_names: true)
        expect(response).to_not be_successful
        expect(response).to have_http_status(401)

        expect(response_data).to have_key(:errors)
        expect(response_data[:errors].first).to have_key(:detail)

        expect(response_data[:errors].first[:detail]).to eq("Key not Authorized")
      end

      it "should give appropriate response if key is nil", :vcr do
        headers_user = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload_user = {
          email: "email@email.com",
          password: "password123",
          password_confirmation: "password123"
        }
        body_user = JSON.generate(payload_user)

        post "/api/v0/users", headers: headers_user, params: body_user

        headers_rt = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload_rt = {
          origin: "Conway,AR",
          destination: "Dallas,TX",
          api_key: nil
        }
        body_rt = JSON.generate(payload_rt)

        post "/api/v0/road_trip", headers: headers_rt, params: body_rt

        response_data = JSON.parse(response.body, symbolize_names: true)
        expect(response).to_not be_successful
        expect(response).to have_http_status(401)

        expect(response_data).to have_key(:errors)
        expect(response_data[:errors].first).to have_key(:detail)

        expect(response_data[:errors].first[:detail]).to eq("Key not Authorized")
      end
    end
  end
end
