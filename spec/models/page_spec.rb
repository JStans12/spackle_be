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
end
