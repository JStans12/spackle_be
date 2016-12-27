class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :author, :parent_id, :created_at, :updated_at

  def author
    AuthorSerializer.new(object.user).attributes
  end
end
