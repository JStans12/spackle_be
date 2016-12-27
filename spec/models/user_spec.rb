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
  end
end
