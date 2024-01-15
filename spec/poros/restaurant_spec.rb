require "rails_helper"

RSpec.describe Restaurant do
  it "exists" do
    attributes = {
      name: "Lin Express Chinese Restaurant",
      location: {
        display_address: ["132 W 29th St, Pueblo, CO 81008"]
      },
      rating: 5.0,
      review_count: 5
    }

    restaurant = Restaurant.new(attributes)

    expect(restaurant).to be_a(Restaurant)
    expect(restaurant.name).to eq("Lin Express Chinese Restaurant")
    expect(restaurant.address).to eq("132 W 29th St, Pueblo, CO 81008")
    expect(restaurant.rating).to eq(5.0)
    expect(restaurant.reviews).to eq(5)
  end
end
