class Up < ApplicationRecord
  validates_presence_of :value

  belongs_to :user
  belongs_to :comment
end
