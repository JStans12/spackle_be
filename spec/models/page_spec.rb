require 'rails_helper'

RSpec.describe Page, type: :model do

  describe "validations" do
    it { should validate_presence_of :url }
    it { should validate_uniqueness_of :url }
  end

  describe "relationships" do
    it { should respond_to :comments }
    it { should respond_to :commenters }
  end

  describe "model methods" do
    context "#base_comments" do
      it "returns comments where parent_id is nil" do
        user = create(:user)
        page, page2 = create_list(:page, 2)
        comment = user.comment("stuff", page)
        comment2 = user.comment("stuff", page, comment)
        comment3 = user.comment("stuff", page)
        comment4 = user.comment("stuff", page2)

        expect(page.base_comments).to include(comment)
        expect(page.base_comments).to include(comment3)
        expect(page.base_comments).to_not include(comment2)
        expect(page.base_comments).to_not include(comment4)
      end
    end
  end
end
