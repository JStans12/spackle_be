class PageSerializer < ActiveModel::Serializer
  attributes :id, :comments, :ups

  def comments
    object.base_comments.map do |comment|
      CommentSerializer.new(comment)
    end
  end
end
