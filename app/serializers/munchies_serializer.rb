class MunchiesSerializer
  def self.munchies_data(current, restaurant, location)
    {
      data: {
        id: "null",
        type: "munchie",
        attributes: {
          destination_city: location,
          forecast: {
            summary: current.condition,
            temperature: current.temperature
          },
          restaurant: {
            name: restaurant.name,
            address: restaurant.address,
            rating: restaurant.rating,
            reviews: restaurant.reviews
          }
        }
      }
    }
  end
end
