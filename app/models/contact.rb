class Contact < ApplicationRecord
  validates :header, :content, :name, :email, :address, :footer, presence: true
end
