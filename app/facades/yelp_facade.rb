class YelpFacade
  def self.get_restaurant(destination, food)
    restaurant = YelpService.get_restaurant(destination, food)
    results = restaurant[:businesses][0]

    Restaurant.new(results)
  end
end
