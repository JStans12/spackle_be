require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe "validatons" do
    it { should validate_presence_of :body }
    it { should validate_length_of :body }
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

      expect(comment.score).to eq(1)

      user2.upvote(comment)
      expect(comment.score).to eq(2)

      user3.downvote(comment)
      expect(comment.score).to eq(1)

      user1.novote(comment)
      expect(comment.score).to eq(0)
    end

    context "#by_score" do
      it "sorts a group of comments by score" do
        user1, user2 = create_list(:user, 2)
        page = create(:page)

        comment = user1.comment("Nice page!", page)
        comment2 = user1.comment("Dumb page!", page)
        comment3 = user1.comment("Decent page!", page)

        user2.upvote(comment)
        user2.downvote(comment2)

        expect(Comment.by_score).to eq([comment, comment3, comment2])
      end
    end
  end
end
