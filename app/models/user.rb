class User < ApplicationRecord
  validates :username, :password, presence: true
end
