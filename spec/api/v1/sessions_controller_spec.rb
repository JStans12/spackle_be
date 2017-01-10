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
end
