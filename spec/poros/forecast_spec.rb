require "rails_helper"

RSpec.describe Forecast do
  let(:forecast) { ForecastFacade.forecast_info("Denver,CO") }

  it "attributes", :vcr do
    expect(forecast.id).to eq(278)
    expect(forecast.location).to be_a(String)
    expect(forecast.current_weather).to be_a(String)
    expect(forecast.daily_weather).to be_a(String)
    expect(forecast.hourly_weather).to be_a(String)
  end
end
