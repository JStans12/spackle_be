require 'rails_helper'

describe Api::V1::UpsController do
  context "create" do
    it "returns a success message" do
      reddit = Page.create(url: "https://www.reddit.com/")
      user = create(:user)
      user.confirmed!
      comment = user.comment("Hey Reddit!", reddit)

      post "/api/v1/users/#{user.id}/ups", params: { token: user.token, comment_id: comment.id, value: -1 }
      message = response.body

      expect(message).to eq("{\"success\":\"vote tallied\"}")
      expect(comment.score).to eq(-1)
    end
  end

  context "create same value" do
    it "returns a success message" do
      reddit = Page.create(url: "https://www.reddit.com/")
      user = create(:user)
      user.confirmed!
      comment = user.comment("Hey Reddit!", reddit)

      post "/api/v1/users/#{user.id}/ups", params: { token: user.token, comment_id: comment.id, value: 1 }
      message = response.body

      expect(message).to eq("{\"success\":\"vote tallied\"}")
      expect(comment.score).to eq(0)
    end
  end

  context "create sadpath" do
    it "returns a failure message" do

      reddit = Page.create(url: "https://www.reddit.com/")
      user = create(:user)
      user.confirmed!
      comment = user.comment("Hey Reddit!", reddit)

      post "/api/v1/users/#{user.id}/ups", params: { token: 555, comment_id: comment.id, value: -1 }
      message = response.body

      expect(message).to eq("{\"failure\":\"invalid credentials\"}")
    end
  end
end
