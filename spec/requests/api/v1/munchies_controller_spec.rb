require "rails_helper"

RSpec.describe "Munchies API" do
  describe "happy path" do
    it "can return the destination city and state name as a string", :vcr do
      get "/api/v1/munchies?destination=pueblo,co&food=chinese"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data[:data]).to have_key(:id)
      expect(response_data[:data][:id]).to be_a(String)

      expect(response_data[:data]).to have_key(:type)
      expect(response_data[:data][:type]).to be_a(String)
      expect(response_data[:data][:type]).to eq("munchie")

      expect(response_data[:data][:attributes]).to have_key(:destination_city)
      expect(response_data[:data][:attributes][:destination_city]).to be_a(String)
      expect(response_data[:data][:attributes][:destination_city]).to eq("pueblo,co")
    end

    it "returns the forecast for the destination city", :vcr do
      get "/api/v1/munchies?destination=pueblo,co&food=chinese"

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data[:data][:attributes][:forecast]).to have_key(:summary)
      expect(response_data[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(response_data[:data][:attributes][:forecast][:summary]).to eq("Clear")
      expect(response_data[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(response_data[:data][:attributes][:forecast][:temperature]).to be_a(Float)
      expect(response_data[:data][:attributes][:forecast][:temperature]).to eq(-0.9)
    end

    it "returns the restaurant that matches the food search", :vcr do
      get "/api/v1/munchies?destination=pueblo,co&food=chinese"

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data[:data][:attributes][:restaurant]).to have_key(:name)
      expect(response_data[:data][:attributes][:restaurant][:name]).to be_a(String)
      expect(response_data[:data][:attributes][:restaurant][:name]).to eq("Lin Express Chinese Restaurant")
      expect(response_data[:data][:attributes][:restaurant]).to have_key(:address)
      expect(response_data[:data][:attributes][:restaurant][:address]).to be_a(String)
      expect(response_data[:data][:attributes][:restaurant][:address]).to eq("132 W 29th St, Pueblo, CO 81008")
      expect(response_data[:data][:attributes][:restaurant]).to have_key(:rating)
      expect(response_data[:data][:attributes][:restaurant][:rating]).to be_a(Float)
      expect(response_data[:data][:attributes][:restaurant][:rating]).to eq(5.0)
      expect(response_data[:data][:attributes][:restaurant]).to have_key(:reviews)
      expect(response_data[:data][:attributes][:restaurant][:reviews]).to be_a(Integer)
      expect(response_data[:data][:attributes][:restaurant][:reviews]).to eq(5)
    end
  end
end
