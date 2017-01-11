require 'rails_helper'

describe Api::V1::PagesController do
  context '/me' do
    it 'returns me data' do
      reddit = Page.create(url: "https://www.reddit.com/")
      user, user2 = create_list(:user, 2)
      user.confirmed!
      user2.confirmed!

      comment = user.comment("Hey Reddit!", reddit)
      comment2 = user2.comment("Oh, hey!", reddit, comment)
      user.upvote(comment2)

      get '/api/v1/me', params: { token: user2.token }
      me = JSON.parse(response.body, symbolize_names: true)

      expect(me[:name]).to eq(user2.name)
      expect(me[:email]).to eq(user2.email)
      expect(me[:score]).to eq(1)
    end
  end

  context '/create' do
    it "returns a success message" do

      post '/api/v1/users', params: { name: "j", email: "j", password: "j", password_confirmation: "j" }
      message = response.body

      expect(message).to eq("{\"success\":\"account created\"}")
    end
  end

  context 'create sad path mismatch' do
    it "returns an error message" do

      post '/api/v1/users', params: { name: "j", email: "j", password: "t", password_confirmation: "j" }
      message = response.body

      expect(message).to eq("passwords don't match")
    end
  end

  context 'create sad path email taken' do
    it "returns an error message" do
      User.create(name: "j", email: "j", password: "j", password_confirmation: "j")

      post '/api/v1/users', params: { name: "t", email: "j", password: "j", password_confirmation: "j" }
      message = response.body

      expect(message).to eq("email has already been taken")
    end
  end

  context 'create sad path name taken' do
    it "returns an error message" do
      User.create(name: "j", email: "j", password: "j", password_confirmation: "j")

      post '/api/v1/users', params: { name: "j", email: "t", password: "j", password_confirmation: "j" }
      message = response.body

      expect(message).to eq("username has already been taken")
    end
  end
end
