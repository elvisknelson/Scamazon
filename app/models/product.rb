class Product < ApplicationRecord
  belongs_to :category

  validates :price, :quantity, :category_id, :rating, numericality: true
  validates :name, :price, :quantity, :category_id, :description, :on_sale, :rating, presence: true

  has_one_attached :image
end
