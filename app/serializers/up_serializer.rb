class UpSerializer < ActiveModel::Serializer
  attributes :value, :user_id, :comment_id
end
