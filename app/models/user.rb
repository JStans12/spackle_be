class User < ApplicationRecord
  enum role: ["user", "admin"]
  validates_presence_of   :name, :email
  validates_uniqueness_of :name, :email
end
