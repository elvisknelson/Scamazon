class User < ApplicationRecord
  belongs_to :province
  validates :username, :password, presence: true
end
