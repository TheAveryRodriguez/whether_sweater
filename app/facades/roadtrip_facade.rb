class RoadtripFacade
  def self.get_roadtrip(origin, destination)
    data = MapquestService.get_directions(origin, destination)
    time_info = data[:route][:formattedTime]

    Route.new(time_info, origin, destination)
  end
end
