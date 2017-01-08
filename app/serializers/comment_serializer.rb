class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :author, :parent_id, :created_at, :updated_at, :score, :ups
  has_many :children

  def author
    AuthorSerializer.new(object.user).attributes
  end

  def children
    object.children.by_score
  end

  def ups
    object.ups.map do |up|
      UpSerializer.new(up)
    end
  end
end
