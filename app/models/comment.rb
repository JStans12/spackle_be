class Comment < ApplicationRecord
  validates_presence_of :body
  validates :body, length: { maximum: 10000 }

  belongs_to :user
  belongs_to :page
  has_many :ups, dependent: :destroy

  belongs_to :parent, class_name: "Comment", foreign_key: "parent_id", required: false
  has_many :children, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy

  def self.by_score
    select('comments.*', 'sum(ups.value) AS score')
    .joins(:ups)
    .group('id')
    .order('score DESC')
  end

  def score
    ups.sum(:value)
  end
end
