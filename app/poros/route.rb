class Route
  attr_reader :travel_time, :origin, :destination, :hour, :date_time

  def initialize(time_info, origin, destination)
    @travel_time = impossible?(time_info)
    @date_time = format_datetime(time_info)
    @hour = format_hour(time_info)
    @origin = origin
    @destination = destination
  end

  def impossible?(time_info)
    if time_info.nil?
      "Impossible"
    else
      time_info
    end
  end

  def format_datetime(time_info)
    new_time = Time.now + time_info.to_i.hours
    new_time.to_s.slice(0..12)
  end

  def format_hour(time_info)
    new_time = Time.now + time_info.to_i.hours
    new_time.to_s.split[1].slice(0..4).to_i
  end
end
