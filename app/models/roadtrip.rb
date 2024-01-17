class Roadtrip < ApplicationRecord
  def self.valid_key?(params)
    user = User.find_by(api_key: params[:api_key])
    if user
      true
    else
      raise ActiveRecord::StatementInvalid, "Key not Authorized"
    end
  end
end
