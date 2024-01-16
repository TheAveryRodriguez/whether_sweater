require "rails_helper"

RSpec.describe Roadtrip, type: :model do
  describe "class methods" do
    describe "valid_key?" do
      it "will return true is a user with the api key exists" do
        create_user = {
          email: "email@email.com",
          password: "password123",
          password_confirmation: "password123"
        }

        user = User.create!(create_user)

        params = {
          origin: "Conway,AR",
          destination: "Dallas,TX",
          api_key: user.api_key
        }

        expect(Roadtrip.valid_key?(params)).to eq(true)
      end

      it "will raise an error if no user with that key exists" do
        create_user = {
          email: "email@email.com",
          password: "password",
          password_confirmation: "password"
        }

        User.create!(create_user)

        params = {
          origin: "Cincinatti,OH",
          destination: "Chicago,IL",
          api_key: "wrong_key"
        }

        expect { Roadtrip.valid_key?(params) }.to raise_error(ActiveRecord::StatementInvalid)
      end
    end
  end
end
