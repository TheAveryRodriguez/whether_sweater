require "rails_helper"

RSpec.describe "Create", type: :request do
  describe "POST /api/v0/users", :vcr do
    context "Sending information through the body" do
      it "should create a user", :vcr do
        headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload = {
          email: "fakeemail@email.com",
          password: "password123",
          password_confirmation: "password123"
        }
        body = JSON.generate(payload)

        post "/api/v0/users", headers: headers, params: body

        expect(response).to be_successful

        response_data = JSON.parse(response.body, symbolize_names: true)

        expect(response_data[:data]).to have_key(:id)
        expect(response_data[:data][:id]).to be_a(String)

        expect(response_data[:data]).to have_key(:type)
        expect(response_data[:data][:type]).to be_a(String)
        expect(response_data[:data][:type]).to eq("users")

        expect(response_data[:data]).to have_key(:attributes)
        expect(response_data[:data][:attributes]).to be_a(Hash)

        expect(response_data[:data][:attributes]).to have_key(:email)
        expect(response_data[:data][:attributes][:email]).to be_a(String)
        expect(response_data[:data][:attributes][:email]).to eq("fakeemail@email.com")

        expect(response_data[:data][:attributes]).to have_key(:api_key)
        expect(response_data[:data][:attributes][:api_key]).to be_a(String)

        expect(response_data[:data][:attributes]).to_not have_key(:password)
        expect(response_data[:data][:attributes]).to_not have_key(:password_confirmation)
      end
    end

    context "sad paths: Sending information through the body" do
      it "should not create a user if the user already exists", :vcr do
        headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload = {
          email: "fakeemail@email.com",
          password: "password123",
          password_confirmation: "password123"
        }
        body = JSON.generate(payload)

        post "/api/v0/users", headers: headers, params: body

        headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload = {
          email: "fakeemail@email.com",
          password: "password123",
          password_confirmation: "password123"
        }
        body = JSON.generate(payload)

        post "/api/v0/users", headers: headers, params: body

        response_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(409)

        expect(response_data).to have_key(:errors)
        expect(response_data[:errors].first).to have_key(:detail)

        expect(response_data[:errors].first[:detail]).to eq("Validation failed: Email has already been taken")
      end

      it "should not create a user if the password does not match", :vcr do
        headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload = {
          email: "fakeemail123@email.com",
          password: "password",
          password_confirmation: "password123"
        }
        body = JSON.generate(payload)

        post "/api/v0/users", headers: headers, params: body

        response_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)

        expect(response_data).to have_key(:errors)
        expect(response_data[:errors].first).to have_key(:detail)
        expect(response_data[:errors].first[:detail]).to eq("Passwords don't match, try again.")
      end

      it "should not create a user if email is empty", :vcr do
        headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload = {
          email: "",
          password: "password123",
          password_confirmation: "password123"
        }
        body = JSON.generate(payload)

        post "/api/v0/users", headers: headers, params: body

        response_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(409)

        expect(response_data).to have_key(:errors)
        expect(response_data[:errors].first).to have_key(:detail)
        expect(response_data[:errors].first[:detail]).to eq("Validation failed: Email Cannot be left blank, Email is invalid")
      end

      it "should not create a user if password is empty", :vcr do
        headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload = {
          email: "fakeemail123@email.com",
          password: "",
          password_confirmation: "password123"
        }
        body = JSON.generate(payload)

        post "/api/v0/users", headers: headers, params: body

        response_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)

        expect(response_data).to have_key(:errors)
        expect(response_data[:errors].first).to have_key(:detail)
        expect(response_data[:errors].first[:detail]).to eq("Passwords don't match, try again.")
      end

      it "should not create a user if password and confirmation are empty", :vcr do
        headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
        payload = {
          email: "fakeemail123@email.com",
          password: "",
          password_confirmation: ""
        }
        body = JSON.generate(payload)

        post "/api/v0/users", headers: headers, params: body

        response_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response).to have_http_status(409)

        expect(response_data).to have_key(:errors)
        expect(response_data[:errors].first).to have_key(:detail)
        expect(response_data[:errors].first[:detail]).to eq("Validation failed: Password digest can't be blank, Password can't be blank, Password can't be blank")
      end
    end
  end
end
