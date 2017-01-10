require 'rails_helper'

RSpec.describe User, type: :model do

  describe "enums" do
    it "role" do
      j = User.create(name: "joey", email: "joey@hotmail.com", password: "p", password_confirmation: "p")

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
    it { should have_secure_password }
    it { should validate_length_of :name }

    it "doesn't allow spaces or s.characters in name" do
      user = User.new(name: "n d", email: "e", password: "p", password_confirmation: "p")
      user2 = User.new(name: "n&$", email: "e", password: "p", password_confirmation: "p")

      expect(user).to be_invalid
      expect(user2).to be_invalid
    end
  end

  describe "relationships" do
    it { should respond_to :comments }
    it { should respond_to :pages }
    it { should respond_to :ups }
    it { should respond_to :status }
    it { should respond_to :token }
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

    it "#confirmed" do
      user = create(:user)

      expect(user.status).to eq("pending")
      expect(user.token).to eq(nil)

      user.confirmed!

      expect(user.status).to eq("confirmed")
      expect(user.token.length).to eq(50)
    end

    it "#score" do
      user, user2 = create_list(:user, 2)
      page = create(:page)
      comment = user.comment("Nice page!", page)

      expect(user.score).to eq(0)
      expect(user2.score).to eq(0)

      user2.upvote(comment)

      expect(user.score).to eq(1)
    end
  end
end
