class Forecast < ApplicationRecord
  def self.location_present(location)
    if location != ""
      location
    else
      raise ActiveRecord::StatementInvalid, "Location can not be empty"
    end
  end
end
