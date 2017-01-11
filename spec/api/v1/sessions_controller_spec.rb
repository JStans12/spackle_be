require 'rails_helper'

describe Api::V1::SessionsController do
  context "/create" do
    it "returns the users information" do
      user = create(:user)
      user.confirmed!

      post '/api/v1/login', params: { name: user.name, password: "p" }
      user_data = JSON.parse(response.body, symbolize_names: true)

      expect(user_data[:name]).to eq(user.name)
      expect(user_data[:email]).to eq(user.email)
    end
  end

  context "create sad path unconfimred user" do
    it "returns the users information" do
      user = create(:user)

      post '/api/v1/login', params: { name: user.name, password: "p" }
      message = response.body

      expect(response.body).to eq("email is not comfirmed")
    end
  end

  context "create sad path bad creds" do
    it "returns the users information" do
      user = create(:user)
      user.confirmed!

      post '/api/v1/login', params: { name: user.name, password: "j" }
      message = response.body

      expect(response.body).to eq("invalid credentials")
    end
  end
end
