class User < ApplicationRecord
  enum role: ["user", "admin"]
  validates_presence_of   :name, :email
  validates_uniqueness_of :name, :email

  has_many :comments, dependent: :destroy
  has_many :pages, through: :comments
  has_many :ups, dependent: :destroy

  def comment(body, page, parent = nil)
    comment = comments.create(body: body, page_id: page.id)
    comment.update(parent_id: parent.id) if parent
    comment
  end

  def upvote(comment)
    vote = ups.find_or_create_by(comment_id: comment.id)
    vote.update(value: 1)
    vote
  end

  def downvote(comment)
    vote = ups.find_or_create_by(comment_id: comment.id)
    vote.update(value: -1)
    vote
  end

  def novote(comment)
    vote = ups.find_or_create_by(comment_id: comment.id)
    vote.update(value: 0)
    vote
  end
end
