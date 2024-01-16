require "rails_helper"

RSpec.describe MapquestService do
  describe "Class Methods" do
    context ".location_format", :vcr do
      it "returns geolocation information after getting an address" do
        location = MapquestService.get_coordinates("conway,ar")

        expect(location).to be_a(Hash)
        expect(location[:results]).to be_an(Array)
      end

      it "has the needed location Data" do
        location = MapquestService.get_coordinates("conway,ar")
        location_data = location[:results].first[:locations].first

        expect(location_data).to have_key(:latLng)
        expect(location_data[:latLng]).to be_a(Hash)

        expect(location_data[:latLng]).to have_key(:lat)
        expect(location_data[:latLng][:lat]).to be_a(Float)

        expect(location_data[:latLng]).to have_key(:lng)
        expect(location_data[:latLng][:lng]).to be_a(Float)
      end
    end

    context ".get_directions", :vcr do
      it "gets directions from an origin to a destination" do
        route_info = MapquestService.get_directions("conway,ar", "dallas,tx")

        expect(route_info).to be_a(Hash)

        expect(route_info[:route]).to have_key(:formattedTime)
        expect(route_info[:route][:formattedTime]).to be_a(String)
      end
    end
  end
end
