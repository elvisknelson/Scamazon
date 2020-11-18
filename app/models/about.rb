class About < ApplicationRecord
  validates :header, :content, presence: true
end
