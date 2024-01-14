require "rails_helper"

RSpec.describe WeatherService do
  let(:get_forecast) { WeatherService.get_forecast("48.8567,2.3508") }

  it "establishes a connection for get forecast", :vcr do
    expect(get_forecast).to be_a(Hash)
    expect(get_forecast[:results]).to be_a(Array)
    expect(get_forecast[:results].first[:title]).to be_a(String)
    expect(get_forecast[:results].first[:title]).to eq("Your Eyes Tell")
  end
end
