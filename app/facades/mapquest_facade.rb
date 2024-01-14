class MapquestFacade
  def self.get_coordinates(location)
    coordinates = MapquestService.get_coordinates(location)
    results = coordinates[:results][0][:locations][0][:latLng]

    Location.new(results)
  end
end
