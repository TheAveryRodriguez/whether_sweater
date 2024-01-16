class RoadtripSerializer
  def self.create_roadtrip(roadtrip_info, weather)
    {
      data: {
        id: "null",
        type: "road_trip",
        attributes: {
          start_city: roadtrip_info.origin,
          end_city: roadtrip_info.destination,
          travel_time: roadtrip_info.travel_time,
          weather_at_eta: if roadtrip_info.travel_time != "Impossible"
                            {
                              datetime: roadtrip_info.date_time,
                              temperature: weather.temperature,
                              condition: weather.condition
                            }
                          else
                            ""
                          end
        }
      }
    }
  end
end
