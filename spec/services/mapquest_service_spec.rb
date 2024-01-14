require "rails_helper"

RSpec.describe MapquestService do
  let(:get_coordinates) { MapquestService.get_coordinates("Denver,CO") }

  it "establishes a connection for get coordinates", :vcr do
    expect(get_coordinates).to be_a(Hash)
    expect(get_coordinates[:results]).to be_a(Array)
    expect(get_coordinates[:results].first[:title]).to be_a(String)
    expect(get_coordinates[:results].first[:title]).to eq("Your Eyes Tell")
  end
end
