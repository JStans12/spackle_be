require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe "validatons" do
    it { should validate_presence_of :body }
  end

  describe "relationships" do
    it { should respond_to :user }
    it { should respond_to :page }
    it { should respond_to :ups }
    it { should respond_to :parent }
    it { should respond_to :children }
  end

  describe "model methods" do

    it "#score" do
      user1, user2, user3 = create_list(:user, 3)
      page = create(:page)
      comment = user1.comment("Nice page!", page)

      user1.upvote(comment)
      expect(comment.score).to eq(1)

      user2.upvote(comment)
      expect(comment.score).to eq(2)

      user3.downvote(comment)
      expect(comment.score).to eq(1)

      user1.novote(comment)
      expect(comment.score).to eq(0)
    end
  end
end
