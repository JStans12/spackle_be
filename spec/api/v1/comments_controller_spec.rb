require 'rails_helper'

describe Api::V1::CommentsController do
  context "create" do
    it "returns success message and creates comment" do
      reddit = Page.create(url: "https://www.reddit.com/")
      user = create(:user)
      user.confirmed!

      post "/api/v1/users/#{user.id}/comments", params: { parent_id: 0, body: "WOO", token: user.token }, headers: {'HTTP_URL': reddit.url}
      message = response.body

      expect(message).to eq("comment created")
      expect(Comment.count).to eq(1)
      expect(Comment.first.body).to eq("WOO")
    end
  end
end
