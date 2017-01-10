class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :token, :score, :created_at
end
