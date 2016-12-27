class Comment < ApplicationRecord
  validates_presence_of :body

  belongs_to :user
  belongs_to :page
  has_many :ups, dependent: :destroy

  belongs_to :parent, class_name: "Comment", foreign_key: "parent_id", required: false
  has_many :children, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy

  def score
    ups.sum(:value)
  end
end
