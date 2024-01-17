require "rails_helper"

RSpec.describe Location do
  it "exists" do
    attributes = {
      lat: "123456789",
      lng: "987654321"
    }

    location = Location.new(attributes)

    expect(location).to be_a(Location)
    expect(location.lat).to eq("123456789")
    expect(location.lng).to eq("987654321")
  end
end
