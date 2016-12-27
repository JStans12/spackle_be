require 'rails_helper'

RSpec.describe Up, type: :model do

  describe "validations" do
    it { should validate_presence_of :value }

    it "validates uniquness of comment scoped to user" do
      user = create(:user)
      page = create(:page)
      comment = user.comment("Nice page!", page)
      user.upvote(comment)

      expect(user.ups.create(comment_id: comment.id, value: 1).id).to eq(nil)
    end
  end

  describe "relationships" do
    it { should respond_to :user }
    it { should respond_to :comment }
  end
end
