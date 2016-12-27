require 'rails_helper'

RSpec.describe Up, type: :model do

  describe "validations" do
    it { should validate_presence_of :value }
  end

  describe "relationships" do
    it { should respond_to :user }
    it { should respond_to :comment }
  end
end
