require "rails_helper"

RSpec.describe YelpService do
  describe "Class Methods" do
    context ".get_restaurant", :vcr do
      it "returns restaurant information after getting a destination and food type" do
        restaurant = YelpService.get_restaurant("pueblo,co", "chinese")

        expect(restaurant).to be_a(Hash)
        expect(restaurant[:businesses]).to be_an(Array)
      end

      it "has the needed destination data" do
        restaurant = YelpService.get_restaurant("pueblo,co", "chinese")

        location_data = restaurant[:businesses][0][:location][:display_address].join(", ")

        expect(location_data).to be_a(String)
        expect(location_data).to eq("132 W 29th St, Pueblo, CO 81008")
      end

      it "has the needed food data" do
        restaurant = YelpService.get_restaurant("pueblo,co", "chinese")
        food_data = restaurant[:businesses][0][:categories][0][:title]

        expect(food_data).to be_a(String)
        expect(food_data).to eq("Chinese")
      end
    end
  end
end
