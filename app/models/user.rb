class User < ApplicationRecord
  enum role: ["user", "admin"]
  validates_presence_of   :name, :email
  validates_uniqueness_of :name, :email

  has_many :comments
  has_many :pages, through: :comments
  has_many :ups

  def comment(body, page, parent = nil)
    comment = comments.create(body: body, page_id: page.id)
    comment.update(parent_id: parent.id) if parent
    comment
  end
end
