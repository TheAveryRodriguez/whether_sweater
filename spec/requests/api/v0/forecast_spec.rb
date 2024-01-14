require "rails_helper"

RSpec.describe "Forecast" do
  context "happy path endpoints" do
    it "can get merchants for case insensitive name search" do
      create(:merchant, name: "Channel Catfish")

      get "/api/v0/forecast"

      # merchant_json = JSON.parse(response.body, symbolize_names: true)

      # merchant = merchant_json[:data]

      # expect(response).to be_successful

      # expect(merchant).to be_a(Array)
      # expect(merchant.first[:attributes]).to be_a(Hash)
      # expect(merchant.first[:attributes]).to have_key(:name)
      # expect(merchant.first[:attributes][:name]).to eq("Largemouth Bass")
    end
  end

  context "sad path endpoints" do
    it "gets empty array for merchants case insensitive name search" do
      get "/api/v0/forecast"

      # merchant_json = JSON.parse(response.body, symbolize_names: true)

      # expect(response).to be_successful
      # expect(merchant_json[:data]).to be_a(Array)
      # expect(merchant_json[:data].empty?).to be(true)
    end
  end
end
