class GeocodeFacade
  def self.geocode
    json = GeocodeApiService.geocode(city, state)

    
end
