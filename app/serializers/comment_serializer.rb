class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :author, :parent_id, :created_at, :updated_at
  has_many :children

  def author
    AuthorSerializer.new(object.user).attributes
  end
end
