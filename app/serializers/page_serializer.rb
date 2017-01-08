class PageSerializer < ActiveModel::Serializer
  attributes :comments

  def comments
    object.base_comments.by_score.map do |comment|
      CommentSerializer.new(comment)
    end
  end
end
