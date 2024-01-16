require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email).with_message("Cannot be left blank") }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value("john@example.com").for(:email) }
    it { should_not allow_value("john.com").for(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:password).on(:create) }
  end

  describe "class methods" do
    describe ".valid_params?" do
      it "checks if passwords are the same" do
        user_params = {
          password: "password",
          password_confirmation: "password"
        }

        expect(User.valid_params?(user_params)).to eq(true)
      end

      it "checks if passwords are the same" do
        user_params = {
          password: "password",
          password_confirmation: "password123"
        }
        expect { User.valid_params?(user_params) }.to raise_error(ActiveRecord::StatementInvalid)
      end
    end
  end
end
