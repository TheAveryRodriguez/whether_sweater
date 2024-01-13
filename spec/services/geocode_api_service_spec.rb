require "rails_helper"

RSpec.describe GeocodeApiService do
  let(:geocode) { GeocodeApiService.geocode("Denver,CO") }

  it "establishes a connection for geocode", :vcr do
    expect(geocode).to be_a(Hash)
    expect(geocode[:results]).to be_a(Array)
    expect(geocode[:results].first[:lat]).to be_a(String)
    expect(geocode[:results].first[:long]).to be_a(String)
  end
end
