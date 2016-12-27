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
end
