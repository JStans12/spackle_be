class Up < ApplicationRecord
  validates_presence_of :value
  validates_uniqueness_of :comment_id, scope: :user_id

  belongs_to :user
  belongs_to :comment
end
