class Page < ApplicationRecord
  validates_presence_of   :url
  validates_uniqueness_of :url

  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :users

  def base_comments
    comments.where(parent_id: nil)
  end
end
