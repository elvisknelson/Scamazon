class ProductOrder < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_id, :order_id, :quantity, numericality: true
  validates :product_id, :order_id, :quantity, presence: true
end
