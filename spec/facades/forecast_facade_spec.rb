require "rails_helper"

RSpec.describe ForecastFacade do
  let(:forecast_info) { ForecastFacade.forecast_info(location) }

  it "creates forecast poros", :vcr do
    expect(Forecast.first).to be_a(Forecast)
  end
end
