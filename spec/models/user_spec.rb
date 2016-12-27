require 'rails_helper'

RSpec.describe User, type: :model do

  describe "enums" do
    it "role" do
      j = User.create(name: "joey", email: "joey@hotmail.com")

      expect(j.role).to eq("user")
      j.admin!
      expect(j.role).to eq("admin")
    end
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :name }
    it { should validate_uniqueness_of :email }
  end

  describe "relationships" do
    it { should respond_to :comments }
    it { should respond_to :pages }
    it { should respond_to :ups }
  end

  describe "model methods" do
    it "#comment" do
      user = create(:user)
      page = create(:page)
      comment = user.comment("Nice page!", page)

      expect(comment.body).to eq("Nice page!")
      expect(comment.user).to eq(user)
      expect(comment.page).to eq(page)
      expect(comment.parent).to eq(nil)

      comment2 = user.comment("This page sucks!", page, comment)

      expect(comment2.body).to eq("This page sucks!")
      expect(comment2.user).to eq(user)
      expect(comment2.page).to eq(page)
      expect(comment2.parent).to eq(comment)
    end

    it "#upvote" do
      user = create(:user)
      page = create(:page)
      comment = user.comment("Nice page!", page)
      vote = user.upvote(comment)

      expect(vote.user).to eq(user)
      expect(vote.comment).to eq(comment)
      expect(vote.value).to eq(1)
    end

    it "#downvote" do
      user = create(:user)
      page = create(:page)
      comment = user.comment("Nice page!", page)
      vote = user.downvote(comment)

      expect(vote.user).to eq(user)
      expect(vote.comment).to eq(comment)
      expect(vote.value).to eq(-1)
    end

    it "#novote" do
      user = create(:user)
      page = create(:page)
      comment = user.comment("Nice page!", page)
      vote = user.novote(comment)

      expect(vote.user).to eq(user)
      expect(vote.comment).to eq(comment)
      expect(vote.value).to eq(0)
    end
  end
end
